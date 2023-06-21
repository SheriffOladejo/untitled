import 'package:flutter/material.dart';
import 'package:untitled/utils/hex_color.dart';
import 'package:untitled/utils/methods.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {

  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();

}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Settings", style: TextStyle(
          color: Colors.black,
          fontFamily: 'inter-bold',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.black,),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                var url = "https://lukka.tech/privacy-policy/";
                if(await canLaunch(url)){
                  await launch(url);
                }
                else{
                  showToast("Cannot launch URL");
                }
              },
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: HexColor("#F9F9FE"),
                ),
                child: Row(
                  children: [
                    Container(width: 15,),
                    Image.asset("assets/images/privacy_policy.png"),
                    Container(width: 10,),
                    Text("Privacy policy", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'inter-regular',
                    ),),
                  ],
                ),
              ),
            ),
            Container(height: 15,),
            GestureDetector(
              onTap: () async {
                var url = "https://lukka.tech/terms-of-use/";
                if(await canLaunch(url)){
                  await launch(url);
                }
                else{
                  showToast("Cannot launch URL");
                }
              },
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: HexColor("#F9F9FE"),
                ),
                child: Row(
                  children: [
                    Container(width: 15,),
                    Image.asset("assets/images/terms_of_use.png"),
                    Container(width: 10,),
                    Text("Terms of use", style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'inter-regular',
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
