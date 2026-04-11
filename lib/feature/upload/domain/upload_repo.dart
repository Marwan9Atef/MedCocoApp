import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../data/models/upload_response_model.dart';

abstract class UploadRepo {
  Future<Either<Failure, List<UploadResponseModel>>> uploadImages(
    List<String> filePaths,
  );

  Stream<double> get progressStream;

  Future<void> cancelUpload();

  /// Returns true if there's an active upload in progress.
  Future<bool> hasActiveUpload();
}
