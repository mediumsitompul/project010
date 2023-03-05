import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'data_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'WelcomePage1.dart';




main(){
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(title: const Center(child: Text('DROP DOWN 4 STEP\nData From REST API')),),
      body: MyDropDown(),
      ),
    );
  }
}




class MyDropDown extends StatefulWidget {
  MyDropDown({Key? key}) : super(key: key);

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {

  //...........................................................
  bool dropdown1Available = false;
  bool dropdown2Available = false;
  bool dropdown3Available = false;
  bool dropdown4Available = false;

  String? _selected1;
  String? _selected2;
  String? _selected3;
  String? _selected4;

  var data_01;
  var data_02;
  var data_03;
  var data_04;

  final String provinceid = "";
  final String regencyid = "";
  final String kecamatanid = "";
  final String villagesid = "";

  //...........................................................
  Future<void> getData1() async {
    var data1_url = "https://mediumsitompul.com/province/province.php";
    var res01 = await http.post(Uri.parse(data1_url));
    print("res01 = " + res01.toString());
    if (res01.statusCode == 200) {
      setState(() {
        data_01 = json.decode(res01.body); // data JSON like di file PHP
        print("data_01 = " + data_01.toString());

        //*************************** */
        setState(() {
          dropdown1Available = true;
        });
        //*************************** */

      });
    } else {
      setState(() {
        bool error = true;
        String message = "Error during fetching data";
      });
    }
  }

  Future<void> getData2(res01) async {
    final provinceid = res01;
    var data2_url = "https://mediumsitompul.com/province/kabupatenkota.php";
    final res02 = await http.post(Uri.parse(data2_url + "?pilihan1=" + provinceid.toString() ));
    print("res02 = " + res02.toString());

    if (res02.statusCode == 200) {
      setState(() {
        data_02 = json.decode(res02.body.toString());
        print("data_02 = " + data_02.toString());

        //*************************** */
        setState(() {
          dropdown2Available = true;
        });
        //*************************** */

      });
    } else {
      setState(() {
        bool error = true;
        String message = "Error during fetching data";
      });
    }
  }

  Future<void> getData3(res02) async {
    final regencyid = res02;
    var data3_url = "https://mediumsitompul.com/province/kecamatan.php";
    //var res03 = await http.post(Uri.parse(data3_url + "?pilihan1=" + provinceid.toString() + "&pilihan2=" + regencyid.toString())); //OK dgn design table
    final res03 = await http.post(Uri.parse(data3_url + "?pilihan2=" + regencyid.toString()));
    print("res03 = " + res03.toString());

    if (res03.statusCode == 200) {
      setState(() {
        data_03 = json.decode(res03.body.toString()); //new medium
        print("data_03 = " + data_03.toString());

        //*************************** */
        setState(() {
          dropdown3Available = true;
        });
        //*************************** */
      });
    } else {
      setState(() {
        bool error = true;
        String message = "Error during fetching data";
      });
    }
  }

  Future<void> getData4(res03) async {
    final kecamatanid = res03;
    var data4_url = "https://mediumsitompul.com/province/villages.php";
    //var res04 = await http.post(Uri.parse(data4_url + "?pilihan1=" + provinceid.toString() + "&pilihan3=" + kecamatanid.toString()));
    var res04 = await http.post(Uri.parse(data4_url + "?pilihan3=" + kecamatanid.toString()));
    print("res04 = " + res04.toString());

    if (res04.statusCode == 200) {
      setState(() {
        data_04 = json.decode(res04.body.toString()); //new medium
        print("data_04 = " + data_04.toString());

        //*************************** */
        setState(() {
          dropdown4Available = true;
        });
        //*************************** */

      });
    } else {
      setState(() {
        bool error = true;
        String message = "Error during fetching data";
      });
    }
  }

//.....................................................................

  //...........................................................
  Widget data1List() {
    List<query1DataModel> data1_list = List<query1DataModel>.from(data_01["datajs"].map((i) {
    return query1DataModel.fromJSON(i);
    },),);

    return
    DropdownButton(
      hint: const Text("Pilih Province"),//Data1
      isExpanded: true,
      items: data1_list.map((query1) {
        return DropdownMenuItem(
          child: Text(query1.provincename), //show
          value: query1.provinceid,//value
        );
      }).toList(),
      value: _selected1,
      onChanged: (newValue) {
        setState(() {
          _selected1 = newValue.toString();
          final provinceid = _selected1;
          print("_selected1 provinceid == " + _selected1.toString());
          showToastMessage(provinceid.toString());
          getData2(provinceid);  //send to input dropdown2
          _selected2 = null;
          _selected3 = null;
          _selected4 = null;
        });
      },
    );
  }


  Widget data2List() {
    List<query2DataModel> data2_list = List<query2DataModel>.from(data_02['datajs'].map((i) {
    return query2DataModel.fromJSON(i);
    }));

    return DropdownButton(
      hint: const Text("Pilih Kabupaten / Kota"),//Data2, Regency
      isExpanded: true,
      items: data2_list.map((query2) {
        return DropdownMenuItem(
          child: Text(query2.regencyname),//DATA SHOW
          value: query2.regencyid,//DATA SENDING
        );
      }).toList(),
      value: _selected2,
      onChanged: (newValue) {
        setState(() {
          _selected2 = newValue.toString();
          //_selected2 = "";

          final regencyid = _selected2; //medium new
          print("_selected2 regency == " + _selected2.toString());
          showToastMessage(regencyid.toString());
          getData3(regencyid); // medium new
          _selected3 = null;
          _selected4 = null;
        });
      },
    );
  }

  Widget data3List() {
    List<query3DataModel> data3_list = List<query3DataModel>.from(data_03['datajs'].map((i) {
    return query3DataModel.fromJSON(i);
    }));

    return DropdownButton(
      hint: const Text("Pilih Kecamatan"), //Data3, Kecamatan
      isExpanded: true,
      items: data3_list.map((query3) {
        return DropdownMenuItem(
          child: Text(query3.kecamatanname),
          value: query3.kecamatanid,
        );
      }).toList(),
      value: _selected3,
      onChanged: (newValue) {
        setState(() {
          _selected3 = newValue.toString();
          final kecamatanid = _selected3;
          print("_selected3 Kecamatan == " + _selected3.toString());
          showToastMessage(kecamatanid.toString());
          getData4(kecamatanid); //Jika tidak ada query lagi dibawahnya. STOP THIS
          _selected4 = null;
        });
      },
    );
  }

  Widget data4List() {
    List<query4DataModel> data4_list = List<query4DataModel>.from(data_04['datajs'].map((i) {
    return query4DataModel.fromJSON(i);
    }));

    return DropdownButton(
      hint: const Text("Pilih Kelurahan"),//Data4, Villages
      isExpanded: true,
      items: data4_list.map((query4) {
        return DropdownMenuItem(
          child: Text(query4.villagesname),
          value: query4.villagesid,
        );
      }).toList(),
      value: _selected4,
      onChanged: (newValue) {
        setState(() {
          _selected4 = newValue.toString();
          final villagesid = _selected4;
          print("_selected4 villages == " + _selected4.toString());
          showToastMessage(villagesid.toString());
          //get_data5(nextid); //Jika tidak ada query lagi dibawahnya. Jika tidak, maka STOP THIS
          //_selected5 = null;
        });
      },
    );
  }



  //...........................................................
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ListView(children: [
      //],)

      Container(
        padding: const EdgeInsets.all(30),
        child: Column(children: <Widget>[

          //************************ */
          dropdown1Available == false
          ?
          Container()
          :
          data1List(),
          //************************ */

          //************************ */
          dropdown2Available == false
          ?
          Container()
          :
          data2List(),
          //************************ */

          //************************ */
          dropdown3Available == false
          ?
          Container()
          :
          data3List(),
          //************************ */

          //************************ */
          dropdown4Available == false
          ?
          Container()
          :
          data4List(),
          //************************ */


          const SizedBox(
            height: 10,
          ),



          Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('SEND DATA'),
                onPressed: () {

                  print('Pressed');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WelcomePage1(

                          province: _selected1.toString(),
                          regency: _selected2.toString(),
                          kecamatan: _selected3.toString(),
                          villages: _selected4.toString(),
                          )));
                },
              ),
          ),



      //Center(child: Text('Developed by Medium'))

        ]),
      ),


    ],)

    );//scaffold
  }
  //...........................................................

  @override
  void initState() { //In this case: for Future function only
    getData1();
    getData2(provinceid);
    getData3(regencyid); // sdh mengandung provinceid
    getData4(kecamatanid); // sdh mengandung provinceid
    super.initState();
  }

}



//TOAS
  //No Build Context
  //showToastMessage("Show Toast Message on Flutter");
void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        textColor: Colors.white,
        fontSize: 16.0
        );
  }
