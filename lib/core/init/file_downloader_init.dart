import 'package:background_downloader/background_downloader.dart';

Future<void> initFileDownloader() async {
  await FileDownloader()
      .permissions
      .request(PermissionType.notifications);

  FileDownloader().configureNotificationForGroup(
    'medical_image_upload',
    running: const TaskNotification(
      'Uploading',
      'Uploading medical images...',
    ),
    complete: const TaskNotification(
      'Upload Complete',
      'Your medical images have been uploaded successfully',
    ),
    error: const TaskNotification(
      'Upload Failed',
      'Failed to upload medical images',
    ),
  );

  FileDownloader().trackTasks();
}