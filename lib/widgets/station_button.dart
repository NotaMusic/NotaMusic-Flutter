import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

class StationButton extends StatelessWidget {
  const StationButton({Key? key, required this.station, this.onClick}) : super(key: key);

  final Station station;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StationImg(station),
          Text(
            station.name,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class _StationImg extends StatelessWidget {
  const _StationImg(
    this.station, {
    Key? key,
    this.size = 200,
  }) : super(key: key);
  final Station station;
  final double size;

  @override
  Widget build(BuildContext context) {
    Widget wgt;
    final imgUrl = station.getCoverImage();
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
