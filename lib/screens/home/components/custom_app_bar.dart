import 'package:flutter/material.dart';
import 'package:jointjam/fixed.dart';

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
            buildBar(),
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

  Row buildBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.person_2_outlined,
              color: black,
              size: 30,
            )),
        const Text(
          "Home",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.add,
              color: black,
              size: 30,
            )),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
