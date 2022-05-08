import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petcom/controllers/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? role = 'buyer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: Get.height / 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Enter name',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter fullname',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                      cursorColor: Colors.deepPurpleAccent,
                      style: const TextStyle(fontSize: 20),
                      onChanged: (value) => setState(() {
                        name = value;
                      }),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Invalid name!';
                        }
                        setState(() {
                          name = value;
                        });
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioSelect(
                      role: role!,
                      setRole: (value) {
                        setState(() {
                          role = value;
                        });
                      },
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
                        onTap: () {
                          _authController.registerUser(name!, role!);
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Let's go 👌",
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
          ),
        ),
      ),
    );
  }
}

class RadioSelect extends StatelessWidget {
  final String role;
  final Function setRole;
  const RadioSelect({Key? key, required this.role, required this.setRole})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          'Let me in as a: ',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => setRole('buyer'),
              child: Column(
                children: [
                  Container(
                    width: Get.width / 3,
                    height: Get.width / 3,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: role == 'buyer'
                            ? Colors.deepPurpleAccent
                            : Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: role == 'buyer'
                              ? Colors.deepPurple.withOpacity(.5)
                              : Colors.grey.withOpacity(.5),
                          blurRadius: 4.0,
                        )
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/register/buyer.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'Buyer',
                    style: TextStyle(
                      color: role == 'buyer'
                          ? Colors.deepPurpleAccent
                          : Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () => setRole('seller'),
              child: Column(
                children: [
                  Container(
                    width: Get.width / 3,
                    height: Get.width / 3,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: role == 'seller'
                            ? Colors.deepPurpleAccent
                            : Colors.white,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: role == 'seller'
                              ? Colors.deepPurple.withOpacity(.5)
                              : Colors.grey.withOpacity(.5),
                          blurRadius: 4.0,
                        )
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/register/seller.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'Seller',
                    style: TextStyle(
                      color: role == 'seller'
                          ? Colors.deepPurpleAccent
                          : Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
