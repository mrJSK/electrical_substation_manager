import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'organizations_provider.g.dart';

@riverpod
class OrganizationsNotifier extends _$OrganizationsNotifier {
  @override
  Future<List<Map<String, dynamic>>> build() async {
    return await _fetchOrganizations();
  }

  Future<List<Map<String, dynamic>>> _fetchOrganizations() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('organizations')
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          ...doc.data(),
        };
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch organizations: $e');
    }
  }

  Future<void> createOrganization(Map<String, dynamic> organizationData) async {
    try {
      // Add organization to Firestore
      final docRef = await FirebaseFirestore.instance
          .collection('organizations')
          .add(organizationData);

      // Create default admin user for the organization
      await _createDefaultAdminUser(docRef.id, organizationData);

      // Create default roles for the organization
      await _createDefaultRoles(docRef.id, organizationData['type']);

      // Refresh the list
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to create organization: $e');
    }
  }

  Future<void> updateOrganization(
      String organizationId, Map<String, dynamic> updates) async {
    try {
      updates['updatedAt'] = DateTime.now().toIso8601String();

      await FirebaseFirestore.instance
          .collection('organizations')
          .doc(organizationId)
          .update(updates);

      // Refresh the list
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to update organization: $e');
    }
  }

  Future<void> deleteOrganization(String organizationId) async {
    try {
      // Check if organization has users
      final usersSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('organizationId', isEqualTo: organizationId)
          .limit(1)
          .get();

      if (usersSnapshot.docs.isNotEmpty) {
        throw Exception('Cannot delete organization with existing users');
      }

      // Delete organization
      await FirebaseFirestore.instance
          .collection('organizations')
          .doc(organizationId)
          .delete();

      // Refresh the list
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('Failed to delete organization: $e');
    }
  }

  Future<void> _createDefaultAdminUser(
      String organizationId, Map<String, dynamic> orgData) async {
    // This would create a default admin user for the organization
    // Implementation depends on your user creation logic
  }

  Future<void> _createDefaultRoles(
      String organizationId, String orgType) async {
    final defaultRoles = _getDefaultRolesForType(orgType);

    for (final role in defaultRoles) {
      role['organizationId'] = organizationId;
      await FirebaseFirestore.instance.collection('roles').add(role);
    }
  }

  List<Map<String, dynamic>> _getDefaultRolesForType(String orgType) {
    // Return default roles based on organization type
    switch (orgType) {
      case 'power_grid':
        return [
          {
            'id': 'admin',
            'name': 'admin',
            'displayName': 'Administrator',
            'hierarchyLevel': 1,
            'permissions': ['admin_all'],
            'config': {'hierarchyAccess': 'all'},
          },
          {
            'id': 'manager',
            'name': 'manager',
            'displayName': 'Manager',
            'hierarchyLevel': 20,
            'permissions': ['manage_users', 'view_reports'],
            'config': {'hierarchyAccess': 'own'},
          },
          // Add more roles...
        ];
      default:
        return [
          {
            'id': 'admin',
            'name': 'admin',
            'displayName': 'Administrator',
            'hierarchyLevel': 1,
            'permissions': ['admin_all'],
            'config': {'hierarchyAccess': 'all'},
          },
        ];
    }
  }
}

@riverpod
Future<List<Map<String, dynamic>>> organizations(OrganizationsRef ref) async {
  return ref.watch(organizationsNotifierProvider.future);
}
