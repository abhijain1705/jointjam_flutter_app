import 'package:flutter/material.dart';
import 'package:jointjam/fixed.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionDialog extends StatelessWidget {
  final BuildContext currentContext;
  const PermissionDialog({Key? key, required this.currentContext})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      title: const Text(
        'Allow "JointJam" to access your storage while you use the app?',
      ),
      actions: [
        Row(
          children: [
            const Spacer(),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Don't Allow")),
            const Spacer(),
            TextButton(
                onPressed: () async {
                  if (Theme.of(context).platform == TargetPlatform.android) {
                    await openAppSettings(); // navigate to app settings page
                  }
                  Navigator.pop(currentContext, true);
                },
                child: const Text("Allow")),
            const Spacer(),
          ],
        )
      ],
    );
  }
}
