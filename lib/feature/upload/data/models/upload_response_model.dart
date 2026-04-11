class UploadResponseModel {
  final int id;
  final String filename;
  final String ownerId;

  const UploadResponseModel({
    required this.id,
    required this.filename,
    required this.ownerId,
  });

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) =>
      UploadResponseModel(
        id: json['id'] as int,
        filename: json['filename'] as String,
        ownerId: json['owner_id'] as String,
      );
}
