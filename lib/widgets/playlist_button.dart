import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yandex_music_api_flutter/playlist/playlist.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

class PlaylistButton extends StatelessWidget {
  const PlaylistButton({Key? key, required this.playlist, this.onClick})
      : super(key: key);

  final Playlist playlist;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onClick,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PlaylistImg(playlist),
          Text(
            playlist.title ?? 'Плейлист',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class _PlaylistImg extends StatelessWidget {
  const _PlaylistImg(
    this.playlist, {
    Key? key,
    this.size = 200,
  }) : super(key: key);
  final Playlist playlist;
  final double size;

  @override
  Widget build(BuildContext context) {
    Widget wgt;
    final imgUrl = playlist.getCoverImage();
    if (imgUrl == null) {
      wgt = Container(
        color: Colors.primaries.first,
        child: const Icon(
          Iconsax.music,
          size: 32,
        ),
      );
    } else {
      wgt = Image.network(
        imgUrl,
        fit: BoxFit.contain,
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: wgt,
    );
  }
}
