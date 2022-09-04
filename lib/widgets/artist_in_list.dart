import 'package:flutter/material.dart';
import 'package:yandex_music_api_flutter/others/artist.dart';
import 'package:yandex_music_api_flutter/track/track.dart';

class ArtistInList extends StatelessWidget {
  const ArtistInList({required this.artist, this.onClick, Key? key}) : super(key: key);

  final Artist artist;
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
          artist.getCoverImage() != null
              ? SizedBox(
                  height: 32,
                  child: Image.network(artist.getCoverImage()!),
                )
              : const SizedBox.shrink(),
          Text(artist.name ?? "Unnamed artist"),
        ],
      ),
    );
  }
}
