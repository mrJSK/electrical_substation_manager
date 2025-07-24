import 'package:flutter/material.dart';

class OrganizationCard extends StatelessWidget {
  final Map<String, dynamic> organization;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onViewUsers;

  const OrganizationCard({
    super.key,
    required this.organization,
    required this.onEdit,
    required this.onDelete,
    required this.onViewUsers,
  });

  @override
  Widget build(BuildContext context) {
    final status = organization['status'] as String? ?? 'active';
    final type = organization['type'] as String? ?? 'power_grid';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Status
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: _getTypeGradient(type),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getTypeIcon(type),
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    organization['name'] ?? 'Unknown',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildStatusBadge(status),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type
                  Text(
                    _getTypeDisplayName(type),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${organization['city'] ?? ''}, ${organization['state'] ?? ''}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Contact
                  Row(
                    children: [
                      Icon(Icons.email, size: 16, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          organization['email'] ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: onViewUsers,
                          icon: const Icon(Icons.people, size: 16),
                          label: const Text('Users',
                              style: TextStyle(fontSize: 12)),
                        ),
                      ),
                      PopupMenuButton<String>(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 16),
                                SizedBox(width: 8),
                                Text('Edit'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, size: 16, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Delete',
                                    style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'edit') onEdit();
                          if (value == 'delete') onDelete();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String text;

    switch (status) {
      case 'active':
        color = Colors.green;
        text = 'Active';
        break;
      case 'pending':
        color = Colors.orange;
        text = 'Pending';
        break;
      case 'inactive':
        color = Colors.red;
        text = 'Inactive';
        break;
      default:
        color = Colors.grey;
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  LinearGradient _getTypeGradient(String type) {
    switch (type) {
      case 'power_grid':
        return const LinearGradient(
            colors: [Color(0xFF10B981), Color(0xFF059669)]);
      case 'state_board':
        return const LinearGradient(
            colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)]);
      case 'private':
        return const LinearGradient(
            colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)]);
      case 'government':
        return const LinearGradient(
            colors: [Color(0xFFF59E0B), Color(0xFFD97706)]);
      case 'cooperative':
        return const LinearGradient(
            colors: [Color(0xFFEF4444), Color(0xFFDC2626)]);
      default:
        return const LinearGradient(
            colors: [Color(0xFF6B7280), Color(0xFF4B5563)]);
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'power_grid':
        return Icons.electrical_services;
      case 'state_board':
        return Icons.account_balance;
      case 'private':
        return Icons.business;
      case 'government':
        return Icons.location_city;
      case 'cooperative':
        return Icons.group_work;
      default:
        return Icons.business;
    }
  }

  String _getTypeDisplayName(String type) {
    switch (type) {
      case 'power_grid':
        return 'Power Grid Company';
      case 'state_board':
        return 'State Electricity Board';
      case 'private':
        return 'Private Company';
      case 'government':
        return 'Government Entity';
      case 'cooperative':
        return 'Cooperative Society';
      default:
        return type;
    }
  }
}
