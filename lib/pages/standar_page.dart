import 'package:flutter/material.dart';
import '../../controllers/theme_controller.dart';

class StandardPage extends StatelessWidget {
  const StandardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColors.bgColor.value,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15))),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text('Pembeli', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}
