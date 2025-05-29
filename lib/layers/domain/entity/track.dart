class Track {
  Track({required this.promt, required this.style, required this.trackPath, required this.indexTrack});
  String promt;
  String style;
  String trackPath;
  int indexTrack;
  
   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'promt': promt,
      'style': style,
      'trackPath': trackPath,
      'indexTrack': indexTrack,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      promt: map['promt'] as String,
      style: map['style'] as String,
      trackPath: map['trackPath'] as  String,
      indexTrack: map['indexTrack'] as int,
    );
  }


}