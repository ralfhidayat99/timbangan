import 'package:flutter/material.dart';

import '../../controllers/theme_controller.dart';

class SanguanPage extends StatefulWidget {
  const SanguanPage({super.key});

  @override
  State<SanguanPage> createState() => _SanguanPageState();
}

class _SanguanPageState extends State<SanguanPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(left: 5),

      decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15))
          // borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
          ),
      child: Row(
        children: [
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: CustomColors.bgColor.value,
                    borderRadius:
                        const BorderRadius.only(topLeft: Radius.circular(15))
                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                    ),
                // padding: const EdgeInsets.all(10),
                child: const Column(
                  children: [
                    Text('data'),
                  ],
                )),
          ),
          const SizedBox(width: 3),
          const Expanded(child: Text('asss')) // kolom rincian
        ],
      ),
    );
  }
}
