import 'package:flashare/models/user.dart';
import 'package:flashare/utils/user_storage.dart';
import 'package:flashare/views/screens/main_layout.dart';
import 'package:flashare/views/screens/authen/signup.dart';
import 'package:flashare/views/screens/main_tab_bar.dart';
import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home/home.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _email_controller = new TextEditingController(text: "");

  final _password_controller = new TextEditingController(text: "");

  final _form_key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Positioned(
              left: 242,
              top: -102,
              child: Container(
                width: 398,
                height: 398,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff0F9D58),
                ),
              ),
            ),
            Positioned(
              top: -441,
              left: -170,
              child: Container(
                height: 700,
                width: 700,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff4285F4).withOpacity(0.9),
                ),
              ),
            ),
            Positioned(
                top: -277,
                left: -199,
                child: Container(
                  width: 398,
                  height: 398,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffDB4437),
                  ),
                )),
            Column(
              children: [
                const SizedBox(
                  height: 88 + 44,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 36,
                    ),
                    Text(
                      "Flashare",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 46,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 101,
                ),
                Row(
                  children: const [
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      "Sign in",
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 58,
                ),
                Form(
                  key: _form_key,
                  child: Column(
                    children: [
                      RoundedInputField(
                        icon: Icons.email,
                        hintText: "Your email",
                        controller: _email_controller,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RoundedInputField(
                        hintText: "Password",
                        icon: Icons.lock,
                        controller: _password_controller,
                        isCheck: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.1,
                    ),
                    const Text(
                      "Forgot password",
                      style: TextStyle(
                        color: Color(0xffDB4437),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_form_key.currentState!.validate()) {
                          String email = _email_controller.text;
                          String password = _password_controller.text;
                          User newUser = User(ID: "", Name: "", Email: email, Password: password);

                          List respone = await newUser.SignIn();
                          if (respone[0] == false) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: const Text("Error"),
                                    content: Text(respone[1]),
                                    actions: [
                                      TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text("Close"))
                                    ],
                                  );
                                });
                          } else {
                            await SecureStorage.writeSecureData("USER_ID", respone[1]["id"]);
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              _email_controller.text = "";
                              _password_controller.text = "";
                              return const MainTabBar();
                            }));
                          }
                        }
                      },
                      child: Container(
                        height: 64,
                        width: 64,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff4285F4),
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.1,
                    )
                  ],
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have account? ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      // ignore: avoid_print
                      onTap: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => SignUp())),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 31,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 1,
                        color: const Color(0xffA8A6A7),
                      ),
                    ),
                    // const SizedBox(width: 16,),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: const Text(
                          "Sign in with",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 16,),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 1,
                        color: const Color(0xffA8A6A7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const IconButton(
                      icon: Icon(
                        FontAwesomeIcons.facebookSquare,
                        color: Color(0xff395185),
                        size: 45,
                      ),
                      onPressed: null,
                    ),
                    const SizedBox(
                      width: 63,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton(
                          onPressed: () => print("google login"),
                          style: ButtonStyle(
                            shadowColor: MaterialStateProperty.all(Colors.transparent),
                            backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          ),
                          child: Image.asset(
                            "assets/google.png",
                            height: 43,
                            width: 45,
                          )),
                    )
                  ],
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
