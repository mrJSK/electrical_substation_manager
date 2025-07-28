import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const NotificationModel._();

  const factory NotificationModel({
    required String id,
    required String title,
    required String message,
    required NotificationType type,
    required NotificationPriority priority,
    required String recipientId,
    String? senderId,
    @Default({}) Map<String, dynamic> data,
    @Default(false) bool isRead,
    String? actionUrl,
    String? imageUrl,
    @TimestampConverter() DateTime? expiresAt,
    @TimestampConverter() DateTime? readAt,
    @TimestampConverter() DateTime? createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Helper methods
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isUnread => !isRead;
  bool get hasAction => actionUrl != null && actionUrl!.isNotEmpty;
  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

  Duration? get timeAgo {
    if (createdAt == null) return null;
    return DateTime.now().difference(createdAt!);
  }

  String get priorityIcon {
    switch (priority) {
      case NotificationPriority.low:
        return '🔵';
      case NotificationPriority.medium:
        return '🟡';
      case NotificationPriority.high:
        return '🟠';
      case NotificationPriority.critical:
        return '🔴';
    }
  }

  String get typeIcon {
    switch (type) {
      case NotificationType.info:
        return 'ℹ️';
      case NotificationType.warning:
        return '⚠️';
      case NotificationType.error:
        return '❌';
      case NotificationType.success:
        return '✅';
      case NotificationType.maintenance:
        return '🔧';
      case NotificationType.alert:
        return '🚨';
      case NotificationType.system:
        return '⚙️';
    }
  }
}

enum NotificationType {
  @JsonValue('info')
  info,
  @JsonValue('warning')
  warning,
  @JsonValue('error')
  error,
  @JsonValue('success')
  success,
  @JsonValue('maintenance')
  maintenance,
  @JsonValue('alert')
  alert,
  @JsonValue('system')
  system,
}

enum NotificationPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}
