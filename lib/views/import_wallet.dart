import 'package:flutter/material.dart';
import 'package:untitled/utils/hex_color.dart';
import 'package:untitled/views/phrase.dart';
import 'package:untitled/views/private_key.dart';

class ImportWallet extends StatefulWidget {

  const ImportWallet({Key key}) : super(key: key);

  @override
  State<ImportWallet> createState() => _ImportWalletState();

}

class _ImportWalletState extends State<ImportWallet> {

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
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Import Trezor Wallet", style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              fontFamily: 'inter-bold',
            ),),
            Container(height: 15,),
            const Text("Select an option", style: TextStyle(
              color: Colors.black,
              fontFamily: 'inter-regular',
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),),
            Container(height: 15,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddPhrase()));
              },
              child: Container(
                width: 340,
                height: 70,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  color: HexColor("#F9F9FE"),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Recovery phrase", style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'inter-regular',
                    ),),
                    Container(height: 5,),
                    const Text("12 or 24 word phrase", style: TextStyle(
                      fontFamily: 'inter-regular',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 10,
                    ),),
                  ],
                ),
              ),
            ),
            Container(height: 15,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrivateKey()));
              },
              child: Container(
                width: 340,
                height: 70,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                decoration: BoxDecoration(
                  color: HexColor("#F9F9FE"),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Raw seed", style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'inter-regular',
                    ),),
                    Container(height: 5,),
                    const Text("Hexadecimal string", style: TextStyle(
                      fontFamily: 'inter-regular',
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 10,
                    ),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
