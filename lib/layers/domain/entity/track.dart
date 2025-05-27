class Track {
  Track({required this.promt, required this.style, required this.trackPath});
  String promt;
  String style;
  String trackPath;
  
   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'promt': promt,
      'style': style,
      'trackPath': trackPath,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      promt: map['promt'] as String,
      style: map['style'] as String,
      trackPath: map['trackPath'] as  String,
    );
  }


}