import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:vanish_link/features/chat/domain/entities/notification_payload.dart';
import 'package:vanish_link/features/chat/domain/services/backend_notification_client.dart';

class MockHttpClient extends http.BaseClient {
  final List<http.Request> capturedRequests = [];
  int requestCount = 0;
  int failCount = 0;
  int successStatus = 200;

  MockHttpClient({this.failCount = 0, this.successStatus = 200});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    requestCount++;
    if (request is http.Request) {
      capturedRequests.add(request);
    }
    
    if (requestCount <= failCount) {
      return http.StreamedResponse(
        Stream.value(utf8.encode('Internal Server Error')),
        500,
      );
    }
    
    return http.StreamedResponse(
      Stream.value(utf8.encode('{"status":"ok"}')),
      successStatus,
    );
  }
}

void main() {
  setUp(() {
    dotenv.loadFromString(envString: 'SERVER_URL=https://api.vanishlink.test\nSERVER_API_KEY=test_api_key_123');
  });

  group('BackendNotificationClient Tests', () {
    test('Successful single attempt delivery', () async {
      final mockClient = MockHttpClient();
      final backendClient = BackendNotificationClient(client: mockClient);

      final payload = NotificationPayload(
        id: 'test_msg_id',
        type: NotificationType.newMessage,
        title: 'New Message',
        body: 'Hello World',
        senderId: 'sender_A',
        receiverId: 'receiver_B',
        chatId: 'chat_X',
        createdAt: DateTime.now(),
      );

      final result = await backendClient.sendNotification(
        tokens: ['token1', 'token2', 'token1', ''],
        title: 'New Message',
        body: 'Hello World',
        payload: payload,
      );

      expect(result, isTrue);
      expect(mockClient.requestCount, 1);

      final req = mockClient.capturedRequests.first;
      expect(req.url.toString(), 'https://api.vanishlink.test/notifications');
      expect(req.headers['X-API-KEY'], 'test_api_key_123');
      expect(req.headers['Content-Type'], 'application/json');

      final body = jsonDecode(req.body);
      expect(body['tokens'], ['token1', 'token2']); // Deduplicated, empty removed
      expect(body['title'], 'New Message');
      expect(body['body'], 'Hello World');
      expect(body['data']['id'], 'test_msg_id');
      expect(body['data']['type'], 'newMessage');
      expect(body['data']['senderId'], 'sender_A');
      expect(body['data']['receiverId'], 'receiver_B');
    });

    test('Retries on failure and eventually succeeds', () async {
      final mockClient = MockHttpClient(failCount: 2);
      final backendClient = BackendNotificationClient(client: mockClient);

      final payload = NotificationPayload(
        id: 'test_call_id',
        type: NotificationType.incomingCall,
        title: 'Incoming Call',
        body: 'Incoming call from A',
        senderId: 'sender_A',
        receiverId: 'receiver_B',
        callId: 'call_C',
        createdAt: DateTime.now(),
      );

      final result = await backendClient.sendNotification(
        tokens: ['token_xyz'],
        title: 'Incoming Call',
        body: 'Incoming call from A',
        payload: payload,
      );

      expect(result, isTrue);
      expect(mockClient.requestCount, 3); // 2 fails + 1 success
    });

    test('Fails completely after exceeding retries', () async {
      final mockClient = MockHttpClient(failCount: 5);
      final backendClient = BackendNotificationClient(client: mockClient);

      final payload = NotificationPayload(
        id: 'test_sys_id',
        type: NotificationType.system,
        title: 'System alert',
        body: 'Maintenance schedule',
        createdAt: DateTime.now(),
      );

      final result = await backendClient.sendNotification(
        tokens: ['token_abc'],
        title: 'System alert',
        body: 'Maintenance schedule',
        payload: payload,
      );

      expect(result, isFalse);
      expect(mockClient.requestCount, 3); // Max retries is 3
    });
  });
}
