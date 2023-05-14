import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practice_api/controller/kategori_barang_controller.dart';
import 'package:practice_api/model/kategori_barang_model.dart';
import 'package:practice_api/view/kategoriBarang/add_kategori_barang.dart';
import 'package:practice_api/view/kategoriBarang/edit_kategori_barang.dart';

class KategoriBarang extends StatefulWidget {
  const KategoriBarang({super.key});

  @override
  State<KategoriBarang> createState() => _KategoriBarangState();
}

class _KategoriBarangState extends State<KategoriBarang> {
  final kategoriBarangController = KategoriBarangController();
  List<KategoriBarangModel> listKategoriBarang = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getKategoriBarang();
  }

  void getKategoriBarang() async {
    final kategoriBarang = await kategoriBarangController.getKategoriBarang();
    setState(() {
      listKategoriBarang = kategoriBarang;
    });
  }

  void deleteDataBarang(KategoriBarangModel kategoriBarang) {
    setState(() {
      listKategoriBarang.remove(kategoriBarang);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kategori Barang"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: listKategoriBarang.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(listKategoriBarang[index].nama),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditKategoriBarang(
                                      beforeKategoriName:
                                          listKategoriBarang[index].nama,
                                      id: listKategoriBarang[index].id,
                                    )));
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                        onPressed: () async {
                          kategoriBarangController
                              .deleteData(listKategoriBarang[index].id)
                              .then((value) {
                            setState(() {
                              listKategoriBarang.removeAt(index);
                            });
                          });

                          var snackBar = const SnackBar(
                              content: Text('Data Berhasil Dihapus'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: const Icon(Icons.delete, color: Colors.red))
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddKategoriBarang()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
