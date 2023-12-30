import 'package:flutter/material.dart';

class ResourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ResourceButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            // Size of the circle avatar
            backgroundColor: Colors.blue,
            // Background color of the circle avatar
            child: Icon(icon,
                size: 30, color: Colors.white), // Icon inside the circle avatar
          ),
          SizedBox(height: 8), // Space between icon and text
          Text(label, style: TextStyle(fontSize: 14)), // Label text
        ],
      ),
    );
  }
}
