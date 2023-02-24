import 'package:flutter/material.dart';
import 'package:jointjam/fixed.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerBody extends StatefulWidget {
  final String title, audioUrl, artist;
  final int duration;
  final int imageIndex;
  final List<SongModel>? songs;
  final int index;
  final String place;
  final Function(bool) changePlayingStatus;

  const PlayerBody(
      {Key? key,
      required this.title,
      required this.audioUrl,
      required this.artist,
      required this.place,
      required this.imageIndex,
      required this.duration,
      required this.changePlayingStatus,
      required this.songs,
      required this.index})
      : super(key: key);

  @override
  State<PlayerBody> createState() => _PlayerBodyState();
}

class _PlayerBodyState extends State<PlayerBody> {
  double currentPosition = 100;
  AudioPlayer? audioPlayer;
  bool isPlaying = false;
  Stream<Duration?>? durationStream;
  int currentIndex = 0;
  int duration = 0;
  late ProcessingState processingState;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    duration = widget.duration;
    initAudioPlayer(widget.audioUrl);
    audioPlayer!.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        playNext();
      }
    });
  }

  @override
  void dispose() {
    audioPlayer?.dispose();
    super.dispose();
  }

  void initAudioPlayer(String uri) {
    if (audioPlayer == null) {
      audioPlayer = AudioPlayer();
      audioPlayer!.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri),
          tag: MediaItem(
        id: '${widget.songs![widget.index].id}',
        album: "${widget.songs![widget.index].album}",
        title: widget.title,
        artUri: Uri.parse(
            "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"),
      ),
        ),
      );
      audioPlayer?.play();
      setState(() {
        isPlaying = true;
      });
      widget.changePlayingStatus(true);
    } else {
      audioPlayer?.pause();
      setState(() {
        isPlaying = false;
      });
      widget.changePlayingStatus(false);
      audioPlayer?.dispose();
      audioPlayer = AudioPlayer();
      audioPlayer!.setAudioSource(AudioSource.uri(Uri.parse(uri)));
      audioPlayer?.play();
      setState(() {
        isPlaying = true;
      });
      widget.changePlayingStatus(true);
    }
  }

  playAndPauseSong() {
    try {
      if (isPlaying) {
        audioPlayer?.pause();
        setState(() {
          isPlaying = false;
        });
        widget.changePlayingStatus(false);
      } else {
        audioPlayer?.play();
        setState(() {
          isPlaying = true;
        });
        widget.changePlayingStatus(true);
      }
      durationStream = audioPlayer?.durationStream;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error occurred, $e")));
    }
  }

  playPrevious() {
    int newIndex = currentIndex - 1;
    if (newIndex < 0) {
      newIndex = widget.songs!.length - 1;
    }
    currentIndex = newIndex;
    SongModel song = widget.songs![currentIndex];
    initAudioPlayer(song.uri!);

    setState(() {
      duration = widget.songs![newIndex].duration ?? 1000;
    });
  }

  playNext() {
    int newIndex = currentIndex + 1;
    if (newIndex >= widget.songs!.length) {
      newIndex = 0;
    }
    currentIndex = newIndex;
    SongModel song = widget.songs![currentIndex];
    initAudioPlayer(song.uri!);
    setState(() {
      duration = widget.songs![newIndex].duration ?? 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    void onChanged(double value) {
      setState(() {
        currentPosition = value;
      });
      audioPlayer?.seek(Duration(milliseconds: value.toInt()));
    }

    return Container(
      height: 170,
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildControls(),
          const SizedBox(
            height: 10,
          ),
          buildSlider(onChanged, duration),
        ],
      ),
    );
  }

  Row buildControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => playPrevious(),
          icon: const Icon(
            Icons.skip_previous,
            color: black,
            size: 40,
          ),
        ),
        IconButton(
          onPressed: () => playAndPauseSong(),
          icon: Icon(
            isPlaying ? Icons.pause_circle : Icons.play_circle,
            color: black,
            size: 40,
          ),
        ),
        IconButton(
          onPressed: () => playNext(),
          icon: const Icon(
            Icons.skip_next,
            color: black,
            size: 40,
          ),
        )
      ],
    );
  }

  StreamBuilder<Duration?> buildSlider(
      void Function(double value) onChanged, int duration) {
    return StreamBuilder<Duration>(
      stream: audioPlayer?.positionStream,
      builder: (context, snapshot) {
        final position = snapshot.data ?? Duration.zero;
        return Slider(
          min: 0,
          max: duration.toDouble(),
          value:
              position.inMilliseconds.toDouble().clamp(0, duration.toDouble()),
          activeColor: widget.place == bottomPlace
              ? black
              : imagePaths[widget.imageIndex]['bg'],
          inactiveColor: grey.shade700,
          label: '${position.inSeconds}',
          divisions:
              (duration / 1000).round() > 0 ? (duration / 1000).round() : 1,
          onChanged: onChanged,
        );
      },
    );
  }
}
