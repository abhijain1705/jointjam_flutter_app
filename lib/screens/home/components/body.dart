import 'package:flutter/material.dart';
import 'package:jointjam/fixed.dart';
import 'package:jointjam/screens/home/components/audio_reader.dart';

class Body extends StatelessWidget {
  final void Function(int index) returnCurrentImageIndex;
  const Body({Key? key, required this.returnCurrentImageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, left: 40, right: 40),
      child: Column(
        children: [
          Expanded(
            child: AudioList(returnCurrentImageIndex: returnCurrentImageIndex,),
          ),
        ],
      ),
    );
  }
}
