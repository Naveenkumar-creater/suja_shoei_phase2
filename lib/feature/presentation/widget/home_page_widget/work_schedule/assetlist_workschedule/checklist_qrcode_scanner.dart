import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/feature/presentation/pages/captureimage.dart';
import 'package:suja_shoie_app/feature/presentation/providers/theme_providers.dart';

import '../../../../../../constant/utils/theme_styles.dart';

class QRCodeScannerPage extends StatefulWidget {
  final String expectedBarcode;
  final int plantId;
  final int acrpinspectionstatus;
  final int assetId;

  // ignore: use_key_in_widget_constructors
  const QRCodeScannerPage(this.expectedBarcode, this.plantId,
      this.acrpinspectionstatus, this.assetId);

  @override
  // ignore: library_private_types_in_public_api
  _QRCodeScannerPageState createState() => _QRCodeScannerPageState();
}

class _QRCodeScannerPageState extends State<QRCodeScannerPage> {
  String scannedBarcode = "Scanning...";
  bool showScanButton = false; // Initially, hide the "Scan Barcode" button

  @override
  void initState() {
    super.initState();
    _scanBarcode();
  }

  Future<void> _scanBarcode() async {
    try {
      final barcode = await FlutterBarcodeScanner.scanBarcode(
        "#FF0000", // Color for the scan button
        "Cancel", // Text for the cancel button
        true, // Use front camera
        ScanMode.QR, // Specify the type of code you want to scan
      );

      if (barcode == widget.expectedBarcode) {
        setState(() {
          scannedBarcode = "Matched: $barcode";

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CaptureImage(context, widget.plantId,
                  assetIdPage, widget.acrpinspectionstatus, widget.assetId),
            ),
          );
        });
      } else {
        setState(() {
          scannedBarcode = "Unknown Asset: $barcode";
          showScanButton = true; // Show the "Scan Barcode" button
        });
      }
    } catch (e) {
      setState(() {
        scannedBarcode = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("QR Code & Barcode Scanner"),
      // ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        toolbarHeight: 90,
        title: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: Container(
            color: themeProvider.isDarkTheme
                ? const Color(0xFF212121)
                : const Color(0xFF25476A),
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            height: 115,
            child: const SafeArea(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "QR Code & Barcode Scanner",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              scannedBarcode,
              style: const TextStyle(fontSize: 30.0),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            if (showScanButton)
              Card(
                elevation: 5,
                shadowColor: Colors.black,
                child: IconButton(
                  iconSize: 50,
                  onPressed: _scanBarcode,
                  icon: const Icon(
                    Icons.qr_code,
                    color: Colors.blue,
                  ),
                ),
              ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            const Text('Scan Again', style: TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
