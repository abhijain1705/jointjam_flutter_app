import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jointjam/fixed.dart';
import 'package:jointjam/screens/home/components/player_controls.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PLayerBottomSheet extends StatefulWidget {
  final String title, audioUrl, artist;
  final int duration;
  final List<SongModel>? songs;
  final int index;
  final void Function(int index) returnCurrentImageIndex;
  const PLayerBottomSheet(
      {Key? key,
      required this.title,
      required this.audioUrl,
      required this.artist,
      required this.duration,
      this.songs,
      required this.index,
      required this.returnCurrentImageIndex})
      : super(key: key);

  @override
  State<PLayerBottomSheet> createState() => _PLayerBottomSheetState();
}

class _PLayerBottomSheetState extends State<PLayerBottomSheet> {
  int imageIndex = 0;
  Timer? timer;

  void changePlayingStatus(bool value) {
    if (value) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            if (imageIndex >= imagePaths.length - 1) {
              imageIndex = 0;
            } else {
              imageIndex++;
            }
          });
          widget.returnCurrentImageIndex(imageIndex);
        }
      });
    } else {
      timer?.cancel();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        color: imagePaths[imageIndex]['bg'],
      ),
      child: PlayerBody(
          place: bottomPlace,
          title: widget.title,
          audioUrl: widget.audioUrl,
          artist: widget.artist,
          imageIndex: imageIndex,
          duration: widget.duration,
          changePlayingStatus: changePlayingStatus,
          songs: widget.songs,
          index: widget.index),
    );
  }
}
