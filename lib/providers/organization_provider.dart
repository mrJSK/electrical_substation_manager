import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'organization_provider.g.dart';

@riverpod
Map<String, dynamic> organizationConfig(OrganizationConfigRef ref) {
  // Return default configuration - in production this would come from database
  return {
    'name': 'Default Organization',
    'hierarchy': [],
    'permissions': {},
    'branding': {
      'primaryColor': '#2196F3',
      'logoUrl': '',
    },
    'features': {
      'notifications': true,
      'reports': true,
      'analytics': true,
    },
  };
}
