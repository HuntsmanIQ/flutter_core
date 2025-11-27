
import 'dart:typed_data'; // Required for Uint8List
import 'package:file_picker/file_picker.dart';

Future<Uint8List?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom, // You can specify file types if needed
    allowedExtensions: ['xlsx','xlx'], // Optional
    withData: true, // This is crucial for web, returns bytes
  );

  if (result != null) {
    // For web, the bytes are directly available
    PlatformFile file = result.files.single;
    return file.bytes;
  } else {
    // User canceled the picker
    return null;
  }
}

// using this in your controller with customize file extension, upload link , and fields
// Future<void> uploadFile() async {
//     statusRequest = StatusRequest.loading;
//     update();

//     try {
//       final Uint8List? fileBytes = await pickFile();
//       if (fileBytes == null) {
//         statusRequest = StatusRequest.none;
//         update();
//         return;
//       }

//       // create a safe filename (FilePicker didn't return a name in this signature)
//       final String filename =
//           'upload_${DateTime.now().millisecondsSinceEpoch}.xlsx';

//       final uri = Uri.parse("${AppLink.server}/import/upload");
//       final request = http.MultipartRequest('POST', uri);

//       // add headers and any other fields required by your API
//       request.headers.addAll({
//         'Authorization': '${myServices.sharedPreferences.getString("token")}',
//       });
//       // add parameters
      
//       request.fields['table_name'] = selectedTable;
      
      
//       request.files.add(
//         http.MultipartFile.fromBytes('file', fileBytes, filename: filename),
//       );

//       final streamedResponse = await request.send();
//       final response = await http.Response.fromStream(streamedResponse);

//       if (response.statusCode == 200) {
//         statusRequest = StatusRequest.success;
//         update();
//         Get.snackbar(
//           'نجاح',
//           'تم رفع الملف بنجاح',
//           backgroundColor: Colors.green,
//         );
//         print("Uploaded successfully: ${response.body}");
//       } else {
//         statusRequest = StatusRequest.failure;
//         update();
//         Get.snackbar('خطأ', 'فشل الرفع: ${response.statusCode}');
//         print("Upload failed: ${response.statusCode} ${response.body}");
//       }
//     } catch (e, st) {
//       statusRequest = StatusRequest.failure;
//       update();
//       Get.snackbar('خطأ', 'حدث خطأ أثناء الرفع');
//       print("Upload exception: $e\n$st");
//     }
//   }
