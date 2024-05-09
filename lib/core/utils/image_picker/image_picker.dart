import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  final XFile? image = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 50);
  if (image == null) {
    return null;
  }
  return File(image.path);
}
