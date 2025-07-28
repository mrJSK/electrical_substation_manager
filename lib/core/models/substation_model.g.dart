// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'substation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubstationModelImpl _$$SubstationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubstationModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      description: json['description'] as String?,
      organizationId: json['organizationId'] as String,
      location:
          SubstationLocation.fromJson(json['location'] as Map<String, dynamic>),
      voltageLevel: json['voltageLevel'] as String,
      type: $enumDecode(_$SubstationTypeEnumMap, json['type']),
      status: $enumDecode(_$SubstationStatusEnumMap, json['status']),
      equipmentIds: (json['equipmentIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      technicalSpecs:
          json['technicalSpecs'] as Map<String, dynamic>? ?? const {},
      operatorId: json['operatorId'] as String?,
      maintenanceSchedule: json['maintenanceSchedule'] as String?,
      lastMaintenanceDate:
          const TimestampConverter().fromJson(json['lastMaintenanceDate']),
      nextMaintenanceDate:
          const TimestampConverter().fromJson(json['nextMaintenanceDate']),
      commissioningDate:
          const TimestampConverter().fromJson(json['commissioningDate']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$SubstationModelImplToJson(
        _$SubstationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'organizationId': instance.organizationId,
      'location': instance.location,
      'voltageLevel': instance.voltageLevel,
      'type': _$SubstationTypeEnumMap[instance.type]!,
      'status': _$SubstationStatusEnumMap[instance.status]!,
      'equipmentIds': instance.equipmentIds,
      'technicalSpecs': instance.technicalSpecs,
      'operatorId': instance.operatorId,
      'maintenanceSchedule': instance.maintenanceSchedule,
      'lastMaintenanceDate':
          const TimestampConverter().toJson(instance.lastMaintenanceDate),
      'nextMaintenanceDate':
          const TimestampConverter().toJson(instance.nextMaintenanceDate),
      'commissioningDate':
          const TimestampConverter().toJson(instance.commissioningDate),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

const _$SubstationTypeEnumMap = {
  SubstationType.transmission: 'transmission',
  SubstationType.distribution: 'distribution',
  SubstationType.switching: 'switching',
  SubstationType.collector: 'collector',
};

const _$SubstationStatusEnumMap = {
  SubstationStatus.operational: 'operational',
  SubstationStatus.maintenance: 'maintenance',
  SubstationStatus.outage: 'outage',
  SubstationStatus.decommissioned: 'decommissioned',
};

_$SubstationLocationImpl _$$SubstationLocationImplFromJson(
        Map<String, dynamic> json) =>
    _$SubstationLocationImpl(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
      city: json['city'] as String?,
      state: json['state'] as String?,
      pincode: json['pincode'] as String?,
      landmark: json['landmark'] as String?,
    );

Map<String, dynamic> _$$SubstationLocationImplToJson(
        _$SubstationLocationImpl instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'pincode': instance.pincode,
      'landmark': instance.landmark,
    };

_$EquipmentModelImpl _$$EquipmentModelImplFromJson(Map<String, dynamic> json) =>
    _$EquipmentModelImpl(
      id: json['id'] as String,
      substationId: json['substationId'] as String,
      name: json['name'] as String,
      equipmentType: json['equipmentType'] as String,
      manufacturer: json['manufacturer'] as String,
      model: json['model'] as String,
      serialNumber: json['serialNumber'] as String?,
      status: $enumDecode(_$EquipmentStatusEnumMap, json['status']),
      specifications:
          json['specifications'] as Map<String, dynamic>? ?? const {},
      currentReadings:
          json['currentReadings'] as Map<String, dynamic>? ?? const {},
      assignedTechnicianId: json['assignedTechnicianId'] as String?,
      installationDate:
          const TimestampConverter().fromJson(json['installationDate']),
      lastInspectionDate:
          const TimestampConverter().fromJson(json['lastInspectionDate']),
      nextInspectionDate:
          const TimestampConverter().fromJson(json['nextInspectionDate']),
      warrantyExpiryDate:
          const TimestampConverter().fromJson(json['warrantyExpiryDate']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$EquipmentModelImplToJson(
        _$EquipmentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'substationId': instance.substationId,
      'name': instance.name,
      'equipmentType': instance.equipmentType,
      'manufacturer': instance.manufacturer,
      'model': instance.model,
      'serialNumber': instance.serialNumber,
      'status': _$EquipmentStatusEnumMap[instance.status]!,
      'specifications': instance.specifications,
      'currentReadings': instance.currentReadings,
      'assignedTechnicianId': instance.assignedTechnicianId,
      'installationDate':
          const TimestampConverter().toJson(instance.installationDate),
      'lastInspectionDate':
          const TimestampConverter().toJson(instance.lastInspectionDate),
      'nextInspectionDate':
          const TimestampConverter().toJson(instance.nextInspectionDate),
      'warrantyExpiryDate':
          const TimestampConverter().toJson(instance.warrantyExpiryDate),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

const _$EquipmentStatusEnumMap = {
  EquipmentStatus.operational: 'operational',
  EquipmentStatus.maintenance: 'maintenance',
  EquipmentStatus.faulty: 'faulty',
  EquipmentStatus.offline: 'offline',
  EquipmentStatus.decommissioned: 'decommissioned',
};

_$MaintenanceRecordImpl _$$MaintenanceRecordImplFromJson(
        Map<String, dynamic> json) =>
    _$MaintenanceRecordImpl(
      id: json['id'] as String,
      equipmentId: json['equipmentId'] as String,
      substationId: json['substationId'] as String,
      type: $enumDecode(_$MaintenanceTypeEnumMap, json['type']),
      status: $enumDecode(_$MaintenanceStatusEnumMap, json['status']),
      description: json['description'] as String,
      findings: json['findings'] as String?,
      actions: json['actions'] as String?,
      technicianId: json['technicianId'] as String?,
      photoUrls: (json['photoUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      measurements: json['measurements'] as Map<String, dynamic>? ?? const {},
      partsUsed: (json['partsUsed'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      scheduledDate: const TimestampConverter().fromJson(json['scheduledDate']),
      startTime: const TimestampConverter().fromJson(json['startTime']),
      endTime: const TimestampConverter().fromJson(json['endTime']),
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
    );

Map<String, dynamic> _$$MaintenanceRecordImplToJson(
        _$MaintenanceRecordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'equipmentId': instance.equipmentId,
      'substationId': instance.substationId,
      'type': _$MaintenanceTypeEnumMap[instance.type]!,
      'status': _$MaintenanceStatusEnumMap[instance.status]!,
      'description': instance.description,
      'findings': instance.findings,
      'actions': instance.actions,
      'technicianId': instance.technicianId,
      'photoUrls': instance.photoUrls,
      'measurements': instance.measurements,
      'partsUsed': instance.partsUsed,
      'scheduledDate':
          const TimestampConverter().toJson(instance.scheduledDate),
      'startTime': const TimestampConverter().toJson(instance.startTime),
      'endTime': const TimestampConverter().toJson(instance.endTime),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };

const _$MaintenanceTypeEnumMap = {
  MaintenanceType.preventive: 'preventive',
  MaintenanceType.corrective: 'corrective',
  MaintenanceType.predictive: 'predictive',
  MaintenanceType.emergency: 'emergency',
};

const _$MaintenanceStatusEnumMap = {
  MaintenanceStatus.scheduled: 'scheduled',
  MaintenanceStatus.inProgress: 'in_progress',
  MaintenanceStatus.completed: 'completed',
  MaintenanceStatus.cancelled: 'cancelled',
  MaintenanceStatus.overdue: 'overdue',
};
