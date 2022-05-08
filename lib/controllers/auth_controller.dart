import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:petcom/controllers/cart_controller.dart';
import 'package:petcom/controllers/db.dart';
import 'package:petcom/controllers/product_controller.dart';
import 'package:petcom/models/user.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = DatabaseServices();
  Rx<CustomUser> currentUser =
      CustomUser(uid: '', name: '', role: '', phoneNumber: '', token: '').obs;
  var _verificationId = '';

  @override
  onInit() {
    super.onInit();
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        try {
          currentUser.value = await _db.getCurrentUser(user.uid);
          Get.lazyPut(() => ProductController());

          if (currentUser.value.role == 'seller') {
            Get.offAndToNamed('/seller');
          } else {
            Get.lazyPut(() => CartController());
            Get.offAndToNamed('/');
          }
        } catch (error) {
          Get.offAndToNamed('/register');
        }
      } else {
        Get.offAndToNamed('/signin');
      }
    });
  }

  registerNew(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: "+977" + phoneNumber,
      verificationCompleted: (phoneAuthCredentials) async {},
      verificationFailed: (verificationFailed) async {},
      codeSent: (verificationId, resendingToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  sendCodeToFirebase(code) async {
    if (_verificationId != "") {
      try {
        var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId,
          smsCode: code,
        );
        var value = await _auth.signInWithCredential(credential);
        try {
          currentUser.value = await _db.getCurrentUser(value.user!.uid);
        } catch (error) {
          Get.offAndToNamed('register');
        }
      } catch (error) {
        Get.snackbar(
          '',
          '',
          titleText: const Text(
            'Wrong OTP!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.pink,
        );
      }
    }
  }

  registerUser(String name, String role) async {
    var status = await OneSignal.shared.getDeviceState();
    String? tokenId = status!.userId;
    CustomUser user = CustomUser(
      uid: _auth.currentUser!.uid,
      name: name,
      role: role,
      phoneNumber: _auth.currentUser!.phoneNumber!,
      token: tokenId!,
    );
    try {
      _db.createUser(user);
      currentUser.value = user;
      Get.offAndToNamed(role == 'seller' ? '/seller' : '/');
    } catch (error) {
      Get.snackbar('OOPS!', 'Something went wrong!');
    }
  }

  signOut() async {
    try {
      _auth.signOut();
      Get.offAndToNamed('/signin');
    } catch (error) {
      Get.snackbar('OOPS!', 'Something went wrong!');
    }
  }
}
