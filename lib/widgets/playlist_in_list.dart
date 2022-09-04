import 'package:flutter/material.dart';
import 'package:yandex_music_api_flutter/playlist/playlist.dart';

class PlaylistInList extends StatelessWidget {
  const PlaylistInList({required this.playlist, this.onClick, Key? key}) : super(key: key);

  final Playlist playlist;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onClick,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          playlist.getCoverImage() != null
              ? SizedBox(
                  height: 32,
                  child: Image.network(
                    playlist.getCoverImage()!,
                  ),
                )
              : const SizedBox.shrink(),
          Text(
            (playlist.title ?? "Playlist") + (playlist.trackCount != null ? " (${playlist.trackCount})" : ""),
          ),
        ],
      ),
    );
  }
}
