import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:timbangan/controllers/pelanggan_controller.dart';

import '../../../controllers/theme_controller.dart';
import '../../../controllers/timbangan_controller.dart';
import '../../../models/pelanggan_model.dart';
import 'textfiled.dart';

Widget inputFields(
    context, TimbanganController cDataTimbang, keyTimbang, keyPembeli) {
  SuggestionsBoxController suggestionBoxController = SuggestionsBoxController();

  return SizedBox(
    height: MediaQuery.of(context).size.height * .42,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              // color: Colors.green,
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    // padding: const EdgeInsets.all(5),
                    width: double.infinity,
                    decoration: headingDecoration(10),
                    child: Row(
                      children: [
                        Text('Pembeli',
                            style: Theme.of(context).textTheme.titleLarge),
                        const Spacer(),
                        Obx(() => Text('No : ${cDataTimbang.noTimbang.value}',
                            style: Theme.of(context).textTheme.titleLarge)),
                      ],
                    ),
                  ),
                  const Divider(),
                  Form(
                    key: keyPembeli,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: CustomColors.windowBtnArea.value,
                          child: TypeAheadFormField(
                            textFieldConfiguration: TextFieldConfiguration(
                              // onEditingComplete: () => PelangganController.selectedPelanggan = Pelanggan.empty(),
                              onChanged: (value) => PelangganController
                                  .selectedPelanggan.value = Pelanggan.empty(),
                              decoration: InputDecoration(
                                  errorStyle:
                                      TextStyle(fontSize: 9, height: 0.1),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 12),
                                  border: OutlineInputBorder(),
                                  labelText: 'Pembeli'),
                              controller: PelangganController.tNama,
                            ),
                            suggestionsCallback: (pattern) {
                              return PelangganController.getSuggestions(
                                  pattern);
                            },
                            itemBuilder: (context, Pelanggan suggestion) {
                              return ListTile(
                                title: Text(suggestion.nama),
                                subtitle: Text(suggestion.alamat),
                              );
                            },
                            itemSeparatorBuilder: (context, index) {
                              return const Divider();
                            },
                            transitionBuilder:
                                (context, suggestionsBox, controller) {
                              return suggestionsBox;
                            },
                            onSuggestionSelected: (Pelanggan suggestion) {
                              PelangganController.tNama.text = suggestion.nama;
                              PelangganController.tAlamat.text =
                                  suggestion.alamat;
                              PelangganController.selectedPelanggan.value =
                                  suggestion;
                            },
                            suggestionsBoxController: suggestionBoxController,
                            validator: (value) =>
                                value!.isEmpty ? 'Nama harus diisi' : null,
                          ),
                        ),
                        const SizedBox(height: 5),
                        customTextField(PelangganController.tAlamat, 'Alamat',
                            () {}, false),
                        const SizedBox(height: 5),
                        customTextField(
                            cDataTimbang.tNopol, 'No. Kendaraan', () {}, false),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 70,
                    width: 100,
                    child: Center(
                      child: Obx(() => AnimatedContainer(
                          duration: 100.milliseconds,
                          height:
                              PelangganController.selectedPelanggan.value.id !=
                                      ''
                                  ? 0
                                  : 30,
                          child: ElevatedButton(
                            onPressed: () {
                              if (keyPembeli.currentState.validate()) {
                                PelangganController.addCustomer();
                              }
                            },
                            child: Row(
                              children: [
                                if (PelangganController.isProcessing.value)
                                  const SizedBox.square(
                                    dimension: 10,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Expanded(
                                  child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text('Tambahkan')),
                                ),
                              ],
                            ),
                          ))),
                    ),
                  )
                ],
              )),
        ),
        Expanded(
          flex: 1,
          child: Container(
            // color: CustomColors.bgColor.value,
            // color: Colors.amber,
            padding: const EdgeInsets.all(8),
            child: Form(
              key: keyTimbang,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    // padding: const EdgeInsets.all(4),
                    // decoration: headingDecoration(0),
                    child: Text('Data Timbang',
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  const Divider(),
                  customTextField(cDataTimbang.cTimbangan, 'Timbangan',
                      cDataTimbang.hitungKampas, true),
                  const SizedBox(height: 4),
                  customTextField(cDataTimbang.cKarung, 'Karung',
                      cDataTimbang.hitungKampas, true),
                  const SizedBox(height: 4),
                  customTextField(cDataTimbang.cKA, 'Kadar Air',
                      cDataTimbang.hitungTara, true),
                  const SizedBox(height: 4),
                  customTextField(
                      cDataTimbang.cHA, 'Hampa', cDataTimbang.hitungTara, true),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

BoxDecoration headingDecoration(double radius) {
  return BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(radius)));
}
