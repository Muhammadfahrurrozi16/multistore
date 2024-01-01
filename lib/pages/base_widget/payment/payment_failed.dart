import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart';
import '../../dashboard/dashboard.dart';

class PaymentFailed extends StatefulWidget {
  const PaymentFailed({super.key});

  @override
  State<PaymentFailed> createState() => _PaymentFailedState();
}

class _PaymentFailedState extends State<PaymentFailed> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Payment Failed',
        desc: 'maaf pembayaran anda gagal',
        btnOkOnPress: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return const DashboardPage();
          }));
        },
        btnOkColor: Colors.red,
        btnOkText: 'Close',
        ).show();
     });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}