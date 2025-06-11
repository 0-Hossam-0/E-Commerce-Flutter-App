import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  final List<Map<String, String>> notifications = const [
    {
      "title": "Order Shipped",
      "description": "Order #1234 has been shipped",
      "time": "10 minutes ago",
      "icon": "local_shipping",
    },
    {
      "title": "New Message",
      "description": "Anda memiliki pesan baru",
      "time": "1 hour ago",
      "icon": "message",
    },
    {
      "title": "This Month's Promo",
      "description": "50% discount on all products!",
      "time": "Today, 09:00",
      "icon": "campaign",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: const Color(0xFF3347C4), 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                "No notifications",
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFD2D9FF),
                      child: Icon(
                        _getIconData(item["icon"] ?? "notifications"),
                        color: const Color(0xFF3347C4),
                      ),
                    ),
                    title: Text(
                      item["title"] ?? "Untitled",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(item["description"] ?? ""),
                    trailing: Text(
                      item["time"] ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    onTap: () {
                    },
                  ),
                );
              },
            ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case "local_shipping":
        return Icons.local_shipping;
      case "message":
        return Icons.message;
      case "campaign":
        return Icons.campaign;
      default:
        return Icons.notifications;
    }
  }
}
