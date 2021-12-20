import 'package:flashare/views/screens/main_layout.dart';
import 'package:flashare/views/screens/signup.dart';
import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
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
              RoundedInputField(
                icon: Icons.email,
                hintText: "Your email",
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 10,
              ),
              RoundedInputField(
                  hintText: "Password",
                  icon: Icons.lock,
                  onChanged: (value) {}),
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
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen())),
                    child: Container(
                      height: 64,
                      width: 64,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff4285F4),
                      ),
                      child: const Icon(Icons.arrow_forward, color: Colors.white,),
                    ),
                  ),
                  SizedBox(width: size.width * 0.1,)
                ],
              ),
              const SizedBox(height: 14,),
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
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp())),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 31,),
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
                        style: TextStyle(
                          fontSize: 16
                        ),
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
              const SizedBox(height: 20,),
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
                  const SizedBox(width: 63,),
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
                      )
                    ),
                  )
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}