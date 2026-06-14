import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:vanish_link/features/chat/domain/entities/notification_payload.dart';

class BackendNotificationClient {
  final http.Client _client;

  BackendNotificationClient({http.Client? client})
    : _client = client ?? http.Client();

  /// Sends a multicast push notification to the backend delivery service
  Future<bool> sendNotification({
    required List<String> tokens,
    required String title,
    required String body,
    required NotificationPayload payload,
  }) async {
    final serverUrl = dotenv.get("SERVER_URL");
    final apiKey = dotenv.get('SERVER_API_KEY');

    if (serverUrl.isEmpty || apiKey.isEmpty) {
      debugPrint(
        '[PUSH-BACKEND] Error: SERVER_URL or SERVER_API_KEY environment variables are missing.',
      );
      return false;
    }

    if (tokens.isEmpty) {
      debugPrint('[PUSH-MULTICAST] Tokens count: 0 (No valid tokens to send)');
      return false;
    }

    // Deduplicate and filter out empty tokens
    final List<String> targetTokens = tokens
        .where((t) => t.isNotEmpty)
        .toSet()
        .toList();

    if (targetTokens.isEmpty) {
      debugPrint(
        '[PUSH-MULTICAST] Tokens count: 0 (After filtering/deduplication)',
      );
      return false;
    }

    debugPrint('[PUSH-BACKEND] Sending notification');
    debugPrint('[PUSH-MULTICAST] Tokens count: ${targetTokens.length}');

    final url = Uri.parse('$serverUrl/notifications');

    // Prepare the payload. The data map should be flat strings as parsed by _parseRemoteMessage.
    final payloadMap = payload.toJson();
    final Map<String, String> dataMap = {};
    payloadMap.forEach((key, val) {
      if (key == 'data' && val is Map) {
        val.forEach((k, v) {
          dataMap[k.toString()] = v.toString();
        });
      } else if (val != null) {
        dataMap[key] = val.toString();
      }
    });

    final Map<String, dynamic> requestBody = {
      'token': targetTokens,
      'title': title,
      'body': body,
      'data': dataMap,
    };

    // Retry configuration
    int retryCount = 0;
    const int maxRetries = 3;
    bool success = false;

    while (retryCount < maxRetries && !success) {
      try {
        final response = await _client.post(
          url,
          headers: {'Content-Type': 'application/json', 'X-API-KEY': apiKey},
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          debugPrint('[PUSH-BACKEND] Delivery successful');
          success = true;
        } else {
          debugPrint(
            '[PUSH-BACKEND] Delivery failed with status: ${response.statusCode}, Body: ${response.body}',
          );
          retryCount++;
          if (retryCount < maxRetries) {
            await Future.delayed(Duration(seconds: 1 * retryCount));
          }
        }
      } catch (e) {
        debugPrint('[PUSH-BACKEND] Delivery failed with exception: $e');
        retryCount++;
        if (retryCount < maxRetries) {
          await Future.delayed(Duration(seconds: 1 * retryCount));
        }
      }
    }

    return success;
  }
}
