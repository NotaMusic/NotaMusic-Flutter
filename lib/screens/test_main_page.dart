
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yandex_music_api_flutter/playlist/playlist.dart';
import 'package:yandex_music_api_flutter/yandex_music_api_flutter.dart';

class TestMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestMainPageState();
}

class _TestMainPageState extends State<TestMainPage> {
  final client = Client();
  final userIdCtrl = TextEditingController(text: 'ElectroEnstein');
  final playlistIdCrl  = TextEditingController(text:'3');
  Playlist? playlist;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: userIdCtrl,
          ),
          TextField(
            controller: playlistIdCrl,
          ),
          ElevatedButton(
            child: const Text('Fetch playlist'),
            onPressed: () async {
              final playlists = await client.getUsersPlaylist(userId: userIdCtrl.text,kind: playlistIdCrl.text);

              if(playlists != null){
                setState((){
                  playlist = playlists.first;
                });
              }else{
                showDialog(context: context, builder: (context){
                  return const Material(child: Text('NotFound'),);
                });
              }
            },
          ),
          if (playlist != null)
            ListView.builder(
                itemCount: playlist?.tracks?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, pos) {
                  final track = playlist!.tracks![pos].track;
                  return Text('${track.artists?.first.name} - ${track.title}');
                }),
        ],
      ),
    );
  }
}
