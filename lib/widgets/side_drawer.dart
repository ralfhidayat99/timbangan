import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/theme_controller.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 50,
              color: CustomColors.titleBarColor.value,
              child: Center(
                  child: Text('Tema',
                      style: Theme.of(context).textTheme.titleLarge))),
          const SizedBox(height: 10),
          const DarkLightButton(),
          const Divider()
        ],
      ),
    );
  }
}

class DarkLightButton extends StatefulWidget {
  const DarkLightButton({super.key});

  @override
  State<DarkLightButton> createState() => _DarkLightButtonState();
}

class _DarkLightButtonState extends State<DarkLightButton> {
  final cTheme = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text('Terang'),
          leading: Radio<ThemeCode>(
            value: ThemeCode.terang,
            groupValue: cTheme.darkLight,
            onChanged: (ThemeCode? value) {
              setState(() {
                cTheme.darkLight = value;
                cTheme.ligthTheme();
              });
            },
          ),
        ),
        ListTile(
          title: const Text('Gelap'),
          leading: Radio<ThemeCode>(
            value: ThemeCode.gelap,
            groupValue: cTheme.darkLight,
            onChanged: (ThemeCode? value) {
              setState(() {
                cTheme.darkLight = value;
                cTheme.darkTheme();
              });
            },
          ),
        ),
      ],
    );
  }
}

class HalfCirclePainter extends CustomPainter {
  HalfCirclePainter(this.color1, this.color2);
  Color color1;
  Color color2;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final paint1 = Paint()
      ..color = color1
      ..style = PaintingStyle.fill;
    final paint2 = Paint()
      ..color = color2
      ..style = PaintingStyle.fill;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5 * 3.14,
      3.14,
      true,
      paint1,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0.5 * 3.14,
      3.14,
      true,
      paint2,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
