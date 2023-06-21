import 'package:flutter/material.dart';
import 'package:untitled/models/wallet.dart';
import 'package:untitled/utils/db_helper.dart';
import 'package:untitled/utils/hex_color.dart';
import 'package:untitled/views/get_started.dart';
import 'package:untitled/views/home_screen.dart';
class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        color: HexColor("#ffffff"),
        child: Center(
            child: Image.asset("assets/images/trezor.png", width: 200, height: 200,)
        ),
      ),
    );
  }

  Future init() async {
    Future.delayed(const Duration(seconds: 2), () async {
      DbHelper db = DbHelper();
      List<Wallet> l = await db.getWallets();
      if (l.isEmpty) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GetStarted()));
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
      }
    });
  }

  @override
  void initState(){
    super.initState();
    init();
  }

}
