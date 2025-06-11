import 'package:flutter/material.dart';
import 'package:e_commerce/ui/Public_Widgets/curve_shape.dart';
import 'package:e_commerce/ui/Screens/Favorite/favorite.dart';
import 'package:e_commerce/ui/Screens/Home/home.dart';
import 'package:e_commerce/ui/Screens/Notification/notification.dart';
import 'package:e_commerce/ui/Screens/Profile/profile.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  const NavBar({super.key, required this.currentIndex});

  void _navigateScreen(BuildContext context, int targetIndex) {
    if (targetIndex == currentIndex) return;

    switch (targetIndex) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => FavoriteScreen()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => NotificationScreen()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ProfileScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CustomCircularNotchedRectangle(),
      notchMargin: 8,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: Icon(Icons.home, size: 30,
                  color: currentIndex == 0 ? Colors.blue : Colors.black),
              onPressed: () => _navigateScreen(context, 0)),
          IconButton(
              icon: Icon(Icons.favorite, size: 30,
                  color: currentIndex == 1 ? Colors.blue : Colors.black),
              onPressed: () => _navigateScreen(context, 1)),
          const SizedBox(width: 40),
          IconButton(
              icon: Icon(Icons.notifications, size: 30,
                  color: currentIndex == 2 ? Colors.blue : Colors.black),
              onPressed: () => _navigateScreen(context, 2)),
          IconButton(
              icon: Icon(Icons.person, size: 30,
                  color: currentIndex == 3 ? Colors.blue : Colors.black),
              onPressed: () => _navigateScreen(context, 3)),
        ],
      ),
    );
  }
}
