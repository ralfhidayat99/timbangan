import 'package:flutter/material.dart';
import 'package:timbangan/controllers/auth_controller.dart';
import 'package:timbangan/controllers/theme_controller.dart';

import '../../utils/storage.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    DataStorage storage = DataStorage();
    var pabrik = storage.box.read('pabrik');
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
                    Text(
                      pabrik['name'],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      pabrik['address'],
                    ),
                    Text(
                      pabrik['phone'],
                    ),
                    const Divider(),
                  ],
                ))),
      ),
    );
  }
}
