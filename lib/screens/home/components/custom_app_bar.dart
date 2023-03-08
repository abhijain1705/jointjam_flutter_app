import 'package:flutter/material.dart';
import 'package:jointjam/fixed.dart';

import '../bluetooth/connection_row.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final int imageIndex;
  const CustomAppBar({Key? key, required this.height, required this.imageIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: ShapeDecoration(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          color: imagePaths[imageIndex]['bg'],
        ),
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ConnectionRow(),
            Text(
              "No Device is Connected",
              style: TextStyle(color: black.withOpacity(0.8)),
            ),
            Center(
                child: Image.asset(
              imagePaths[imageIndex]['img'],
              height: 150,
            )),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}