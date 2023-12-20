import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:suja_shoie_app/constant/utils/theme_styles.dart';

// ignore: use_key_in_widget_constructors
class BarcodeGenerator extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BarcodeGeneratorState createState() => _BarcodeGeneratorState();
}

class _BarcodeGeneratorState extends State<BarcodeGenerator> {
  final TextEditingController _controller = TextEditingController();
  String _barcodeData = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Generate Barcode'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(color: Colors.white,
              elevation: 5,shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: BarcodeWidget(drawText: false,
                    barcode: Barcode.code128(),
                    data: _barcodeData,
                    height: 150,
                    width: 300,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter Barcode Data',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.done),
                      onPressed: () {
                        setState(() {
                          _barcodeData = _controller.text;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


