import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/utils/hex_color.dart';
import 'package:untitled/views/import_wallet.dart';

class Scanning extends StatefulWidget {

  @override
  State<Scanning> createState() => _ScanningState();
}

class _ScanningState extends State<Scanning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/scanning.json',width: 340, height: 400),
              Container(height: 50,),
              Text("Scanning...", style: TextStyle(
                color: HexColor("#0119D8"),
                fontWeight: FontWeight.w600,
                fontSize: 18,
                fontFamily: 'inter-medium'
              ),)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ImportWallet()));
  }

  @override
  void initState() {
    super.initState();
    init();
  }

}
