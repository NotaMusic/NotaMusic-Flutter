import 'package:flutter/material.dart';
import 'package:yandex_music_api_flutter/track/track.dart';
import 'package:yandex_music_api_flutter/track/track_short.dart';

class TrackInList extends StatelessWidget {
  const TrackInList({required this.track, this.onClick, Key? key}) : super(key: key);

  final Track track;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onClick,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const Icon(Icons.play_arrow),
        
          track.getCoverImage() != null
              ? SizedBox(
                  height: 32,
                  child: Image.network(
                    track.getCoverImage()!,
                  ),
                )
              : const SizedBox.shrink(),
          Text(
            track.artists!.map((e) => e.name).fold('', (previousValue, element) => '$previousValue $element'),
          ),
          const Text('-'),
          Text(track.title),
        ],
      ),
    );
  }
}
