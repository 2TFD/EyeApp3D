class Track {
  Track({required this.promt, required this.trackPath, required this.indexTrack});
  String promt;
  String trackPath;
  int indexTrack;
  
   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'promt': promt,
      'trackPath': trackPath,
      'indexTrack': indexTrack,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      promt: map['promt'] as String,
      trackPath: map['trackPath'] as  String,
      indexTrack: map['indexTrack'] as int,
    );
  }


}