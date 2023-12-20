// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:suja_shoie_app/feature/presentation/pages/home_page.dart';

import 'package:suja_shoie_app/feature/presentation/pages/main_page.dart';

import 'package:suja_shoie_app/constant/utils/qr_code/qrcode_overley.dart';

import '../font_styles.dart';
import '../theme_styles.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({Key? key}) : super(key: key);

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController _qrViewController;
  bool isScanCompleted = false;

  Future<void> _scanQRCode() async {
    String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Cancel',
      true,
      ScanMode.QR,
    );

    if (barcodeScanResult != '-1') {
      setState(() {
        isScanCompleted = true;
      });

      // Define the QR code to page mappings
      Map<String, Widget> codeToPageMap = {
        'YOUR_QR_CODE_1': const MainPage(),
        'YOUR_QR_CODE_2': const HomePage(),
        // Add more code-page mappings as needed
      };

      if (codeToPageMap.containsKey(barcodeScanResult)) {
        Widget page = codeToPageMap[barcodeScanResult]!;
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      } else {
        // Handle code not found or perform a default action
      }

      print('Scanned QR code: $barcodeScanResult');
    } else {
      // QR code scan cancelled
      print('QR code scan cancelled');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  QRView(
                    key: _qrKey,
                    onQRViewCreated: _onQRViewCreated,
                  ),
                   const QRScannerOverlay(overlayColour: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding * 3),
            const Expanded(
              child: Column(
                children: [
                  SizedBox(height: defaultPadding * 2),
                  Headings(
                    subHeading: 'Functionality comes here',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _qrViewController = controller;
    });
    _qrViewController.scannedDataStream.listen((scanData) {
      if (scanData.code != null && !isScanCompleted) {
        _scanQRCode();
      }
    });
  }

  @override
  void dispose() {
    _qrViewController.dispose();
    super.dispose();
  }
}
