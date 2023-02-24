import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:jointjam/fixed.dart';

import 'bottom_sheet.dart';

class AudioList extends StatefulWidget {
  final void Function(int index) returnCurrentImageIndex;
  const AudioList({Key? key, required this.returnCurrentImageIndex})
      : super(key: key);

  @override
  AudioListState createState() => AudioListState();
}

class AudioListState extends State<AudioList> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true),
      builder: (context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (item.data!.isEmpty) {
          return const Center(
            child: Text("No Music Files"),
          );
        }

        return ListView.builder(
          itemCount: item.data!.length,
          itemBuilder: (context, index) =>
              buildMusicRow(item, index, widget.returnCurrentImageIndex),
        );
      },
    );
  }

  ListTile buildMusicRow(AsyncSnapshot<List<SongModel>> item, int index,
      void Function(int index) returnCurrentImageIndex) {
    return ListTile(
      contentPadding: const EdgeInsets.all(20),
      leading: buildMusicIcon(),
      title: GestureDetector(
        onTap: () {
          Scaffold.of(context).showBottomSheet(
            (BuildContext context) => WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: PLayerBottomSheet(
                title: item.data![index].displayName,
                audioUrl: item.data![index].uri!,
                artist: item.data![index].artist ?? "<Unknown>",
                duration: item.data![index].duration ?? 1000,
                index: index,
                returnCurrentImageIndex: returnCurrentImageIndex,
                songs: item.data,
              ),
            ),
            enableDrag: true,
          );
        },
        child: Text(
          item.data![index].displayName,
        ),
      ),
      trailing: const Icon(
        Icons.more_horiz,
        color: black,
      ),
    );
  }

  Container buildMusicIcon() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          color: grey),
      child: const Icon(
        Icons.music_note,
        color: black,
      ),
    );
  }
}
