import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  void requestPermissions() async {
    await [
    Permission.camera,
        Permission.microphone,
      Permission.storage
    ].request();
  }

  Future<bool> checkPermission(Permission permission) async {
    final isPermanentlyDenied = await permission.isPermanentlyDenied;
    if(isPermanentlyDenied) {
      await openAppSettings();
    }
    final isDenied = await permission.isDenied;
    if(isDenied) {
      await permission.request();
    }
    return await permission.isGranted;
  }

  static PermissionHelper? _instance;
  factory PermissionHelper() {
    _instance ??= PermissionHelper._internal();
    return _instance!;
  }
  PermissionHelper._internal();
}