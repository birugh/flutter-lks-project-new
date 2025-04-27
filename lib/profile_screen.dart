import 'package:flutter/material.dart';
import 'package:lks_project_new/login_screen.dart';
import 'package:lks_project_new/navigation_bar.dart';

class ProfileScreenPage extends StatefulWidget {
  const ProfileScreenPage({super.key});

  @override
  State<ProfileScreenPage> createState() => _ProfileScreenPageState();
}

class _ProfileScreenPageState extends State<ProfileScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            HeaderApp(context),
            UserProfileScreen(context),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBarStateful(initialIndex: 1,),
    );
  }
}

Widget HeaderApp(BuildContext context) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 249),
            child: Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3d6484),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreenStateful()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    ),
  );
}

Widget UserProfileScreen(BuildContext context) {
  return Container(
    height: 150,
    decoration: BoxDecoration(color: const Color(0xFFd0f4f5)),
    child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          Image.asset(
            'assets/Logo.png',
            width: 70,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFF142b70),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, color: Color(0Xffd0f4f5), size: 50),
              );
            },
          ),
          SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Biru',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3e6384),
                ),
              ),
              Text(
                'No Telepon',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Text(
                'Alamat',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
