import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

Future<String> createExcelFromRows(
  List<List<dynamic>> rows, {
  String fileName = 'products.xlsx',
  String sheetName = 'Sheet1',
  bool openAfterSave = false,
}) async {
  final excel = Excel.createExcel();
  final Sheet sheet = excel[sheetName];

  for (int r = 0; r < rows.length; r++) {
    for (int c = 0; c < rows[r].length; c++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: c, rowIndex: r))
          .value = _safeValue(rows[r][c]);
    }
  }

  final bytes = excel.encode();
  if (bytes == null) {
    throw Exception('Failed to generate Excel');
  }

  // 📂 مجلد خارجي خاص بالتطبيق
  final dir = await getExternalStorageDirectory();
  if (dir == null) {
    throw Exception('External storage not available');
  }

  final file = File('${dir.path}/$fileName');
  await file.writeAsBytes(bytes, flush: true);

  if (openAfterSave) {
    await OpenFile.open(file.path);
  }

  return file.path;
}

dynamic _safeValue(dynamic v) {
  if (v == null) return '';
  if (v is String || v is num || v is bool) return v;
  if (v is DateTime) {
    return '${v.year}-${v.month}-${v.day} ${v.hour}:${v.minute}';
  }
  return v.toString();
}

//for excel export function inside controller
  // List<List<dynamic>> getRows() {
  //   List<List<dynamic>> rows = [
  //     ['المكان', 'التاريخ', 'التكلفة'], // header
  //   ];

  //   for (var item in db) {
  //     rows.add([
  //       item.place,
  //       item.date,
  //       item.cost,
  //     ]);
  //   }
  //   return rows;
  // }

  // excelExport() async {
  //   DateTime? fileDate = DateTime.now();
  //   String formattedDate = '${fileDate.year}${fileDate.month}${fileDate.day}';
    
  //   final path = await createExcelFromRows(
  //     getRows(),
  //     fileName: 'Duty$formattedDate.xlsx',
  //     openAfterSave: true,
  //   );
  //   print(path);
  // }
