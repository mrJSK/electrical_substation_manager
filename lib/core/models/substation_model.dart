import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

part 'substation_model.freezed.dart';
part 'substation_model.g.dart';

@freezed
class SubstationModel with _$SubstationModel {
  const SubstationModel._();

  const factory SubstationModel({
    required String id,
    required String name,
    required String code,
    String? description,
    required String organizationId,
    required SubstationLocation location,
    required String voltageLevel, // '132KV', '220KV', '400KV', etc.
    required SubstationType type,
    required SubstationStatus status,
    @Default([]) List<String> equipmentIds,
    @Default({}) Map<String, dynamic> technicalSpecs,
    String? operatorId,
    String? maintenanceSchedule,
    @TimestampConverter() DateTime? lastMaintenanceDate,
    @TimestampConverter() DateTime? nextMaintenanceDate,
    @TimestampConverter() DateTime? commissioningDate,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _SubstationModel;

  factory SubstationModel.fromJson(Map<String, dynamic> json) =>
      _$SubstationModelFromJson(json);

  factory SubstationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return SubstationModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Helper methods
  bool get isOperational => status == SubstationStatus.operational;
  bool get needsMaintenance =>
      nextMaintenanceDate != null &&
      DateTime.now().isAfter(nextMaintenanceDate!);

  int get equipmentCount => equipmentIds.length;
  String get displayName => '$name ($code)';

  Duration? get timeSinceLastMaintenance {
    if (lastMaintenanceDate == null) return null;
    return DateTime.now().difference(lastMaintenanceDate!);
  }
}

@freezed
class SubstationLocation with _$SubstationLocation {
  const SubstationLocation._();

  const factory SubstationLocation({
    required double latitude,
    required double longitude,
    required String address,
    String? city,
    String? state,
    String? pincode,
    String? landmark,
  }) = _SubstationLocation;

  factory SubstationLocation.fromJson(Map<String, dynamic> json) =>
      _$SubstationLocationFromJson(json);

  // Helper methods
  String get fullAddress {
    final parts =
        [address, city, state, pincode].where((p) => p != null).join(', ');
    return landmark != null ? '$parts (Near $landmark)' : parts;
  }

  bool get hasValidCoordinates =>
      latitude >= -90 &&
      latitude <= 90 &&
      longitude >= -180 &&
      longitude <= 180;
}

@freezed
class EquipmentModel with _$EquipmentModel {
  const EquipmentModel._();

  const factory EquipmentModel({
    required String id,
    required String substationId,
    required String name,
    required String equipmentType, // 'transformer', 'breaker', 'relay', etc.
    required String manufacturer,
    required String model,
    String? serialNumber,
    required EquipmentStatus status,
    @Default({}) Map<String, dynamic> specifications,
    @Default({}) Map<String, dynamic> currentReadings,
    String? assignedTechnicianId,
    @TimestampConverter() DateTime? installationDate,
    @TimestampConverter() DateTime? lastInspectionDate,
    @TimestampConverter() DateTime? nextInspectionDate,
    @TimestampConverter() DateTime? warrantyExpiryDate,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? updatedAt,
  }) = _EquipmentModel;

  factory EquipmentModel.fromJson(Map<String, dynamic> json) =>
      _$EquipmentModelFromJson(json);

  factory EquipmentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EquipmentModel.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Helper methods
  bool get isOperational => status == EquipmentStatus.operational;
  bool get needsInspection =>
      nextInspectionDate != null && DateTime.now().isAfter(nextInspectionDate!);
  bool get isUnderWarranty =>
      warrantyExpiryDate != null &&
      DateTime.now().isBefore(warrantyExpiryDate!);

  String get displayName => '$name ($manufacturer $model)';

  Duration? get ageInService {
    if (installationDate == null) return null;
    return DateTime.now().difference(installationDate!);
  }
}

@freezed
class MaintenanceRecord with _$MaintenanceRecord {
  const MaintenanceRecord._();

  const factory MaintenanceRecord({
    required String id,
    required String equipmentId,
    required String substationId,
    required MaintenanceType type,
    required MaintenanceStatus status,
    required String description,
    String? findings,
    String? actions,
    String? technicianId,
    @Default([]) List<String> photoUrls,
    @Default({}) Map<String, dynamic> measurements,
    @Default({}) Map<String, String> partsUsed,
    @TimestampConverter() DateTime? scheduledDate,
    @TimestampConverter() DateTime? startTime,
    @TimestampConverter() DateTime? endTime,
    @TimestampConverter() DateTime? createdAt,
  }) = _MaintenanceRecord;

  factory MaintenanceRecord.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceRecordFromJson(json);

  factory MaintenanceRecord.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MaintenanceRecord.fromJson({...data, 'id': doc.id});
  }

  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id');
    return json;
  }

  // Helper methods
  bool get isCompleted => status == MaintenanceStatus.completed;
  bool get isOverdue => status == MaintenanceStatus.overdue;
  bool get isInProgress => status == MaintenanceStatus.inProgress;

  Duration? get duration {
    if (startTime == null || endTime == null) return null;
    return endTime!.difference(startTime!);
  }

  bool get hasPhotos => photoUrls.isNotEmpty;
  bool get hasFindings => findings != null && findings!.isNotEmpty;
}

enum SubstationType {
  @JsonValue('transmission')
  transmission,
  @JsonValue('distribution')
  distribution,
  @JsonValue('switching')
  switching,
  @JsonValue('collector')
  collector,
}

enum SubstationStatus {
  @JsonValue('operational')
  operational,
  @JsonValue('maintenance')
  maintenance,
  @JsonValue('outage')
  outage,
  @JsonValue('decommissioned')
  decommissioned,
}

enum EquipmentStatus {
  @JsonValue('operational')
  operational,
  @JsonValue('maintenance')
  maintenance,
  @JsonValue('faulty')
  faulty,
  @JsonValue('offline')
  offline,
  @JsonValue('decommissioned')
  decommissioned,
}

enum MaintenanceType {
  @JsonValue('preventive')
  preventive,
  @JsonValue('corrective')
  corrective,
  @JsonValue('predictive')
  predictive,
  @JsonValue('emergency')
  emergency,
}

enum MaintenanceStatus {
  @JsonValue('scheduled')
  scheduled,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('overdue')
  overdue,
}
