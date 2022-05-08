import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:petcom/controllers/auth_controller.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpVerificationScreen({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String? _code;
  String? phoneNumber;

  @override
  void initState() {
    phoneNumber = widget.phoneNumber;
    super.initState();
  }

  AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16),
        height: Get.height / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackButton(),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                'OTP Verification',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
              ),
            ),
            RichText(
              text: TextSpan(
                text: "We've sent you code in: ",
                style: const TextStyle(fontSize: 20, color: Colors.grey),
                children: [
                  TextSpan(
                    text: '+977$phoneNumber',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: OtpTextField(
                numberOfFields: 6,
                borderColor: Colors.deepPurpleAccent,
                showFieldAsBox: true,
                fieldWidth: Get.width / 8,
                cursorColor: Colors.deepPurpleAccent,
                //runs when every textfield is filled
                onSubmit: (String verificationCode) => setState(() {
                  _code = verificationCode;
                }), // end onSubmit
              ),
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
                  onTap: () => controller.sendCodeToFirebase(_code),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Verify 🎖️",
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
      )),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.back(),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 50,
        height: 50,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.withOpacity(.2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurpleAccent.withOpacity(.1),
              offset: const Offset(0, 2),
              blurRadius: 6,
            )
          ],
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.deepPurpleAccent,
        ),
      ),
    );
  }
}
