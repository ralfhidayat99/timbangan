import 'package:flutter/material.dart';
import 'package:timbangan/controllers/theme_controller.dart';
import 'package:timbangan/controllers/timbangan_controller.dart';

class DaftarTimbangan extends StatelessWidget {
  const DaftarTimbangan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColors.bgColor.value,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15))),
      clipBehavior: Clip.antiAlias,
      child: FutureBuilder(
        future: TimbanganController.getDataTimbang(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data['timbangan']);
            List data = snapshot.data['timbangan'];
            return Column(
                children: data
                    .map((e) => ListTile(title: Text(e['id'].toString())))
                    .toList());
            // return Text('data');
          } else {
            return Row(
              children: [
                Text('data'),
              ],
            );
          }
        },
      ),
      // child: SizedBox(
      //   width: double.infinity,
      //   child: Column(
      //     children: [
      //       Text('Pembeli', style: Theme.of(context).textTheme.titleLarge),
      //     ],
      //   ),
      // ),
    );
    // return Container(
    //   height: MediaQuery.of(context).size.height,
    //   decoration: BoxDecoration(
    //       color: CustomColors.bgColor.value,
    //       borderRadius: const BorderRadius.only(topLeft: Radius.circular(15))),
    //   child: Text('data'),
    //   // child: FutureBuilder(

    //     future: TimbanganController.getDataTimbang(),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         print(snapshot.data['timbangan']);
    //         List data = snapshot.data['timbangan'];
    //         return Column(
    //             children: data
    //                 .map((e) => ListTile(title: Text(e['id'].toString())))
    //                 .toList());
    //         // return Text('data');
    //       } else {
    //         return Row(
    //           children: [
    //             Text('data'),
    //           ],
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}
