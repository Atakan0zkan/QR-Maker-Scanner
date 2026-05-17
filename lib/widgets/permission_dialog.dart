import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/constants/app_colors.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.camera_alt,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Kamera İzni Gerekli',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      content: const Text(
        'Bu uygulama kamera izni olmadan çalışamaz. Lütfen ayarlardan kamera izni verin.',
        style: TextStyle(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
          },
          child: Text(
            'İptal',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            Navigator.of(context).pop();
            await openAppSettings();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
          ),
          child: const Text('Ayarlara Git'),
        ),
      ],
    );
  }
}
