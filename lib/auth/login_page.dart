import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/auth_controller.dart';
import 'package:timbangan/controllers/theme_controller.dart';

import '../widgets/titlebar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController cUsername = TextEditingController();
    TextEditingController cPassword = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.blue[200], // Kombinasi warna latar belakang
      body: Column(
        children: [
          if (!kIsWeb)
            // ignore: prefer_const_constructors
            TitleBar(),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 450,
                  child: Icon(
                    Icons.fit_screen,
                    size: 200,
                    color: CustomColors.bgColor.value.withAlpha(50),
                  ),
                ),
                Positioned(
                  top: 250,
                  right: 50,
                  child: Icon(
                    Icons.fit_screen,
                    size: 100,
                    color: CustomColors.bgColor.value.withAlpha(50),
                  ),
                ),
                Positioned(
                  top: 460,
                  left: 50,
                  child: Icon(
                    Icons.fit_screen,
                    size: 500,
                    color: CustomColors.bgColor.value.withAlpha(50),
                  ),
                ),
                Positioned(
                  top: 360,
                  right: -100,
                  child: Icon(
                    Icons.fit_screen,
                    size: 190,
                    color: CustomColors.bgColor.value.withAlpha(50),
                  ),
                ),
                Positioned(
                  top: -110,
                  left: -50,
                  child: Icon(
                    Icons.fit_screen,
                    size: 250,
                    color: CustomColors.bgColor.value.withAlpha(50),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 60,
                  child: Icon(
                    Icons.fit_screen,
                    size: 300,
                    color: CustomColors.bgColor.value.withAlpha(50),
                  ),
                ),
                Center(
                  child: Card(
                    elevation: 10,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * .5,
                      width: MediaQuery.of(context).size.width * .5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.timelapse,
                            size: 100,
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              controller: cUsername,
                              decoration: const InputDecoration(
                                labelText: 'Username',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 250,
                            child: TextField(
                              obscureText: true,
                              controller: cPassword,
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => AuthController.login(
                                cUsername.text, cPassword.text),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 15),
                            ),
                            child: Obx(() => SizedBox(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Visibility(
                                        visible: AuthController.isLoading.value,
                                        child: const SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const Text(
                                        ' Login',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
