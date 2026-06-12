import 'package:freezed_annotation/freezed_annotation.dart';

part 'call_model.freezed.dart';
part 'call_model.g.dart';

@freezed
class CallModel with _$CallModel {
  const factory CallModel({
    required String callId,
    required String callerId,
    required String receiverId,
    required String type, // 'voice', 'video'
    required String status, // 'calling', 'ringing', 'accepted', 'declined', 'missed', 'ended', 'cancelled'
    required int createdAt, // Milliseconds since epoch
    int? acceptedAt, // Milliseconds since epoch
    int? endedAt, // Milliseconds since epoch
    @Default(0) int duration, // In seconds
  }) = _CallModel;

  factory CallModel.fromJson(Map<String, dynamic> json) => _$CallModelFromJson(json);
}
