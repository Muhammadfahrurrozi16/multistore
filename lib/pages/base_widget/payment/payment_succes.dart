import 'package:flutter/material.dart';

// import 'package:flutter/foundation.dart';

import '../../dashboard/dashboard.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class PaymentSucces extends StatefulWidget {
  const PaymentSucces({super.key});

  @override
  State<PaymentSucces> createState() => _PaymentSuccesState();
}

class _PaymentSuccesState extends State<PaymentSucces> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Pembayaran sukses',
        desc: 'Selamat Pemabayaran berhasil di lakukan',
        btnOkOnPress: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const DashboardPage();
          }));
        },
      ).show();
     });
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}