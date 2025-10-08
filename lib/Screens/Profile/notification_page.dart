import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/notification_model.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool showAllNotifications = true;
  List<NotificationItem> notifications = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  // Fetch notifications from API
  Future<void> fetchNotifications() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Replace with your actual API endpoint
      final response = await http.get(
        Uri.parse('https://your-api-url.com/api/notifications'),
        headers: {
          'Content-Type': 'application/json',
          // Add authentication token if needed
          // 'Authorization': 'Bearer YOUR_TOKEN',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          notifications = data
              .map((json) => NotificationItem.fromJson(json))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load notifications: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Failed to load notifications. Using sample data.';
      });
      // Load sample data as fallback
      _loadSampleData();
    }
  }

  // Sample data for demonstration
  void _loadSampleData() {
    setState(() {
      notifications = [
        NotificationItem(
          id: '1',
          title: 'Notification 1',
          message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor',
          time: '3:15 PM',
          isRead: false,
          createdAt: DateTime.now(),
        ),
        NotificationItem(
          id: '2',
          title: 'Notification 2',
          message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor',
          time: '3:15 PM',
          isRead: false,
          createdAt: DateTime.now(),
        ),
        NotificationItem(
          id: '3',
          title: 'Notification 3',
          message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor',
          time: '3:15 PM',
          isRead: false,
          createdAt: DateTime.now(),
        ),
        NotificationItem(
          id: '4',
          title: 'Notification 4',
          message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor',
          time: '3:15 PM',
          isRead: false,
          createdAt: DateTime.now(),
        ),
        NotificationItem(
          id: '5',
          title: 'Notification 5',
          message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor',
          time: '3:15 PM',
          isRead: true,
          createdAt: DateTime.now().subtract(Duration(days: 1)),
        ),
        NotificationItem(
          id: '6',
          title: 'Notification 6',
          message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor',
          time: '3:15 PM',
          isRead: true,
          createdAt: DateTime.now().subtract(Duration(days: 1)),
        ),
        NotificationItem(
          id: '7',
          title: 'Notification 7',
          message: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor',
          time: '3:15 PM',
          isRead: true,
          createdAt: DateTime.now().subtract(Duration(days: 1)),
        ),
      ];
    });
  }

  // Group notifications by date
  Map<String, List<NotificationItem>> getGroupedNotifications() {
    List<NotificationItem> filteredNotifications = showAllNotifications
        ? notifications
        : notifications.where((n) => !n.isRead).toList();

    Map<String, List<NotificationItem>> grouped = {};
    final now = DateTime.now();

    for (var notification in filteredNotifications) {
      final difference = now.difference(notification.createdAt).inDays;
      String key;

      if (difference == 0) {
        key = 'Today';
      } else if (difference == 1) {
        key = 'Yesterday';
      } else {
        key = '$difference days ago';
      }

      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(notification);
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final groupedNotifications = getGroupedNotifications();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // Custom Status Bar & Header
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFB91C1C), Color(0xFFDC2626)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Column(
                children: [
                  // Status Bar
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('9:41',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          Row(
                            children: [
                              Icon(Icons.signal_cellular_4_bar,
                                  color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Icon(Icons.wifi, color: Colors.white, size: 16),
                              SizedBox(width: 4),
                              Icon(Icons.battery_full,
                                  color: Colors.white, size: 20),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.menu, color: Colors.white, size: 28),
                        Text(
                          'Notifications',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Icon(Icons.shopping_bag_outlined,
                            color: Colors.white, size: 28),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Back Button
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  Icon(Icons.arrow_back, size: 22),
                  SizedBox(width: 8),
                  Text('Back',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ),

            // Tab Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllNotifications = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: showAllNotifications
                              ? Color(0xFFDC2626)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'All',
                            style: TextStyle(
                              color: showAllNotifications
                                  ? Colors.white
                                  : Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showAllNotifications = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: !showAllNotifications
                              ? Color(0xFFDC2626)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Unread',
                            style: TextStyle(
                              color: !showAllNotifications
                                  ? Colors.white
                                  : Colors.grey[700],
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Notifications List
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RefreshIndicator(
                onRefresh: fetchNotifications,
                child: groupedNotifications.isEmpty
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.notifications_none,
                          size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        'No notifications',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: groupedNotifications.length,
                  itemBuilder: (context, index) {
                    final key =
                    groupedNotifications.keys.elementAt(index);
                    final items = groupedNotifications[key]!;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            key,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                        ...items.map((notification) =>
                            _buildNotificationItem(notification)),
                        SizedBox(height: 8),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(NotificationItem notification) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: notification.isRead ? Colors.grey[400] : Color(0xFFDC2626),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  notification.time,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}