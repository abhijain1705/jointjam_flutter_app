import 'package:flutter/material.dart';
import 'package:jointjam/fixed.dart';
import 'package:jointjam/screens/home/components/body.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:jointjam/screens/home/components/permission.dart';
import 'components/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String routeName = "/homeRoute";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPermissionGranted = false;
  BuildContext? currentContext;

  @override
  void initState() {
    super.initState();
    currentContext = context;
    checkPermissionStatus();
  }

  Future<void> checkPermissionStatus() async {
    final status = await Permission.storage.status;
    if (status.isGranted) {
      setState(() {
        isPermissionGranted = true;
      });
    } else {
      showDialog(
          context: currentContext!, // Use the stored context instead
          barrierDismissible: false,
          builder: (BuildContext context) => PermissionDialog(
                currentContext: currentContext!,
              )).then((result) {
        if (result == true) {
          checkPermissionStatus();
        }
      });
    }
  }

  int imageIndex = 0;

  void returnCurrentImageIndex(int index) {
    setState(() {
      imageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 270,
        imageIndex: imageIndex,
      ),
      backgroundColor: white,
      body: Body(
        returnCurrentImageIndex: returnCurrentImageIndex,
      ),
    );
  }
}
