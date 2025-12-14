import 'dart:io';
import 'package:file_picker/file_picker.dart';

fileUpload() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'jpeg'],
  );
  if (result != null) {
    // File selected
    return File(result.files.single.path!);
  } else {
    return null;
  }
}
