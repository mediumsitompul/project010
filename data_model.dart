//Propinsi
class query1DataModel {
  var provincename;
  var provinceid;
  query1DataModel({required this.provincename, required this.provinceid});
  factory query1DataModel.fromJSON(Map<String, dynamic> datarow) {
    var provinceid = datarow['province_id'];
    var provincename = datarow['province_name'];
    return query1DataModel(provincename: provincename, provinceid: provinceid);
  }
}


//Kabupaten / Kota
class query2DataModel {
  var regencyid;
  var regencyname;
  query2DataModel({required this.regencyid, required this.regencyname});
  factory query2DataModel.fromJSON(Map<String, dynamic> datarow) {
    var regencyid = datarow['regency_id'] as String;
    var regencyname = datarow['regency_name'] as String;
    return query2DataModel(regencyid: regencyid, regencyname: regencyname);
  }
}



//Kecamatan
class query3DataModel {
  var kecamatanid;
  var kecamatanname;
  query3DataModel({required this.kecamatanid, required this.kecamatanname});
  factory query3DataModel.fromJSON(Map<String, dynamic> datarow) {
    var kecamatanid = datarow['kecamatan_id'] as String;
    var kecamatanname = datarow['kecamatan_name'] as String;
    return query3DataModel(kecamatanid: kecamatanid, kecamatanname: kecamatanname);
  }
}



//Kelurahan
class query4DataModel {
  var villagesid;
  var villagesname;
  query4DataModel({required this.villagesid,required this.villagesname });
  factory query4DataModel.fromJSON(Map<String, dynamic> datarow) {
    var villagesid = datarow['villages_id'] as String;
    var villagesname = datarow['villages_name'] as String;
    return query4DataModel(villagesid: villagesid, villagesname: villagesname);
  }
}
