// screens/api_documentation_screen.dart
import 'package:flutter/material.dart';

class ApiDocumentationScreen extends StatefulWidget {
  const ApiDocumentationScreen({Key? key}) : super(key: key);

  @override
  State<ApiDocumentationScreen> createState() => _ApiDocumentationScreenState();
}

class _ApiDocumentationScreenState extends State<ApiDocumentationScreen> {
  String _selectedCategory = 'Authentication';

  final Map<String, List<ApiDocSection>> _documentation = {
    'Authentication': [
      ApiDocSection(
        title: 'Login',
        method: 'POST',
        endpoint: '/api/v1/auth/login',
        description: 'Authenticate user and obtain access token',
        requestBody: '''
{
  "email": "user@example.com",
  "password": "password123"
}''',
        responseBody: '''
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "123",
    "email": "user@example.com",
    "name": "John Doe"
  }
}''',
        statusCodes: {
          '200': 'Login successful',
          '401': 'Invalid credentials',
          '422': 'Validation error',
        },
      ),
      ApiDocSection(
        title: 'Refresh Token',
        method: 'POST',
        endpoint: '/api/v1/auth/refresh',
        description: 'Refresh expired access token',
        requestBody: '''
{
  "refresh_token": "refresh_token_here"
}''',
        responseBody: '''
{
  "token": "new_access_token",
  "expires_in": 3600
}''',
        statusCodes: {
          '200': 'Token refreshed successfully',
          '401': 'Invalid refresh token',
        },
      ),
    ],
    'Users': [
      ApiDocSection(
        title: 'Get All Users',
        method: 'GET',
        endpoint: '/api/v1/users',
        description: 'Retrieve list of all users with pagination',
        requestBody: null,
        responseBody: '''
{
  "data": [
    {
      "id": "1",
      "name": "John Doe",
      "email": "john@example.com",
      "role": "admin"
    }
  ],
  "meta": {
    "total": 100,
    "per_page": 10,
    "current_page": 1
  }
}''',
        statusCodes: {
          '200': 'Users retrieved successfully',
          '401': 'Unauthorized',
          '403': 'Forbidden',
        },
      ),
      ApiDocSection(
        title: 'Create User',
        method: 'POST',
        endpoint: '/api/v1/users',
        description: 'Create a new user account',
        requestBody: '''
{
  "name": "Jane Smith",
  "email": "jane@example.com",
  "password": "password123",
  "role": "operator"
}''',
        responseBody: '''
{
  "id": "2",
  "name": "Jane Smith",
  "email": "jane@example.com",
  "role": "operator",
  "created_at": "2024-01-15T10:30:00Z"
}''',
        statusCodes: {
          '201': 'User created successfully',
          '400': 'Bad request',
          '422': 'Validation error',
        },
      ),
    ],
    'Substations': [
      ApiDocSection(
        title: 'Get Substations',
        method: 'GET',
        endpoint: '/api/v1/substations',
        description: 'Retrieve list of substations with their current status',
        requestBody: null,
        responseBody: '''
{
  "data": [
    {
      "id": "1",
      "name": "Central Substation",
      "location": "Downtown District",
      "voltage": "132kV",
      "status": "Online",
      "capacity": "50 MVA"
    }
  ]
}''',
        statusCodes: {
          '200': 'Substations retrieved successfully',
          '401': 'Unauthorized',
        },
      ),
      ApiDocSection(
        title: 'Get Substation Monitoring Data',
        method: 'GET',
        endpoint: '/api/v1/substations/{id}/monitoring',
        description: 'Get real-time monitoring data for a specific substation',
        requestBody: null,
        responseBody: '''
{
  "substation_id": "1",
  "voltage": 132.5,
  "current": 245.8,
  "power": 32.4,
  "frequency": 50.02,
  "temperature": 85.2,
  "timestamp": "2024-01-15T10:30:00Z"
}''',
        statusCodes: {
          '200': 'Monitoring data retrieved successfully',
          '404': 'Substation not found',
        },
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Documentation'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _downloadDocumentation,
            tooltip: 'Download Documentation',
          ),
        ],
      ),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(child: _buildDocumentationContent()),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
            ),
            child: const Text(
              'API Reference',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: _documentation.keys
                  .map((category) => ListTile(
                        title: Text(
                          category,
                          style: TextStyle(
                            fontWeight: _selectedCategory == category
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: _selectedCategory == category
                                ? Colors.blue.shade700
                                : Colors.black,
                          ),
                        ),
                        selected: _selectedCategory == category,
                        selectedTileColor: Colors.blue.shade50,
                        onTap: () =>
                            setState(() => _selectedCategory = category),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentationContent() {
    final sections = _documentation[_selectedCategory] ?? [];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _selectedCategory,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          ...sections.map((section) => _buildDocSection(section)),
        ],
      ),
    );
  }

  Widget _buildDocSection(ApiDocSection section) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getMethodColor(section.method),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    section.method,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    section.endpoint,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              section.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              section.description,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 16),
            if (section.requestBody != null) ...[
              const Text(
                'Request Body:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  section.requestBody!,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
            const Text(
              'Response:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Text(
                section.responseBody,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Status Codes:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...section.statusCodes.entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(entry.key),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(entry.value)),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Color _getMethodColor(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return Colors.blue;
      case 'POST':
        return Colors.green;
      case 'PUT':
        return Colors.orange;
      case 'DELETE':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String statusCode) {
    final code = int.tryParse(statusCode) ?? 0;
    if (code >= 200 && code < 300) {
      return Colors.green;
    } else if (code >= 400 && code < 500) {
      return Colors.orange;
    } else if (code >= 500) {
      return Colors.red;
    }
    return Colors.grey;
  }

  void _downloadDocumentation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Documentation'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.picture_as_pdf),
              title: Text('Download as PDF'),
            ),
            ListTile(
              leading: Icon(Icons.code),
              title: Text('Download as OpenAPI/Swagger'),
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Download as Markdown'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class ApiDocSection {
  final String title;
  final String method;
  final String endpoint;
  final String description;
  final String? requestBody;
  final String responseBody;
  final Map<String, String> statusCodes;

  ApiDocSection({
    required this.title,
    required this.method,
    required this.endpoint,
    required this.description,
    this.requestBody,
    required this.responseBody,
    required this.statusCodes,
  });
}
