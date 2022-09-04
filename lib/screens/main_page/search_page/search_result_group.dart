import 'package:flutter/material.dart';
import 'package:nota_music/widgets/artist_in_list.dart';
import 'package:nota_music/widgets/playlist_in_list.dart';
import 'package:nota_music/widgets/track_in_list.dart';
import 'package:yandex_music_api_flutter/search/search_result_data.dart';

class SearchResultGroup extends StatelessWidget {
  const SearchResultGroup({required this.data, Key? key}) : super(key: key);

  final SearchResultData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        data.map(
          (_) => const SizedBox.shrink(),
          tracks: (e) => Text(
            'Tracks',
            style: Theme.of(context).textTheme.headline5,
          ),
          artist: (e) => Text(
            'Artists',
            style: Theme.of(context).textTheme.headline5,
          ),
          playlist: (e) => Text(
            'Playlists',
            style: Theme.of(context).textTheme.headline5,
          ),
          albums: (_) => const SizedBox.shrink(),
          videos: (_) => const SizedBox.shrink(),
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: data.getCountFromList(),
            itemBuilder: (context, pos) {
              return data.map(
                (_) => const SizedBox.shrink(),
                tracks: (e) {
                  final item = e.results[pos];
                  //track
                  return TrackInList(track: item);
                },
                artist: (e) {
                  final item = e.results[pos];
                  //artist
                  return ArtistInList(artist: item);
                },
                playlist: (e) {
                  final item = e.results[pos];
                  //playlist
                  return PlaylistInList(playlist: item);
                },
                albums: (e) {
                  // final item = e.results[pos];
                  //album
                  return const SizedBox.shrink();
                },
                videos: (e) {
                  // final item = e.results[pos];
                  //video
                  return const SizedBox.shrink();
                },
              );
            })
      ],
    );
  }
}
