import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:purva/bottomNav.dart';
import 'package:purva/login_screen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const OtpScreen(
      {Key? key, required this.verificationId, required this.phoneNumber})
      : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController pincontroller = TextEditingController();
  bool isVerifying = false;
  bool isResendingOTP = false;
  @override
  void dispose() {
    // TODO: implement dispose
    pincontroller.dispose();
    super.dispose();
  }

  Future<void> _signInWithPhoneNumber(
      String verificationId, String smsCode) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      setState(() {
        isVerifying = true;
      });

      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const BottomNav(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Phone authentication failed.'),
          ),
        );
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error verifying OTP. Please try again.'),
        ),
      );
    } finally {
      setState(() {
        isVerifying = false;
      });
    }
  }

  Future<void> _resendOTP(String phoneNumber) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      setState(() {
        isResendingOTP =
            true; // Start resending OTP, show CircularProgressIndicator
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP Resent to ${widget.phoneNumber}'),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto retrieval timeout
        },
      );
    } catch (e) {
      print('Error resending OTP: $e');
    } finally {
      setState(() {
        isResendingOTP =
            false; // Stop resending OTP, hide CircularProgressIndicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>
                 const LoginScreen()
                ));
              },
            );
          },
        ),
        title: const Text(
          "Phone Verification",
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Column(
        children: [
          const Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage("assets/images/password.jpeg"),
                width: 250,
                height: 250,
              )),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "OTP Verification",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Enter code send to ${widget.phoneNumber}",
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          Pinput(
            controller: pincontroller,
            length: 6,
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              if (pincontroller.text.isNotEmpty) {
                _signInWithPhoneNumber(
                    widget.verificationId, pincontroller.text);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter the code'),
                  ),
                );
              }
            },
            defaultPinTheme: const PinTheme(
                width: 35,
                height: 50,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 2, color: Colors.orange)))),
            keyboardType: TextInputType.number,
            mainAxisAlignment: MainAxisAlignment.center,
            pinAnimationType: PinAnimationType.scale,
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text("Didn't recieve the code? "),
              InkWell(
                onTap: isResendingOTP
                    ? null
                    : () {
                        final phoneNumber = '+91${widget.phoneNumber}';
                        _resendOTP(phoneNumber);
                      },
                child: isResendingOTP
                    ? const CircularProgressIndicator()
                    : const Text(
                        "RESEND",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w700),
                      ),
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            // onTap: () {
            //   verifyOTP();
            // },
            onTap: isVerifying
                ? null
                : () {
                    final smsCode = pincontroller.text;
                    if (pincontroller.text.isNotEmpty) {
                      _signInWithPhoneNumber(widget.verificationId, smsCode);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter the code'),
                        ),
                      );
                    }
                  },
            child: isVerifying
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Colors.red,
                  ))
                : Container(
                    width: 250,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    )),
          )
        ],
      )),
    );
  }
}
