import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mohammed_admin/core/function/priceformat.dart';
import 'package:mohammed_admin/data/models/ordersdetails_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';

Future<void> generateInvoicePDF({
  required String invoiceNumber,
  required String customerName,
  required List <OrdersDetailsModel> items,
  required String total,
  required String delivery,
  required String phone,
  required String address,
}) async {
  final pdf = pw.Document();
  final fontData = await rootBundle.load("assets/fonts/Cairo-Regular.ttf");
  final arabicFont = pw.Font.ttf(fontData);
    final logoData = await rootBundle.load("assets/images/report.png");
  final logoImage = pw.MemoryImage(logoData.buffer.asUint8List());
  pdf.addPage(
    pw.Page(
      theme: pw.ThemeData.withFont(
        base: arabicFont,
      ),
      
      build: (context) {
        return pw.Directionality(
           textDirection: pw.TextDirection.rtl,
        child : pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
           pw.Center(child:  pw.Image(
                  logoImage,
                  width: 120,    // تقدر تغير الحجم
                  height: 120,
                ),),
          
            pw.Text("رقم الفاتورة #$invoiceNumber",
                style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 10),
           
             pw.Text("إسم الزبون: $customerName",
                style: pw.TextStyle(fontSize: 20)),
                 pw.Text("رقم الهاتف: 0$phone",
                style: pw.TextStyle(fontSize: 20)),
           
            pw.Text("العنوان: $address",
                style: pw.TextStyle(fontSize: 16)),
            pw.SizedBox(height: 20),

            pw.Table.fromTextArray(
             cellAlignment: pw.Alignment.center,
              headers: ["المنتجات", "العدد", "السعر"],
              data: items.map((e) {
                return [
                  e.itemsName,
                  e.countitems,
                  priceFormat(e.itemsPrice.toString())
                 
                ];
              }).toList(),
            ),

            pw.SizedBox(height: 20),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Column(children:[
                pw.Text(
                "كلفة التوصيل: ${priceFormat(delivery)} د.ع",
                style: pw.TextStyle(fontSize: 20),
              ),
               pw.SizedBox(height: 10),
               pw.Text(
                "المجموع الكلي: ${priceFormat(total)} د.ع",
                style: pw.TextStyle(fontSize: 20),
              ),
              ])
            ),
          ],
        ));
      },
    ),
  );

  final dir = await getTemporaryDirectory();
  final file = File("${dir.path}/invoice_$invoiceNumber.pdf");

  await file.writeAsBytes(await pdf.save());

  // فتح PDF مباشرة
  await OpenFilex.open(file.path);
}
