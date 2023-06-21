import 'package:flutter/material.dart';
import 'package:untitled/views/scanning.dart';

class GetStarted extends StatefulWidget {

  @override
  State<GetStarted> createState() => _GetStartedState();

}

class _GetStartedState extends State<GetStarted> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset("assets/images/trezor.png"),
            Container(height: 25,),
            Center(
              child: RichText(
                overflow: TextOverflow.clip,
                textAlign: TextAlign.end,
                textDirection: TextDirection.rtl,
                softWrap: true,
                maxLines: 1,
                textScaleFactor: 1,
                text: const TextSpan(
                  text: 'Trezor ',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      fontFamily: 'inter-bold'
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Suite', style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: 'inter-bold',
                    ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )

      ),
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(bottom: 20),
        child: MaterialButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Scanning()));
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3))
          ),
          elevation: 5,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 10,),
              Image.asset("assets/images/scan.png", width: 24, height: 24,),
              Container(width: 10,),
              const Text("Connect My Trezor", style: TextStyle(
                color: Colors.white,
                fontFamily: 'inter-medium',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),),
              Container(width: 10,),
            ],
          ),
        ),
      ),
    );
  }

}
