import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:timbangan/controllers/timbangan_controller.dart';
import 'package:timbangan/pages/daftar/components/rekap_panel.dart';
import 'package:timbangan/pages/daftar/components/timbangan_item.dart';
import 'package:timbangan/utils/formatter.dart';
import 'package:timbangan/widgets/wraper.dart';

class DaftarTimbangan extends StatefulWidget {
  const DaftarTimbangan({super.key});

  @override
  State<DaftarTimbangan> createState() => _DaftarTimbanganState();
}

class _DaftarTimbanganState extends State<DaftarTimbangan> {
  String tglAwal = DateFormat('y-MM-dd').format(DateTime.now());
  String tglAkhir = DateFormat('y-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      tittle: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: Text('Daftar Transaksi',
                    style: Theme.of(context).textTheme.titleLarge),
              ),
              OutlinedButton(
                  onPressed: () => Get.defaultDialog(
                        title: 'Pilih Tangal',
                        onConfirm: () {
                          Get.back();
                          setState(() {});
                        },
                        content: SizedBox(
                            height: 300,
                            width: 400,
                            child: SfDateRangePicker(
                                selectionMode:
                                    DateRangePickerSelectionMode.range,
                                showNavigationArrow: true,
                                onSelectionChanged: _onSelectionChanged)),
                      ),
                  child: Row(
                    children: [
                      const Icon(Icons.date_range),
                      Text(filterView())
                    ],
                  )),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.analytics_outlined))
            ],
          )),
      content: Stack(
        children: [
          FutureBuilder(
            future: TimbanganController.getDataTimbang(tglAwal, tglAkhir),
            builder: (context, snapshot) {
              Widget child;
              if (snapshot.connectionState == ConnectionState.done) {
                List data = snapshot.data;
                child = data.isNotEmpty
                    ? TimbanganItem(data: snapshot.data)
                    : const Align(
                        alignment: Alignment.center,
                        child: Text('Tidak Ada Data'));
              } else {
                child = const SizedBox();
              }
              return SizedBox(
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      AnimatedSwitcher(
                          duration: 500.milliseconds,
                          transitionBuilder: (child, animation) {
                            const begin = Offset(0.0, 0.2);
                            const end = Offset.zero;
                            const curve = Curves.fastLinearToSlowEaseIn;
                            final tween = Tween(begin: begin, end: end);
                            final curvedAnimation = CurvedAnimation(
                                parent: animation, curve: curve);
                            return SlideTransition(
                              position: tween.animate(curvedAnimation),
                              child: child,
                            );
                          },
                          child: child)
                    ],
                  ),
                ),
              );
            },
          ),
          const RekapPanel()
        ],
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    PickerDateRange tgl = args.value;
    tglAwal = tgl.startDate.toString().split(' ')[0];
    tglAkhir =
        tgl.endDate != null ? tgl.endDate.toString().split(' ')[0] : tglAwal;
  }

  String filterView() {
    String awal = formatTanggal(DateTime.parse(tglAwal));
    String akhir = formatTanggal(DateTime.parse(tglAkhir));

    return akhir == awal ? awal : '$awal - $akhir';
  }
}
