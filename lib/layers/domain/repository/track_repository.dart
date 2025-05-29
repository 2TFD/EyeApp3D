import 'dart:convert';

import 'package:eyeapp3d/layers/data/network/api.dart';
import 'package:eyeapp3d/layers/domain/entity/track.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class TrackRepository {
  final _pref = SharedPreferences.getInstance();

  Future<Track> newTrack(String promt, String style) async {
    String? trackPath = await Api().musicGen(promt, style);
    List<Track> listTrack = await getListTracks();
    Track track = Track(promt: promt, style: style, trackPath: trackPath, indexTrack: listTrack.length+1);
    saveTrack(track);
    return track;
  }

  Future<void> saveTrack(Track track) async {
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
    return tracks!.map((e) {
      return Track.fromMap(jsonDecode(e));
    }).toList();
  }

  Future<void> delListTracks() async {
    final pref = await _pref;
    pref.setStringList('tracks', []);
  }
}
