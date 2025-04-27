import 'package:flutter/material.dart';
import 'package:lks_project_new/list_product_screen.dart';
import 'package:lks_project_new/profile_screen.dart';

class NavigationBarStateful extends StatefulWidget {
  final int initialIndex;
  const NavigationBarStateful({super.key, this.initialIndex = 0});

  @override
  State<NavigationBarStateful> createState() => _NavigationBarStatefulState();
}

class _NavigationBarStatefulState extends State<NavigationBarStateful> {
  late int _selectedIndex;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_rounded),
          label: 'Product',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });

        if (value == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ListProductStateful()),
          );
        } else if (value == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreenPage()),
          );
        }
      },
    );
  }
}
