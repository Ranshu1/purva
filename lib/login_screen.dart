import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _numbercontroller = TextEditingController();
  bool isSendingOtp = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _numbercontroller.dispose();
    super.dispose();
  }

  Future<void> _verifyPhoneNumber(
      BuildContext context, String phoneNumber) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      setState(() {
        isSendingOtp = true;
      });
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (AuthCredential authCredential) {
          // Auto verification
        },
        verificationFailed: (FirebaseAuthException authException) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Phone verification failed. Code: ${authException.code}'),
            ),
          );
        },
        codeSent: (String verificationId, [int? forceResend]) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                phoneNumber: _numbercontroller.text,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto retrieval timeout
        },
      );
    } catch (e) {
      print('Error sending OTP: $e');
    }
  }

  bool _isValidPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters (e.g., spaces, hyphens)
    final cleanedPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    // Check if the cleaned phone number has exactly 10 digits
    return cleanedPhoneNumber.length == 10;
  }

  @override
  Widget build(BuildContext context) {
    var wid = MediaQuery.of(context).size.width;
    var hei = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: hei * 0.45,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffE85801),
                Color(0xffF4810E),
              ],
            )),
            child: Stack(
              children: const [
                Positioned(
                    left: 20,
                    top: 150,
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                Positioned(
                    left: 20,
                    top: 190,
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: hei * 0.65,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                  color: Colors.white),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 70, left: 15, right: 15),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffF8DACC),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 15, left: 10),
                            child: Text(
                              "Enter Phone Number",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: IntlPhoneField(
                              keyboardType: TextInputType.phone,
                              controller: _numbercontroller,
                              showDropdownIcon: false,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (p0) {
                                final phoneNumber =
                                    '+91${_numbercontroller.text}'; // Modify as needed
                                if (_isValidPhoneNumber(
                                        _numbercontroller.text) &&
                                    _numbercontroller.text.isNotEmpty) {
                                  _verifyPhoneNumber(context, phoneNumber);
                                } else {
                                  // Display a message or snackbar to inform the user about the incomplete phone number
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please enter a valid 10-digit phone number.'),
                                    ),
                                  );
                                }
                              },
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Phone Number',
                              ),
                              languageCode: "en",
                              initialCountryCode: 'IN',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 270,
                    left: 70,
                    right: 60,
                    child: GestureDetector(
                      onTap: isSendingOtp // Disable button while sending OTP
                          ? null
                          : () {
                              final phoneNumber =
                                  '+91${_numbercontroller.text}'; // Modify as needed
                              if (_isValidPhoneNumber(_numbercontroller.text) &&
                                  _numbercontroller.text.isNotEmpty) {
                                _verifyPhoneNumber(context, phoneNumber);
                              } else {
                                // Display a message or snackbar to inform the user about the incomplete phone number
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please enter a valid 10-digit phone number.'),
                                  ),
                                );
                              }
                            },
                      child: isSendingOtp
                          ? const Center(
                              child: CircularProgressIndicator(
                              color: Colors.red,
                            ))
                          : Container(
                              alignment: Alignment.center,
                              width: 200,
                              height: 55,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Text(
                                "Proceed",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
