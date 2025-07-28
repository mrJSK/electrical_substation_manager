// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      priority: $enumDecode(_$NotificationPriorityEnumMap, json['priority']),
      recipientId: json['recipientId'] as String,
      senderId: json['senderId'] as String?,
      data: json['data'] as Map<String, dynamic>? ?? const {},
      isRead: json['isRead'] as bool? ?? false,
      actionUrl: json['actionUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      expiresAt: const TimestampConverter().fromJson(json['expiresAt']),
      readAt: const TimestampConverter().fromJson(json['readAt']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'message': instance.message,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'priority': _$NotificationPriorityEnumMap[instance.priority]!,
      'recipientId': instance.recipientId,
      'senderId': instance.senderId,
      'data': instance.data,
      'isRead': instance.isRead,
      'actionUrl': instance.actionUrl,
      'imageUrl': instance.imageUrl,
      'expiresAt': const TimestampConverter().toJson(instance.expiresAt),
      'readAt': const TimestampConverter().toJson(instance.readAt),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.info: 'info',
  NotificationType.warning: 'warning',
  NotificationType.error: 'error',
  NotificationType.success: 'success',
  NotificationType.maintenance: 'maintenance',
  NotificationType.alert: 'alert',
  NotificationType.system: 'system',
};

const _$NotificationPriorityEnumMap = {
  NotificationPriority.low: 'low',
  NotificationPriority.medium: 'medium',
  NotificationPriority.high: 'high',
  NotificationPriority.critical: 'critical',
};
