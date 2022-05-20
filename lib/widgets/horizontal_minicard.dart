import 'package:flutter/material.dart';
import 'package:projectb/config/app_theme.dart';

class hMiniCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final bool isActive;
  const hMiniCardWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.blueGrey,
          boxShadow: [
            isActive
                ? BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 20,
              color: kActiveShadowColor,
            )
                : BoxShadow(
              offset: Offset(0, 3),
              blurRadius: 6,
              color: kShadowColor,
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Image.asset(image, height: 60),
            Text(
              title,
              style: primaryTextStyle,
            ),
            Text(
              subtitle,
              style: subtitleTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}