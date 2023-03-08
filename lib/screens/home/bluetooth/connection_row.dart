import 'package:flutter/material.dart';

import '../../../fixed.dart';

class ConnectionRow extends StatefulWidget {
  const ConnectionRow({
    super.key,
  });

  @override
  State<ConnectionRow> createState() => _ConnectionRowState();
}

class _ConnectionRowState extends State<ConnectionRow> {

  @override
  Widget build(BuildContext context) {
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
            onTap: () => {},
            child: const Icon(
              Icons.add,
              color: black,
              size: 30,
            )),
      ],
    );
  }
}
