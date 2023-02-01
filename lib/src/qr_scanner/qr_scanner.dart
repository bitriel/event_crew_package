import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:event_crew/src/components/dialog_c.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {

  final Function? func;
  final String? title;
  final String? hallId;

  const QrScanner({Key? key, required this.title, required this.func, this.hallId}) : super(key: key);

  // final List portList;
  // final WalletSDK sdk;
  // final Keyring keyring;

  // QrScanner({this.portList, this.sdk, this.keyring});

  @override
  State<StatefulWidget> createState() {
    return QrScannerState();
  }
}

class QrScannerState extends State<QrScanner> {

  final GlobalKey qrKey = GlobalKey();
  
  QRViewController? _qrViewController;

  Future? _onQrViewCreated(QRViewController controller) async {

    _qrViewController = controller;
    _qrViewController!.resumeCamera();
    try {

      _qrViewController!.scannedDataStream.listen((event) async {
        _qrViewController!.pauseCamera();

        // Navigator.pop(context, event.code);

        await qrData(event.code!);

      });

    } catch (e) {
      if (kDebugMode) {
        print("qr create $e");
      }
    }

    return _qrViewController!;
  }
  
  Future<void> qrData(String data) async {
    
    DialogCom().dialogLoading(context);
    
    await widget.func!('', data);
    
    await _qrViewController!.resumeCamera();
    
    // Close Dialog Loading
    // ignore: use_build_context_synchronously
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: AnimatedTextKit(
          repeatForever: true,
          pause: const Duration(seconds: 1),
          animatedTexts: [

            TypewriterAnimatedText(
              widget.title!,
              textAlign: TextAlign.center,
              textStyle: const TextStyle(
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),

          ],
        ),

        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

        actions: const [
          // Container(
          //   margin: EdgeInsets.only(right: 15),
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: widget.hallId == null 
          //     ? Container() 
          //     : Consumer<MDWSocketProvider>(
          //       builder: (context, provider, child) {
          //         return AnimatedTextKit(
          //           // pause: Duration(milliseconds: 300),
          //           repeatForever: true,
          //           animatedTexts: [
                      
          //             FadeAnimatedText(
          //               widget.hallId == 'vga' ? provider.vga.checkIn.toString() : provider.tga.checkIn.toString(), 
          //               textStyle: TextStyle(color: Color.fromARGB(255, 0, 234, 8), fontSize: 19, fontWeight: FontWeight.bold),
          //               duration: Duration(
          //                 milliseconds: 2000
          //               )
          //             ),
          //             // MyText(text: widget.hallId == 'vga' ? provider.vga.checkIn.toString() : provider.tga.checkIn.toString(), color2: Colors.green, right: 10, fontWeight: FontWeight.bold, fontSize: 17,);
          //           ],
          //           onTap: () {
          //             print("Tap Event");
          //           },
          //         );
                  
          //       }
          //     )
          //   ),
          // )
        ],
      ),

      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        
        child: Column(
          children: [
            
            Expanded(
              child: Stack(
                children: [

                  QRView(
                    key: qrKey,
                    onQRViewCreated: (QRViewController qrView) async {
                      await _onQrViewCreated(qrView);
                    },
                    overlay: QrScannerOverlayShape(
                      borderColor: Colors.white,
                      borderRadius: 10,
                      borderWidth: 5,
                    ),
                  ),
                ]
              )
            ),
          ],
        ),
      ),
    );
  }
}
