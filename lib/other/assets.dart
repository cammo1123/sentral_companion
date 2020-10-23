import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DashButton extends StatelessWidget {
  BorderRadius radius;
  String label;
  String subtitle;
  IconData icon;
  Color color;

  DashButton(this.icon, this.color, {this.label = '', this.subtitle = ''});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          icon,
          color: color,
        ),
        backgroundColor: color.withAlpha(100),
      ),
      title: Text(label),
      subtitle: Text(subtitle),
    );
    // return ListTile(
    //   leading: CircleAvatar(
    //     backgroundColor: Color.fromARGB(100, 187, 134, 252),
    //     child: Icon(
    //       Icons.settings,
    //       color: Color.fromARGB(255, 187, 134, 252),
    //     ),
    //   ),
    //   title: Text("Settings"),
    //   onTap: () {},
    // );
  }
}
