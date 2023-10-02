import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/auth_controller.dart';
import 'package:timbangan/controllers/setting_controller.dart';
import 'package:timbangan/controllers/theme_controller.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController tecOldPass = TextEditingController();
    TextEditingController tecNewPass = TextEditingController();
    final GlobalKey<FormState> keyPass = GlobalKey<FormState>();
    final cSetting = Get.put(SettingController());

    return Scaffold(
      backgroundColor: CustomColors.bgColor.value,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CustomColors.bgColor.value,
        foregroundColor: Theme.of(context).dividerColor,
      ),
      body: Center(
        child: Card(
            elevation: 9,
            child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: CustomColors.cardHeader.value.withAlpha(100)),
                width: MediaQuery.of(context).size.width * .7,
                height: MediaQuery.of(context).size.height * .6,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Tooltip(
                        message: 'Keluar',
                        child: IconButton(
                            onPressed: () => AuthController.logout(),
                            icon: const Icon(Icons.logout_rounded)),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.factory_outlined, size: 50),
                    ),
                    factoryField(cSetting.facName,
                        Theme.of(context).textTheme.titleLarge),
                    factoryField(cSetting.facAddress,
                        Theme.of(context).textTheme.bodyMedium),
                    factoryField(cSetting.facPhone,
                        Theme.of(context).textTheme.bodyMedium),
                    const Divider(height: 30),
                    Expanded(
                      child: Form(
                          key: keyPass,
                          child: Column(
                            children: [
                              customField(tecOldPass, 'Password Lama'),
                              const SizedBox(height: 5),
                              customField(tecNewPass, 'Password Baru'),
                              const Spacer(),
                              OutlinedButton(
                                  onPressed: () {
                                    if (keyPass.currentState!.validate()) {
                                      AuthController.changePass(
                                          tecOldPass.text, tecNewPass.text);
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() => Visibility(
                                            visible:
                                                AuthController.isLoading.value,
                                            child: const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          )),
                                      const Text(' Ganti Password'),
                                    ],
                                  ))
                            ],
                          )),
                    )
                  ],
                ))),
      ),
    );
  }

  customField(controller, label) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          errorStyle: const TextStyle(fontSize: 9, height: 0.1),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 12)),
      validator: (value) {
        if (value!.isEmpty) {
          return '$label harus diisi';
        }
        return null;
      },
    );
  }

  factoryField(RxString initVal, theme) {
    return Obx(() => SizedBox(
          height: 25,
          child: TextFormField(
            initialValue: initVal.value,
            onChanged: (value) {
              initVal.value = value;
            },
            textAlign: TextAlign.center,
            style: theme,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ));
  }
}
