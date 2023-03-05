//STATELESWIDGET

import 'package:flutter/material.dart';

class WelcomePage1 extends StatelessWidget {
  String province, regency, kecamatan, villages;

  WelcomePage1({Key? key,
    required this.province,
    required this.regency,
    required this.kecamatan,
    required this.villages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('DATA HAS BEEN RECEIVED'))),
      body:
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Province_id: $province'),
              Text('Regency_id: $regency'),
              Text('kecamatan_id: $kecamatan'),
              Text('villages_id: $villages'),
            ],
          ),
        ),
    );
  }
}
