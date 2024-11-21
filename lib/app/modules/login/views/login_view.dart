import 'package:disewainaja/app/shared/components/buttons/default_button.dart';
import 'package:disewainaja/app/shared/components/inputs/text/Input_feld.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/logo/sewainaja-white.png',
            width: 200,
          ),
          elevation: 0,
          backgroundColor: Color(0xFF2943D1),
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: Stack(
              children: [
                Container(
                    height: Get.height / 2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/bg-login.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            "Log In",
                            style: GoogleFonts.lexend(
                                textStyle: TextStyle(fontSize: 30),
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                          Center(
                              child: Text(
                            "Please sign in to your existing account",
                            style: GoogleFonts.lexend(
                                textStyle: TextStyle(fontSize: 15),
                                color: Colors.white),
                          )),
                        ])),
                Positioned(
                  top: Get.height / 2 - 50,
                  child: Container(
                    width: Get.width,
                    height: Get.height / 2 + 50,
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        Obx(() => InputField(
                              label: "NIP",
                              hint: "Enter your NIP",
                              textInputAction: TextInputAction.next,
                              controller: controller.usernameController,
                              errorText: controller.usernameError.value,
                            )),
                        Obx(() => InputField(
                            label: "Password",
                            hint: "Enter your password",
                            textInputAction: TextInputAction.done,
                            controller: controller.passwordController,
                            obscureText: true,
                            errorText: controller.passwordError.value)),
                        SizedBox(height: 16),
                        DefaultButton(
                          onPressed: () {
                            controller.login();
                          },
                          text: "Log In",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
