import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
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
                decoration: const BoxDecoration(
                    color: Color(0xff4285F4), shape: BoxShape.circle),
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
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 55,),
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
                const SizedBox(height: 36,),
                RoundedInputField(
                  hintText: "Full Name", 
                  icon: Icons.person, 
                  onChanged: (value) => {}
                ),
                const SizedBox(height: 10,),
                RoundedInputField(
                  hintText: "Your Email", 
                  icon: Icons.email,
                  onChanged: (value) => {}
                ),
                const SizedBox(height: 10,),
                RoundedInputField(
                  hintText: "Passwod", 
                  icon: Icons.lock, 
                  onChanged: (value) => {}
                ),
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 64,
                      width: 64,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff4285F4),
                      ),
                      child: const Icon(Icons.arrow_forward, color: Colors.white,),
                    ),
                    SizedBox(width: size.width * 0.1,)
                  ],
                ),
                const SizedBox(height: 95,),
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
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const SizedBox(width: 11,)
                  ],)
              ],
            )
          ],
        ),
      ),
    );
  }
}
