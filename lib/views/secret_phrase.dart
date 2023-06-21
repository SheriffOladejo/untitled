import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/models/wallet.dart';
import 'package:untitled/utils/hex_color.dart';
import 'package:untitled/utils/methods.dart';

class SecretPhrase extends StatefulWidget {
  Wallet wallet;
  SecretPhrase({this.wallet});

  @override
  State<SecretPhrase> createState() => _SecretPhraseState();

}

class _SecretPhraseState extends State<SecretPhrase> {

  bool is_password_visible = false;
  bool is_password_focus = false;

  TextEditingController seed_controller = TextEditingController();
  TextEditingController private_key_controller = TextEditingController();
  TextEditingController passphrase_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    bool isSeed = false;
    if (widget.wallet.seed.isNotEmpty) {
      isSeed = true;
    }
    else if (widget.wallet.hex.isNotEmpty) {
      isSeed = false;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
      ),
      body: isSeed ? seed() : privateKey()
    );
  }

  Widget seed() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Secret phrase", style: TextStyle(
            color: Colors.black,
            fontFamily: 'inter-bold',
            fontSize: 24,
          ),),
          Container(height: 8,),
          const Text("", style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'inter-regular',
          ),),
          Container(height: 15,),
          const Text("Seed phrase",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'inter-regular',
            ),),
          Container(height: 8,),
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
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'inter-regular'
            ),
            readOnly: true,
            controller: seed_controller,
            minLines: 5,
            maxLines: 7,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
                focusedBorder: focusedBorder(),
                enabledBorder: enabledBorder(),
                errorBorder: errorBorder(),
                disabledBorder: disabledBorder(),
                filled: true,
                fillColor: HexColor("#F9F9FE"),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: MaterialButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: widget.wallet.seed));
                showToast("Seed copied to clipboard");
              },
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              color: HexColor("#ECE5FB"),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/copy.png", width: 20, height: 20, color: Colors.black,),
                  Container(width: 5,),
                  const Text(
                    "Copy secret phrase",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'inter-regular'
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget privateKey() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
      child: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([
            const Text("Private key", style: TextStyle(
              color: Colors.black,
              fontFamily: 'inter-bold',
              fontSize: 24,
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
            const Text("Passphrase",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'inter-regular',
              ),),
            Container(height: 5,),
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
    );
  }

  Future<void> init() async {
    seed_controller.text = widget.wallet.seed;
    passphrase_controller.text = widget.wallet.passphrase;
    private_key_controller.text = widget.wallet.hex;
  }

  @override
  void initState() {
    super.initState();
    init();
  }

}
