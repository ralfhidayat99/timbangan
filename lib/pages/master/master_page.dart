import 'package:flutter/material.dart';
import 'package:timbangan/pages/master/components/std_card.dart';
import 'package:timbangan/widgets/wraper.dart';

class MasterPage extends StatelessWidget {
  const MasterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      tittle: Text('Master', style: Theme.of(context).textTheme.titleLarge),
      content: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          StdCard(
            title: 'Kadar Air',
            value: 33,
            url: 'ka',
          ),
          StdCard(
            title: 'Hampa',
            value: 8,
            url: 'ha',
          ),
          StdCard(
            title: 'Harga Gabah',
            value: 5000,
            url: 'gbh',
          ),
          StdCard(title: 'Ongkos Kuli', value: 2000, url: 'kuli')
        ],
      ),
    );
  }
}
