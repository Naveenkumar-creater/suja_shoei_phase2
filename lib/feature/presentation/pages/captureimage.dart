import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:image/image.dart' as img;
import 'package:provider/provider.dart';
import 'package:suja_shoie_app/constant/utils/lottieLoadingAnimation.dart';
import 'package:suja_shoie_app/feature/presentation/pages/cheklist_details_page.dart';
import 'package:suja_shoie_app/feature/presentation/providers/checklist_provider.dart';

import '../../../constant/utils/theme_styles.dart';
import '../providers/asset_list_provider.dart';
import '../providers/qrscanner_provider.dart';
import '../widget/home_page_widget/work_schedule/assetlist_workschedule/asset_list_workschedule.dart';
import '../widget/home_page_widget/work_schedule/qr_workorder_data/qr_checlist_card.dart';

class CaptureImage extends StatefulWidget {
  final int planId;
  final int pageId;
  final int acrpinspectionstatus;
  final int assetid;
  const CaptureImage(BuildContext context, this.planId, this.pageId, this.acrpinspectionstatus, this.assetid, {super.key});

  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<CaptureImage> {
  final ImagePicker _picker = ImagePicker();
  final List<File?> _capturedImages = [];
  final List<String> _imageNames = [];
  bool _cancelIconVisible = false;
  String _fileSize = '';
  bool _imageCaptured = false;
  bool _processingImage = false;

  Future<void> captureAndResizeImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Set processing flag to true
      setState(() {
        _processingImage = true;
      });

      final resizedFile = await _resizeImage(pickedFile.path, 600, 400);

      if (resizedFile != null) {
        final fileSize = await resizedFile.length();
        final imageName = pickedFile.path.split('/').last;

        setState(() {
          _capturedImages.add(File(resizedFile.path));
          _imageNames.add(imageName);
          _cancelIconVisible = true;
          _fileSize = '${(fileSize / (1024)).toStringAsFixed(2)} KB';
          _imageCaptured = true;
          _processingImage = false; // Set processing flag to false
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Image resizing failed.'),
        ));

        // Set processing flag to false
        setState(() {
          _processingImage = false;
        });
      }
    }
  }

  Future<File?> _resizeImage(
      String imagePath, int maxWidth, int maxHeight) async {
    final imageFile = File(imagePath);
    final image = img.decodeImage(imageFile.readAsBytesSync());

    if (image == null) {
      return null;
    }

    final resizedImage = img.copyResize(
      image,
      width: maxWidth,
      height: maxHeight,
    );

    final resizedFile = File(imagePath)
      ..writeAsBytesSync(img.encodeJpg(resizedImage));

    return resizedFile;
  }

  void _deleteImage(int index) {
    setState(() {
      if (index >= 0 && index < _capturedImages.length) {
        _capturedImages.removeAt(index);
      }

      if (index >= 0 && index < _imageNames.length) {
        _imageNames.removeAt(index);
      }

      _cancelIconVisible = _capturedImages.isNotEmpty;
      _fileSize = '';

      _imageCaptured = _capturedImages.isNotEmpty;
    });
  }

  void _navigateBack() {
    final response = Provider.of<CheckListProvider>(context, listen: false)
        .user
        ?.responseData;
    final asset = response?.checklist ?? [];
    final qrresponse = Provider.of<QrScannerProvider>(context, listen: false)
        .user
        ?.responseData;
    final qrasset = qrresponse?.checklist ?? [];
    if (widget.pageId == 1) {
      // Access the flag from the widget
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QrCheklistCard(qrasset.first.assetbarcode),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckListCardView(
            asset.first.acrpassetId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const int data = 1;

    final response = Provider.of<AssetListProvider>(context, listen: false)
        .user
        ?.responseData;
    final asset = response?.assetListForChecklistStatus ?? [];
    final qrresponse = Provider.of<QrScannerProvider>(context, listen: false)
        .user
        ?.responseData;
    final qrasset = qrresponse?.checklist ?? [];
    return WillPopScope(
    onWillPop: () async {
        return false;
      
    },
      child: Scaffold(
        body: Center(
          child: Container(
            width: 900,
            height: 600,
            alignment: Alignment.center,
            child: Card(
              elevation: 5,
              shadowColor: Colors.black,
              child: Column(
                children: [
       const SizedBox(height: 40,),
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 225, bottom: 10),
                            child: SizedBox(
                              height: 300,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _capturedImages.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Image.file(_capturedImages[index]!),
                                      if (_cancelIconVisible)
                                        GestureDetector(
                                          onTap: () => _deleteImage(index),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white,
                                            ),
                                            child: const Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                              size: 40.0,
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _imageCaptured ? null : captureAndResizeImage,
                            child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:
                                    _imageCaptured ? Colors.grey : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.5), // Specify the shadow color here
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(
                                        0, 2), // Adjust the offset if needed
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    Icons.circle_rounded,
                                    size: 80,
                                    color: _imageCaptured
                                        ? Colors.black12
                                        : const Color.fromARGB(86, 33, 149, 243),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Capture Machine Photo along with Barcode',
                                  ),
                                  SizedBox(
                                    width: defaultPadding / 4,
                                  ),
                                  Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (_imageCaptured) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CheckPointDetails(
                                          planId: widget.planId,
                                          capturedImages: _capturedImages,
                                          pageId: widget.pageId, acrpinspectionstatus: widget.acrpinspectionstatus, assetId: widget.assetid,
                                          
                                        ),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      _imageCaptured ? Colors.blue : Colors.grey,
                                ),
                                child: const Text("Okay"),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    _navigateBack();
                                  },
                                  child: const Text("Cancel")),
                            ],
                          ),
                        ],
                      ),
                      // Overlay the loading indicator
                      if (_processingImage)
                        Container(
                          color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: LottieLoadingAnimation(),
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
    );
  }
}
