import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String email = '';
  String password = '';
  ValueNotifier<bool> signingIn = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColour,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Image.asset(
                  'assets/MindFul_AI_Intro_Page.png',
                ),
                // Column(
                // children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 60, left: 30, right: 30, bottom: 40),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Logo_small.png',
                            height: 30,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            "MindFul AI",
                            style: TextStyle(
                                color: backgroundColour,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          )
                        ],
                        // )
                        // ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      const Text(
                        "“Nothing diminishes anxiety faster than action.”",
                        style: TextStyle(
                            color: backgroundColour,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        "Help us help you! 👋",
                        style: TextStyle(
                            color: backgroundColour,
                            fontWeight: FontWeight.w600,
                            fontSize: 24),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      TextFormField(
                        // onTapOutside: (event) {
                        //   FocusManager.instance.primaryFocus?.unfocus();
                        // },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be left blank';
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },

                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        style: const TextStyle(
                            // color: Colors.grey[600]
                            ),
                        decoration: getInputDecoration(
                            "College email",
                            "Please enter your College email",
                            const Icon(Icons.email)),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        // onTapOutside: (event) {
                        //   FocusManager.instance.primaryFocus?.unfocus();
                        // },
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Field cannot be left blank';
                          } else {
                            return null;
                          }
                        }),
                        controller: passwordController,
                        obscureText: true,
                        decoration: getInputDecoration(
                            'Password',
                            'Please enter your password',
                            const Icon(Icons.lock)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ValueListenableBuilder(
                          valueListenable: signingIn,
                          builder: (context, value, child) {
                            return value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: greenColour,
                                    ),
                                  )
                                : RawMaterialButton(
                                    elevation: 4,
                                    fillColor: greenColour,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0, vertical: 12.0),
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        signIn(context);
                                      }
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(color: Colors.white),
                                    ));
                          })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signIn(context) async {
    try {
      signingIn.value = true;
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (error) {
      print("Asdfa");
      print(error.code);
      print("Asdfa");
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      if (error.code == 'invalid-email') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Invalid Email!!')));
      } else if (error.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User not found!!')));
      } else if (error.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect Password!!')));
      } else if (error.code == 'network-request-failed') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please connect to the internet!!')));
      } else if (error.code == 'INVALID_LOGIN_CREDENTIALS') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Registering User...'),
          duration: Duration(seconds: 2),
        ));
        await registerUser(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong!!')));
    }
    signingIn.value = false;
  }

  Future registerUser(context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      if (error.code == 'invalid-email') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Invalid Email!!')));
      } else if (error.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Already Exists!!')));
      } else if (error.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please use a Stronger Password!!')));
      } else if (error.code == 'network-request-failed') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please connect to the internet!!')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Something went wrong!!')));
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("just_registered", true);

    signingIn.value = false;
  }
}

InputDecoration getInputDecoration(String label, String hint, Icon icon) {
  return InputDecoration(
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.white),
      borderRadius: BorderRadius.circular(15),
    ),
    helperStyle: const TextStyle(color: greenColour),
    suffixIconColor: greenColour,
    suffixIcon: icon,
    labelText: label,
    labelStyle: const TextStyle(fontWeight: FontWeight.w500),
    hintText: hint,
    filled: true,
    fillColor: Colors.white.withOpacity(0.7),
  );
}

final emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$');
