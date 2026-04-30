import 'dart:async';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constant/api_constant.dart';
import '../../../../../core/network/api_client.dart';
import '../../models/upload_response_model.dart';
import 'upload_remote_medical_service.dart';

class UploadWebMedicalService implements UploadRemoteMedicalService {
  final ApiClient _apiClient;

  final _progressController = StreamController<double>.broadcast();
  CancelToken? _cancelToken;

  UploadWebMedicalService(this._apiClient);

  @override
  Future<UploadResponseModel> enqueueUpload(List<String> filePaths) async {
    _cancelToken = CancelToken();

    final multipartFiles = <MultipartFile>[];
    for (final path in filePaths) {
      final xFile = XFile(path);
      final bytes = await xFile.readAsBytes();
      multipartFiles.add(MultipartFile.fromBytes(bytes, filename: xFile.name));
    }

    final formData = FormData.fromMap({'files': multipartFiles});

    final response = await _apiClient.post(
      ApiConstant.uploadImageEndpoint,
      data: formData,
      queryParameters: null,
      onSendProgress: (sent, total) {
        if (total > 0) {
          _progressController.add(sent / total);
        }
      },
      cancelToken: _cancelToken,
    );

    final json = response.data as Map<String, dynamic>;
    return UploadResponseModel.fromJson(json);
  }

  @override
  Stream<double> get progressStream => _progressController.stream;

  @override
  Future<void> cancelUpload() async {
    _cancelToken?.cancel('Upload cancelled by user');
  }

  @override
  Future<bool> hasActiveUpload() async => false;
}
