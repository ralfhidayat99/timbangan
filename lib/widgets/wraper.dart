import 'package:flutter/material.dart';

import '../controllers/theme_controller.dart';

class PageWrapper extends StatelessWidget {
  const PageWrapper({super.key, required this.tittle, required this.content});

  final Widget tittle;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: CustomColors.bgColor.value,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15))),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(8.0),
            child: tittle,
          ),
          const Divider(),
          content
        ],
      ),
    );
  }
}
