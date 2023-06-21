import 'package:flutter/material.dart';
import 'package:untitled/adapters/wallet_adapter.dart';
import 'package:untitled/models/wallet.dart';
import 'package:untitled/utils/db_helper.dart';
import 'package:untitled/utils/hex_color.dart';
import 'package:untitled/views/import_wallet.dart';
import 'package:untitled/views/settings.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  List<Wallet> wallet_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 200,
        leading: Container(
          alignment: Alignment.center,
          child: Text("My wallets", style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            fontFamily: 'inter-bold',
          ),),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
            },
            child: Image.asset("assets/images/settings.png",)
          ),
          Container(width: 15,),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return WalletAdapter(num: index + 1, wallet: wallet_list[index], callback: callback,);
          },
          itemCount: wallet_list.length,
          shrinkWrap: true,
          controller: ScrollController(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ImportWallet()));
        },
        backgroundColor: HexColor("#0119D8"),
        child: Image.asset("assets/images/scan.png", width: 24, height: 24,),
      ),
    );
  }

  Future<void> callback() async {
    DbHelper db = DbHelper();
    wallet_list = await db.getWallets();
    print(wallet_list.length.toString());
    setState(() {

    });
  }

  Future<void> init() async {
    DbHelper db = DbHelper();
    wallet_list = await db.getWallets();
    setState(() {

    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

}
