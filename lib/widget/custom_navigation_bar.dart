import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.green[900]: Color(0xFFDBF4D1),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: isDarkMode ? Colors.white : Colors.green,
        unselectedItemColor: isDarkMode ? Colors.black : Colors.grey[700],
        items: [
          _buildNavItem(Icons.home_outlined, "Home", 0),
          _buildNavItem(Icons.favorite_border_outlined, "Favorites", 1),
          _buildNavItem(Icons.shopping_cart_outlined, "", 2, isCenter: true),
          _buildNavItem(Icons.history, "History", 3),
          _buildNavItem(Icons.person_outline, "Profile", 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label, int index, {bool isCenter = false}) {
    return BottomNavigationBarItem(
      icon: isCenter
          ? SizedBox.shrink()
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(icon, size: 26),
      ),
      label: label,
    );
  }
}
