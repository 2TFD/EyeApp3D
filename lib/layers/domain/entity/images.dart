class Images {
  Images({required this.promt, required this.imagePathOne, required this.imagePathTwo, required this.imagePathThree, required this.imagePathFour});
  String promt;
  String imagePathOne;
  String imagePathTwo;
  String imagePathThree;
  String imagePathFour;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'promt': promt,
      'imagePathOne': imagePathOne,
      'imagePathTwo': imagePathTwo,
      'imagePathThree': imagePathThree,
      'imagePathFour': imagePathFour,
    };
  }

  factory Images.fromMap(Map<String, dynamic> map) {
    return Images(
      promt: map['promt'] as String ,
      imagePathOne: map['imagePathOne'] as String,
      imagePathTwo: map['imagePathTwo'] as String, 
      imagePathThree: map['imagePathThree'] as String,
      imagePathFour: map['imagePathFour'] as String  
    );
  }

}