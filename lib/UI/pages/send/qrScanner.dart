import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../constants/colors.dart';
import '../../common_widgets/commonWidgets.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.value,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 110,
            padding: EdgeInsets.only(top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CommonWidgets().appBar(hasBack: true, title: 'Scan QR'),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            decoration: BoxDecoration(
              color: primaryBackgroundColor.value,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            constraints: BoxConstraints(minHeight: Get.height - 110, minWidth: Get.width,maxWidth: Get.width),
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: MobileScanner(
                    // fit: BoxFit.contain,
                    controller: cameraController,
                    onDetect: (capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      final Uint8List? image = capture.image;
                      for (final barcode in barcodes) {
                        debugPrint('Barcode found! ${barcode.rawValue}');
                        cameraController.dispose();
                        Get.back(result: barcode.rawValue);
                      }
                    },
                  ),
                ),
                SizedBox(height: 24,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
