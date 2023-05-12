import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_api/model/kategori_barang_model.dart';

class KategoriBarangController{
  final String apiUrl = "http://10.0.2.2:8000/api/";

  Future<List<KategoriBarangModel>> getKategoriBarang() async{
    var result = await http.get(Uri.parse("${apiUrl}barang/getAllKB/"));
    if(result.statusCode == 200){
      var data = jsonDecode(result.body); // json to map
      List<KategoriBarangModel> kategoriBarang = []; // list of kategori barang
      for(var i in data){
        // loop data
        KategoriBarangModel kategoriModel = KategoriBarangModel.fromMap(i); // map to kategoriModel Barang
        kategoriBarang.add(kategoriModel); // add kategoriBarang to list
      }
      
      return kategoriBarang;
    }else{
      throw Exception("Gagal mengambil data kategori barang");
    }
  }

  Future addKategoriBarang(KategoriBarangModel kategoriBarang) async{
    var result = await http.post(Uri.parse("${apiUrl}barang/addKB"), 
    body:{
      "nama_kategori_barang": kategoriBarang.nama,
    });

    if(result.statusCode == 200){
      return jsonDecode(result.body);
    }else{
      throw Exception("Gagal menambahkan data kategori barang");
    }
  }
}