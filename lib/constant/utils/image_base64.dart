import 'dart:convert';
import 'dart:io';
import 'package:image/image.dart' as img;

class ImageBase64{
    Future<List<String>> convertFilePathsToBase64(List<String> filePaths) async {
    List<String> base64Images = [];

    for (var filePath in filePaths) {
      if (filePath.isNotEmpty) {
        final file = File(filePath);
        if (await file.exists()) {
          final image = img.decodeImage(await file.readAsBytes());

          if (image != null) {
            // Resize the image to a smaller dimension
            final resizedImage = img.copyResize(image, width: 600, height: 400);
            final resizedImageBytes = img.encodeJpg(resizedImage, quality: 20);

            String base64String = base64Encode(resizedImageBytes);

            base64Images.add(base64String);
          } else {
            // Handle the case where image decoding fails
            base64Images.add(''); // Add an empty string or another placeholder
          }
        } else {
          // Handle the case where the file doesn't exist (if needed)
          base64Images.add(''); // Add an empty string or another placeholder
        }
      } else {
        // Handle the case where the file path is empty (if needed)
        base64Images.add(''); // Add an empty string or another placeholder
      }
    }

    return base64Images;
  }

}