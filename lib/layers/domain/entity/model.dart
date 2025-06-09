class Model {
  Model({required this.modelPath, required this.imagePath});
  String  modelPath;
  String  imagePath;
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'modelPath': modelPath,
      'imagePath': imagePath,
    };
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      modelPath: map['modelPath'] as String ,
      imagePath: map['imagePath'] as String ,
    );
  }

}