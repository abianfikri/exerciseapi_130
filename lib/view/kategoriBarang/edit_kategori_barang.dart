import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_api/controller/kategori_barang_controller.dart';
import 'package:practice_api/view/kategoriBarang/kategori_barang.dart';

class EditKategoriBarang extends StatefulWidget {
  const EditKategoriBarang({super.key, this.id, this.beforeKategoriName});

  // membuat variable id, dan nama kategori barang sebelum di update
  final int? id;
  final String? beforeKategoriName;

  @override
  State<EditKategoriBarang> createState() => _EditKategoriBarangState();
}

class _EditKategoriBarangState extends State<EditKategoriBarang> {

  final kategoriController = KategoriBarangController();
  String? namaKategori;

  @override
  Widget build(BuildContext context) {

    var formkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Kategori Barang'),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nama Kategori Barang',
                labelText: 'Nama Kategori Barang',
              ),
              onChanged: (value) {
                namaKategori = value;
              },
              initialValue: widget.beforeKategoriName ,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama Kategori is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if(formkey.currentState!.validate()){
                  formkey.currentState!.save();
                  kategoriController.updateDataKategori(widget.id!, namaKategori!);

                  Navigator.pushReplacement(context, 
                  MaterialPageRoute(
                    builder: (context) => const KategoriBarang()));

                    var snackBar = const SnackBar(content: Text("Data berhasil DiUpdate"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
