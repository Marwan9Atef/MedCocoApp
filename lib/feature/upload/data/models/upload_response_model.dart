class UploadResponseModel {
  final int uploaded;
  final int totalInDb;
  final List<UploadedFileModel> files;

  const UploadResponseModel({
    required this.uploaded,
    required this.totalInDb,
    required this.files,
  });

  factory UploadResponseModel.fromJson(Map<String, dynamic> json) =>
      UploadResponseModel(
        uploaded: json['uploaded'] as int,
        totalInDb: json['total_in_db'] as int,
        files: (json['files'] as List<dynamic>)
            .map((e) => UploadedFileModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class UploadedFileModel {
  final String imageId;
  final String filename;
  final String savedFilename;
  final String status;

  const UploadedFileModel({
    required this.imageId,
    required this.filename,
    required this.savedFilename,
    required this.status,
  });

  factory UploadedFileModel.fromJson(Map<String, dynamic> json) =>
      UploadedFileModel(
        imageId: json['image_id'] as String,
        filename: json['filename'] as String,
        savedFilename: json['saved_filename'] as String,
        status: json['status'] as String,
      );
}
