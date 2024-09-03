import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

mixin NewtworkImageToFileMixin {
  //CONVERT IMAGE TO FILES
  Future<List<File>> convertImagesToFiles(
      {required List<String> images}) async {
    List<File> convertedFiles = [];

    for (int i = 0; i < images.length; i++) {
      final downloadedFile = await http.get(Uri.parse(images[i]));

      final documentDirectory = await getApplicationDocumentsDirectory();

      final String imageName = images[i].split('/').last;

      final File file = File('${documentDirectory.path}/$imageName');

      file.writeAsBytesSync(downloadedFile.bodyBytes);

      convertedFiles.add(file);
    }

    return convertedFiles;
  }

  //CONVET IMAGE TO FILE
  Future<File> convertImageToFile({required String image}) async {
    final downloadedFile = await http.get(Uri.parse(image));

    final documentDirectory = await getApplicationDocumentsDirectory();

    final String imageName = image.split('/').last;

    final File file = File('${documentDirectory.path}/$imageName');

    file.writeAsBytesSync(downloadedFile.bodyBytes);

    return file;
  }

  //CONVERT FILE TO BASE64
  Future<String> convertImageToBase64(File image) async {
    return base64Encode(await image.readAsBytes());
  }
}
