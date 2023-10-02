import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/timbangan_controller.dart';
import 'package:timbangan/utils/formatter.dart';

class RekapPanel extends StatefulWidget {
  const RekapPanel({super.key});

  @override
  State<RekapPanel> createState() => _RekapPanelState();
}

class _RekapPanelState extends State<RekapPanel> {
  late ScrollController scrollController;

  ///The controller of sliding up panel
  SlidingUpPanelController panelController = SlidingUpPanelController();

  double minBound = 0;

  double upperBound = 1.0;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.expand();
      } else if (scrollController.offset <=
              scrollController.position.minScrollExtent &&
          !scrollController.position.outOfRange) {
        panelController.anchor();
      } else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanelWidget(
      controlHeight: 50.0,
      anchor: 0.4,
      minimumBound: minBound,
      upperBound: upperBound,
      panelController: panelController,
      onTap: () {
        ///Customize the processing logic
        if (SlidingUpPanelStatus.expanded == panelController.status) {
          panelController.collapse();
        } else {
          panelController.expand();
        }
      },
      enableOnTap: true,
      //Enable the onTap callback for control bar.

      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: ShapeDecoration(
          color: Theme.of(context).cardColor,
          shadows: const [
            BoxShadow(
                blurRadius: 5.0, spreadRadius: 2.0, color: Color(0x11000000))
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
        ),
        child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 3,
                  width: 100,
                  margin: const EdgeInsets.only(top: 5),
                  decoration:
                      BoxDecoration(color: Theme.of(context).dividerColor),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  height: 30.0,
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.receipt_long,
                        size: 15,
                      ),
                      Text(
                          ' ${formatRupiah(TimbanganController.rekap.value.totalTransaksi)} '),
                      const Text('Transaksi'),
                      const Spacer(),
                      const Icon(
                        Icons.radio_button_checked,
                        size: 15,
                      ),
                      Text(
                        ' ${formatTonase(double.parse(TimbanganController.rekap.value.totalNetto.toString()))}',
                      ),
                      const VerticalDivider(),
                      const Icon(
                        Icons.radio_button_checked,
                        size: 15,
                      ),
                      Text(
                        ' Rp ${formatRupiah(TimbanganController.rekap.value.totalBayar)}',
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 10,
                  color: Colors.grey[300],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            cardAverage(
                                TimbanganController.rekap.value.rataHampa,
                                'Rata-rata Hampa'),
                            cardAverage(
                                TimbanganController.rekap.value.rataKadarair,
                                'Rata-rata Kadar Air'),
                            cardAverage(
                                TimbanganController.rekap.value.rataTara,
                                'Rata-rata Tara'),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text('Total biaya Kuli: '),
                            Text(
                                'Rp ${formatRupiah(TimbanganController.rekap.value.totalBiayaKuli)}',
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Total biaya Karung: '),
                            Text(
                                'Rp ${formatRupiah(TimbanganController.rekap.value.totalBiayaKarung)}',
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Total biaya Angkut: '),
                            Text(
                                'Rp ${formatRupiah(TimbanganController.rekap.value.totalBiayaAngkut)}',
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  cardAverage(n, title) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: [
              Text('$n%',
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold)),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
