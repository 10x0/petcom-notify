import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcom/controllers/auth_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetX<AuthController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(16),
          width: Get.width,
          height: Get.height,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(children: [
                Text(controller.currentUser.value.name),
                const SizedBox(height: 12),
                Text(controller.currentUser.value.role),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => controller.signOut(),
                  child: const Text('Sign Out'),
                )
              ]),
            ),
          ),
        );
      },
    ));
  }
}
