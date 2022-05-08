import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:petcom/controllers/auth_controller.dart';
import 'package:petcom/screens/otp.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SigIinScreenState();
}

class _SigIinScreenState extends State<SignInScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  String? phoneNumber;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: Get.width,
          height: Get.height,
          child: SafeArea(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/bg.png',
                  width: Get.width,
                  height: Get.height / 2,
                ),
                Positioned(
                  bottom: 0,
                  width: Get.width - 32,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'PetCommerce',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'We care your pets more than you do.',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 32.0),
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    prefixText: '+977',
                                    hintText: 'Enter your number',
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  cursorColor: Colors.deepPurpleAccent,
                                  style: const TextStyle(fontSize: 20),
                                  validator: (value) {
                                    if (value == null || value.length != 10) {
                                      return 'Invalid number!';
                                    }
                                    setState(() {
                                      phoneNumber = value;
                                    });
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _authController.registerNew(phoneNumber!);
                                  Get.to(() => OtpVerificationScreen(
                                        phoneNumber: phoneNumber!,
                                      ));
                                }
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
                                  "Get Started 🤙",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    letterSpacing: 1.4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
