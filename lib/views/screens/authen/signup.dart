import 'package:flashare/models/user.dart';
import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _name_controller = new TextEditingController(text: "");

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
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                left: -264,
                top: -462,
                child: Container(
                  height: 700,
                  width: 700,
                  decoration: const BoxDecoration(color: Color(0xff4285F4), shape: BoxShape.circle),
                ),
              ),
              Positioned(
                left: 93,
                bottom: -150,
                child: Image.asset("assets/Ellipse.png"),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 55,
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
                        "Sign up",
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  Form(
                    key: _form_key,
                    child: Column(
                      children: [
                        RoundedInputField(
                          hintText: "Full Name",
                          icon: Icons.person,
                          controller: _name_controller,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RoundedInputField(
                          hintText: "Your Email",
                          icon: Icons.email,
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
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (_form_key.currentState!.validate()) {
                                  String name = _name_controller.text;
                                  String email = _email_controller.text;
                                  String password = _password_controller.text;
                                  User newUser =
                                      User(ID: "", Name: name, Email: email, Password: password);
                                  List respone = await newUser.SignUp();
                                  if (respone[0] == false) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: Text("Error"),
                                            content: Text(respone[1]),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: Text("Close"))
                                            ],
                                          );
                                        });
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: Text("Create successful"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    _email_controller.text = "";
                                                    _password_controller.text = "";
                                                    _name_controller.text = "";
                                                    // Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Close"))
                                            ],
                                          );
                                        });
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 95,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Already have an accounnt? ",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        // ignore: avoid_print
                        onTap: () {
                          _name_controller.text = "";
                          _email_controller.text = "";
                          _password_controller.text = "";
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
