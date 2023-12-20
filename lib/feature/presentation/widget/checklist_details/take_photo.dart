import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import 'package:suja_shoie_app/constant/utils/theme_styles.dart';

class ImageCapture extends StatefulWidget {
  final List<File?> capturedImages;
  final void Function(List<File?>) onImagesCaptured; // Callback to update images in the parent widget

  const ImageCapture({super.key, 
    required this.capturedImages,
    required this.onImagesCaptured,
  });

  @override
  _ImageCaptureState createState() => _ImageCaptureState();
  
}
class _ImageCaptureState extends State<ImageCapture> {
  final ImagePicker _picker = ImagePicker();
  final List<File?> _capturedImages = [];
  final List<String> _imageNames = [];
  bool _cancelIconVisible = true;
  String _fileSize = '';



  void _onImageCaptured(File? capturedImage) {
  setState(() {
    widget.capturedImages.add(capturedImage);
  });
  widget.onImagesCaptured(widget.capturedImages); // Pass images back to parent
}


  void _showLargeImage(File? image) {
    if (image != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              alignment: Alignment.center,
              width: 500,
              height: 300,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Image.file(image),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 32.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> captureAndResizeImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final resizedFile = await _resizeImage(pickedFile.path, 600, 400);

      if (resizedFile != null) {
        final fileSize = await resizedFile.length();
        final imageName = pickedFile.path.split('/').last;

        setState(() {
          widget.capturedImages.add(File(resizedFile.path));
          _imageNames.add(imageName); // Store image name
          _cancelIconVisible = true;
          _fileSize = '${(fileSize / (1024)).toStringAsFixed(2)} KB';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Image resizing failed.'),
        ));
      }
    }
  }

  Future<File?> _resizeImage(String imagePath, int maxWidth, int maxHeight) async {
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

    final imageName = resizedFile.path.split('/').last;
    final fileSizeKB = await resizedFile.length() / 1024;
    print('Image Name: $imageName');
    print('File Size: ${fileSizeKB.toStringAsFixed(2)} KB');

    return resizedFile;
  }

void _deleteImage(int index) {
    setState(() {
      if (index >= 0 && index < widget.capturedImages.length) {
        widget.capturedImages.removeAt(index);
        widget.onImagesCaptured(widget.capturedImages); // Notify the parent widget about the image deletion
      }
    });
  }
 @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: captureAndResizeImage,
            icon: const Icon(Icons.image, size: 50, color: Colors.blue),
          ),
          const SizedBox(width: defaultPadding,),
           Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 16),
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.capturedImages.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => _showLargeImage(widget.capturedImages[index]),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          height: 75,
                          width: 100,
                          child: Image.file(widget.capturedImages[index]!),
                        ),
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
                                size: 17.0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}