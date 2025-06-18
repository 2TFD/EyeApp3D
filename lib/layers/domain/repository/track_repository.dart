import 'dart:convert';
import 'dart:io';
import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/track.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TrackRepository {
  final _pref = SharedPreferences.getInstance();

  Future<String> createFile(String url) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = await http.get(Uri.parse(url));
    final file = File('${directory.path}/${url.split('/').last}');
    await file.writeAsBytes(image.bodyBytes);
    return file.path;
  }

  Future<Track> newTrack(String promt) async {
    String trackUrl = await Api().musicGen(promt);
    if (trackUrl != 'error_token') {
      String trackPath = await createFile(trackUrl);
      List<Track> listTrack = await getListTracks();
      Track track = Track(
        promt: promt,
        trackPath: trackPath,
        indexTrack: listTrack.length + 1,
      );
      saveTrack(track);
      return track;
    } else {
      throw FormatException('server_exception');
    }
  }

  Future<void> saveTrack(Track track) async {
    print(track.promt);
    print(track.trackPath);
    final pref = await _pref;
    List<String>? tracks = await pref.getStringList('tracks');
    if (tracks != null) {
      tracks.add(jsonEncode(track.toMap()));
      pref.setStringList('tracks', tracks);
    } else {
      tracks = [];
      tracks.add(jsonEncode(track.toMap()));
      pref.setStringList('tracks', tracks);
    }
  }

  Future<List<Track>> getListTracks() async {
    final pref = await _pref;
    List<String>? tracks = await pref.getStringList('tracks');
    if (tracks != null) {
      return tracks.map((e) {
        return Track.fromMap(jsonDecode(e));
      }).toList();
    } else {
      return [];
    }
  }

  Future<void> delListTracks() async {
    final pref = await _pref;
    pref.setStringList('tracks', []);
  }
}
