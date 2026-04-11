import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/failure/failure.dart';
import '../models/upload_response_model.dart';
import '../service/remote/upload_remote_medical_service.dart';
import '../../domain/upload_repo.dart';

@LazySingleton(as: UploadRepo)
class UploadRepoImpl implements UploadRepo {
  final UploadRemoteMedicalService _remoteService;

  UploadRepoImpl(this._remoteService);

  @override
  Future<Either<Failure, List<UploadResponseModel>>> uploadImages(
    List<String> filePaths,
  ) async {
    try {
      final results = await _remoteService.enqueueUpload(filePaths);
      return Right(results);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Stream<double> get progressStream => _remoteService.progressStream;

  @override
  Future<void> cancelUpload() => _remoteService.cancelUpload();

  @override
  Future<bool> hasActiveUpload() => _remoteService.hasActiveUpload();
}
