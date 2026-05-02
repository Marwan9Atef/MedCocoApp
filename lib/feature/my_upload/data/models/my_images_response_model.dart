class MyImagesResponseModel {
  final int total;
  final List<MyImageModel> images;

  const MyImagesResponseModel({
    required this.total,
    required this.images,
  });

  factory MyImagesResponseModel.fromJson(Map<String, dynamic> json) {
    final imagesJson = json['images'];

    return MyImagesResponseModel(
      total: json['total'] as int? ?? 0,
      images: imagesJson is List
          ? imagesJson
              .whereType<Map<String, dynamic>>()
              .map(MyImageModel.fromJson)
              .toList()
          : const [],
    );
  }



  MyImagesResponseModel copyWith({
    int? total,
    List<MyImageModel>? images,
  }) =>
      MyImagesResponseModel(
        total: total ?? this.total,
        images: images ?? this.images,
      );
}

class MyImageModel {
  final String imageId;
  final String filename;
  final String savedFilename;
  final String fileUrl;

  const MyImageModel({
    required this.imageId,
    required this.filename,
    required this.savedFilename,
    required this.fileUrl,
  });

  factory MyImageModel.fromJson(Map<String, dynamic> json) => MyImageModel(
        imageId: json['image_id'] as String? ?? '',
        filename: json['filename'] as String? ?? '',
        savedFilename: json['saved_filename'] as String? ?? '',
        fileUrl: json['file_url'] as String? ?? '',
      );



  MyImageModel copyWith({
    String? imageId,
    String? filename,
    String? savedFilename,
    String? fileUrl,
  }) =>
      MyImageModel(
        imageId: imageId ?? this.imageId,
        filename: filename ?? this.filename,
        savedFilename: savedFilename ?? this.savedFilename,
        fileUrl: fileUrl ?? this.fileUrl,
      );
}
