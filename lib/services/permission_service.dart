import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  static Future<bool> checkCameraPermission() async {
    final status = await Permission.camera.status;
    return status.isGranted;
  }

  static Future<bool> requestStoragePermission() async {
    final status = await Permission.storage.request();
    return status.isGranted || status.isLimited;
  }

  static Future<bool> checkStoragePermission() async {
    final status = await Permission.storage.status;
    return status.isGranted || status.isLimited;
  }

  static Future<void> openSettings() async {
    await openAppSettings();
  }
}
