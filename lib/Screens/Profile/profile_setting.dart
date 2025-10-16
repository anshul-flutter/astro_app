import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../authentication/forget_password.dart';
import 'help_and_support.dart';
// import 'view_profile_screen.dart';
// import 'my_courses_screen.dart';
// import 'change_password_screen.dart';
// import 'notifications_screen.dart';
// import 'about_screen.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      // Define the style for this specific screen
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness:
            Brightness.dark, // Dark icons for a light background
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFB33214),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {},
          ),
          title: const Text(
            'My Profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.black, size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Back',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),

            // Profile Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFD84315), Color(0xFFFF6F00)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Profile Image with white border
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: const AssetImage(
                        'assets/profile_image.jpg',
                      ),
                      onBackgroundImageError: (_, __) {},
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Abhisheck',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Uncomment when ViewProfileScreen is imported
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => const ViewProfileScreen()),
                                // );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'abhishekastro@gmail.com',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Row(
                          children: [
                            Icon(Icons.phone, color: Colors.white, size: 14),
                            SizedBox(width: 6),
                            Text(
                              '+91 0099009999',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        const Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                'Jaya Nagar, Bangalore, India',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Menu Items
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildMenuItem(
                      context,
                      Icons.person_outline,
                      'View Profile',
                      () {
                        // Uncomment when ViewProfileScreen is imported
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const ViewProfileScreen()),
                        // );
                      },
                      const Color(0xFFD84315),
                    ),
                    _buildMenuItem(
                      context,
                      Icons.school_outlined,
                      'My Courses',
                      () {
                        // Uncomment when MyCoursesScreen is imported
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const MyCoursesScreen()),
                        // );
                      },
                      const Color(0xFFD84315),
                    ),
                    _buildMenuItem(
                      context,
                      Icons.lock_outline,
                      'Change Password',
                      () {
                        Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                         );
                      },
                      const Color(0xFFD84315),
                    ),
                    _buildMenuItem(
                      context,
                      Icons.notifications_outlined,
                      'Notifications',
                      () {
                        // Navigator.push(
                           //context,
                         //  MaterialPageRoute(builder: (context) => const NotificationsPage()),
                        // );
                      },
                      const Color(0xFFFF5722),
                    ),
                    _buildMenuItem(context, Icons.info_outline, 'About', () {
                      // Uncomment when AboutScreen is imported
                       //Navigator.push(
                        // context,
                        // MaterialPageRoute(builder: (context) => const AboutUsPage()),
                      // );
                    }, const Color(0xFFD84315)),
                    _buildMenuItem(
                      context,
                      Icons.help_outline,
                      'Help & Support',
                      () {
                        // Uncomment when HelpSupportScreen is imported
                         Navigator.push(
                           context,
                          MaterialPageRoute(builder: (context) => const HelpSupportPage()),
                         );
                      },
                      const Color(0xFFD84315),
                    ),

                    const SizedBox(height: 24),

                    // Logout Button
                    TextButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Logout'),
                            content: const Text(
                              'Are you sure you want to logout?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.popUntil(
                                    context,
                                    (route) => route.isFirst,
                                  );
                                },
                                child: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Icons.logout, color: Color(0xFFD84315)),
                      label: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Color(0xFFD84315),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 80), // Space for bottom navigation
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
    Color iconColor,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: iconColor, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
