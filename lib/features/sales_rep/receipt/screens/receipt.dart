import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:shopping_app/screens/sales_rep_main-page.dart';
import 'package:sizer/sizer.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../common/utils.dart';

class ReceiptPage extends StatefulWidget {
  final String salesRep;
  const ReceiptPage({super.key, required this.salesRep});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  String setDate(var dataDate) {
    String timestampString = dataDate;
    DateTime timestamp = DateTime.parse(timestampString);

    String formattedDate = DateFormat('dd/MM/yy').format(timestamp.toLocal());
    return formattedDate;
  }

  double calculateTotalAmount() {
    double totalAmount = 0;

    // Loop through each order in the invoice
    for (var order in receipt[0]["order"]) {
      int productQuantity = order["productQuantity"];
      double productPrice = order["productPrice"];
      totalAmount += productQuantity * productPrice;
    }

    // Add delivery charges
    totalAmount += receipt[0]["deliveryCharge"];

    return totalAmount;
  }

  Future<Uint8List> generatePdf() async {
    // final i = pw.Image(pw.ImageImage());
    final netImage = await networkImage(receipt[0]['store'][0]['img_url']);
    final image = await rootBundle.load('assets/photo_2023-11-21_08-41-39.jpg');
    final imageBytes = image.buffer.asUint8List();
    final font = await PdfGoogleFonts.notoSansBold();
    final format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'NGN');
    pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a3,
      build: (context) {
        var row = pw.Row(
          children: [
            pw.SizedBox(
              width: 50.sp,
              child: pw.Text(
                'PRICE',
                style: pw.TextStyle(
                  fontSize: 8.sp,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColor.fromHex('#ffffff'),
                ),
              ),
            ),
            pw.SizedBox(
              width: 50.sp,
              child: pw.Center(
                child: pw.Text(
                  'QTY',
                  style: pw.TextStyle(
                    fontSize: 8.sp,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#ffffff'),
                  ),
                ),
              ),
            ),
            pw.SizedBox(
              width: 60.sp,
              child: pw.Center(
                child: pw.Text(
                  'ID',
                  style: pw.TextStyle(
                    fontSize: 8.sp,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#ffffff'),
                  ),
                ),
              ),
            ),
            pw.SizedBox(
                width: 60.sp,
                child: pw.Text(
                  'TOTAL',
                  style: pw.TextStyle(
                    fontSize: 8.sp,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColor.fromHex('#ffffff'),
                  ),
                ))
          ],
        );
        return pw.Column(children: [
          pw.Container(
            width: double.infinity,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  width: double.infinity,
                  height: 10.sp,
                  color: PdfColor.fromHex('#b6b6f7'),
                ),
                // pw.Image.network(''),
                pw.Container(
                  color: PdfColor.fromHex('#dfdada'),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.symmetric(
                      horizontal: 10.sp,
                    ).copyWith(top: 10.sp, bottom: 5.sp),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                          height: 50.sp,
                          width: 50.sp,
                          child: pw.Image(netImage),
                        ),
                        pw.SizedBox(width: 10.sp),
                        pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'INVOICE ${receipt[0]['invoice'][0]['id']}',
                              style: pw.TextStyle(
                                fontSize: 12.sp,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              '${receipt[0]['store'][0]['name']}',
                              style: pw.TextStyle(
                                fontSize: 10.sp,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Text(
                              // '${receipt[0]['store'][0]['mainPhoneNo']}',
                              rep,
                              style: pw.TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                        pw.Spacer(),
                        pw.SizedBox(
                          width: 100.sp,
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                  '${receipt[0]['store'][0]['mainAddress']}',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10.sp,
                                  )),
                              pw.Text(
                                '${receipt[0]['store'][0]['secAddress']}',
                                maxLines: 5,
                                style: pw.TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              pw.Text(
                                  'P ${receipt[0]['store'][0]['mainPhoneNo']}',
                                  style: pw.TextStyle(
                                    fontSize: 10.sp,
                                  )),
                              pw.Text('${receipt[0]['store'][0]['secPhoneNo']}',
                                  style: pw.TextStyle(
                                    fontSize: 10.sp,
                                  )),
                              pw.Text('${receipt[0]['store'][0]['email']}',
                                  style: pw.TextStyle(
                                    fontSize: 10.sp,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(
                  height: 20.sp,
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(
                    horizontal: 10.sp,
                  ),
                  child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'BILL TO',
                              style: pw.TextStyle(
                                fontSize: 8.sp,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Divider(),
                            pw.Text(
                              '${receipt[0]['customer'][0]['name']}',
                              style: pw.TextStyle(
                                fontSize: 8.sp,
                              ),
                            ),
                            pw.Text(
                              'P ${receipt[0]['customer'][0]['phoneNo']}',
                              style: pw.TextStyle(
                                fontSize: 8.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      pw.SizedBox(width: 30.sp),
                      pw.Expanded(
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              'INVOICE DETAILS',
                              style: pw.TextStyle(
                                fontSize: 8.sp,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                            pw.Divider(),
                            pw.Row(
                              children: [
                                pw.Text(
                                  'INVOICE DATE',
                                  style: pw.TextStyle(
                                    fontSize: 8.sp,
                                  ),
                                ),
                                pw.SizedBox(width: 24.sp),
                                pw.Text(
                                  setDate(
                                      receipt[0]['invoice'][0]['invoiceDate']),
                                  style: pw.TextStyle(),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Text(
                                  'INVOICE DUE',
                                  style: pw.TextStyle(
                                    fontSize: 8.sp,
                                  ),
                                ),
                                // pw.Spacer(),
                                pw.SizedBox(width: 30.sp),
                                pw.Text(
                                  receipt[0]['invoice'][0]['invoiceDue'],
                                  style: pw.TextStyle(
                                    fontSize: 8.sp,
                                  ),
                                ),
                              ],
                            ),
                            pw.Row(
                              children: [
                                pw.Text(
                                  'BALANCE DUE',
                                  style: pw.TextStyle(
                                    fontSize: 8.sp,
                                  ),
                                ),
                                // pw.Spacer(),
                                pw.SizedBox(width: 27.sp),

                                pw.RichText(
                                  text: pw.TextSpan(
                                    children: [
                                      pw.TextSpan(
                                        text: '₦',
                                        style: pw.TextStyle(
                                            font: font, fontSize: 10.sp),
                                      ),
                                      pw.TextSpan(
                                          text:
                                              '${formatNumberWithCommas((receipt[0]['invoice'][0]['balanceDue']).toString())}',
                                          style: pw.TextStyle(fontSize: 10.sp))
                                    ],
                                  ),
                                ),
                                // pw.Text(r'₦10,000',
                                //     style: pw.TextStyle(
                                //         font: font, fontSize: 30.sp)),
                                // pw.Text(
                                //   format.format(
                                //       receipt[0]['invoice'][0]['balanceDue']),
                                //   style: pw.TextStyle(
                                //     fontSize: 10.sp,
                                //   ),
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                pw.SizedBox(height: 10.sp),
                pw.Padding(
                    padding: pw.EdgeInsets.symmetric(
                      horizontal: 10.sp,
                    ),
                    child: pw.Container(
                      width: double.infinity,
                      child: pw.Column(
                        children: [
                          pw.Container(
                            width: double.infinity,
                            color: PdfColor.fromHex('#b6b6f7'),
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'DESCRIPTION',
                                    style: pw.TextStyle(
                                      fontSize: 8.sp,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColor.fromHex('#ffffff'),
                                    ),
                                  ),
                                ),
                                row
                              ],
                            ),
                          ),
                          pw.Container(
                            width: double.infinity,
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Delivery Charges',
                                    style: pw.TextStyle(
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColor.fromHex('#000000'),
                                    ),
                                  ),
                                ),
                                pw.Row(
                                  children: [
                                    pw.SizedBox(
                                      width: 50.sp,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColor.fromHex('#000000'),
                                        ),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      width: 50.sp,
                                      child: pw.Text(
                                        '',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          color: PdfColor.fromHex('#000000'),
                                        ),
                                      ),
                                    ),
                                    pw.SizedBox(
                                      width: 60.sp,
                                      child: pw.RichText(
                                        text: pw.TextSpan(
                                          children: [
                                            pw.TextSpan(
                                              text: '₦',
                                              style: pw.TextStyle(
                                                  font: font, fontSize: 10.sp),
                                            ),
                                            pw.TextSpan(
                                                text:
                                                    "${receipt[0]['deliveryCharge']}",
                                                style: pw.TextStyle(
                                                    fontSize: 10.sp))
                                          ],
                                        ),
                                      ),
                                      //  pw.Text(
                                      //   "₦${receipt[0]['deliveryCharge']}",
                                      //   style: pw.TextStyle(
                                      //     fontWeight: pw.FontWeight.bold,
                                      //     color: PdfColor.fromHex('#000000'),
                                      //   ),
                                      // ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          // pw.Divider(),
                          pw.SizedBox(height: 10.sp),
                          pw.ListView.separated(
                              separatorBuilder: (context, index) =>
                                  pw.Divider(),
                              itemBuilder: (context, index) {
                                // var data = receipt[0]['order'];
                                // List newdata = data;
                                List<pw.Text> widgets = List.generate(
                                    receipt[0]['order'][index]['productId']
                                        .length, (entryIndex) {
                                  var productID = receipt[0]['order'][index]
                                      ['productId'][entryIndex];
                                  print(productID);
                                  print('object');
                                  // Access and use productId and other relevant data for each entry
                                  return pw.Text(
                                      productID); // Replace with your desired widget
                                });
                                print(receipt);

                                return pw.Column(
                                  children: [
                                    pw.Container(
                                      width: double.infinity,
                                      child: pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Expanded(
                                            child: pw.Text(
                                              receipt[0]['order'][index]
                                                  ['productName'],
                                              style: pw.TextStyle(
                                                fontWeight: pw.FontWeight.bold,
                                                color:
                                                    PdfColor.fromHex('#000000'),
                                              ),
                                            ),
                                          ),
                                          pw.Row(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.SizedBox(
                                                width: 50.sp,
                                                child: pw.RichText(
                                                  text: pw.TextSpan(
                                                    children: [
                                                      pw.TextSpan(
                                                        text: '₦',
                                                        style: pw.TextStyle(
                                                            font: font,
                                                            fontSize: 10.sp),
                                                      ),
                                                      pw.TextSpan(
                                                          text:
                                                              // "${receipt[0]['order'][index]['total'].toString()}",
                                                              formatNumberWithCommas(
                                                                  receipt[0]['order']
                                                                              [
                                                                              index]
                                                                          [
                                                                          'productPrice']
                                                                      .toString()),
                                                          style: pw.TextStyle(
                                                              fontSize: 10.sp))
                                                    ],
                                                  ),
                                                ),

                                                // pw.Text(

                                                //   style: pw.TextStyle(
                                                //     fontWeight: pw.FontWeight.bold,
                                                //     color:
                                                //         PdfColor.fromHex('#000000'),
                                                //   ),
                                                // ),
                                              ),
                                              pw.SizedBox(
                                                width: 50.sp,
                                                child: pw.Center(
                                                  child: pw.Text(
                                                    receipt[0]['order'][index]
                                                            ['productQuantity']
                                                        .toString(),
                                                    style: pw.TextStyle(
                                                      fontWeight:
                                                          pw.FontWeight.bold,
                                                      color: PdfColor.fromHex(
                                                          '#000000'),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              pw.SizedBox(
                                                width: 60.sp,
                                                child: pw.Center(
                                                  child: pw.Column(
                                                      crossAxisAlignment: pw
                                                          .CrossAxisAlignment
                                                          .start,
                                                      children: widgets),
                                                ),
                                              ),
                                              // pw.Column(children: widgets),

                                              pw.SizedBox(
                                                width: 60.sp,
                                                child: pw.RichText(
                                                  text: pw.TextSpan(
                                                    children: [
                                                      pw.TextSpan(
                                                        text: '₦',
                                                        style: pw.TextStyle(
                                                            font: font,
                                                            fontSize: 10.sp),
                                                      ),
                                                      pw.TextSpan(
                                                          text:
                                                              // "${receipt[0]['order'][index]['total'].toString()}",
                                                              formatNumberWithCommas(
                                                                  "${receipt[0]['order'][index]['total'].toString()}"),
                                                          style: pw.TextStyle(
                                                              fontSize: 10.sp))
                                                    ],
                                                  ),
                                                ),
                                                // pw.Text(
                                                //   style: pw.TextStyle(
                                                //     fontWeight: pw.FontWeight.bold,
                                                //     color:
                                                //         PdfColor.fromHex('#000000'),
                                                //   ),
                                                // ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    // pw.SizedBox(height: 5.sp),
                                  ],
                                );
                              },
                              itemCount: receipt[0]['order'].length),
                          pw.Container(
                            width: double.infinity,
                            child: pw.Divider(),
                          ),
                          pw.SizedBox(height: 10.sp),
                          pw.Flex(
                            direction: pw.Axis.horizontal,
                            children: [
                              pw.Row(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                    width: 60.w,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColor.fromHex('#dfdada'),
                                      ),
                                    ),
                                    child: pw.Padding(
                                      padding: pw.EdgeInsets.all(
                                        10.sp,
                                      ),
                                      child: pw.Column(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            'PAYMENT INSTRUCTIONS',
                                            style: pw.TextStyle(
                                              fontSize: 8.sp,
                                              fontWeight: pw.FontWeight.bold,
                                            ),
                                          ),
                                          pw.SizedBox(height: 10.sp),
                                          pw.Text(
                                              'Bank Transfer: ${receipt[0]['bankTranf']}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(width: 20.sp),
                                  pw.Container(
                                    width: 40.w,
                                    child: pw.Column(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text(
                                              'SUBTOTAL',
                                              style: pw.TextStyle(
                                                fontSize: 8.sp,
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                            pw.RichText(
                                              text: pw.TextSpan(
                                                children: [
                                                  pw.TextSpan(
                                                    text: '₦',
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 10.sp),
                                                  ),
                                                  pw.TextSpan(
                                                      text:
                                                          '${formatNumberWithCommas((receipt[0]['invoice'][0]['balanceDue'] - receipt[0]['deliveryCharge']).toString())}',
                                                      style: pw.TextStyle(
                                                          fontSize: 10.sp))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Divider(),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text(
                                              'TOTAL',
                                              style: pw.TextStyle(
                                                fontSize: 8.sp,
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                            pw.RichText(
                                              text: pw.TextSpan(
                                                children: [
                                                  pw.TextSpan(
                                                    text: '₦',
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 10.sp),
                                                  ),
                                                  pw.TextSpan(
                                                      text:
                                                          '${formatNumberWithCommas(receipt[0]['invoice'][0]['balanceDue'].toString())}',
                                                      style: pw.TextStyle(
                                                          fontSize: 10.sp))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        pw.Divider(),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text(
                                              'PAID',
                                              style: pw.TextStyle(
                                                fontSize: 8.sp,
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                            pw.RichText(
                                              text: pw.TextSpan(
                                                children: [
                                                  pw.TextSpan(
                                                    text: '₦',
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 10.sp),
                                                  ),
                                                  pw.TextSpan(
                                                      text:
                                                          '${formatNumberWithCommas(receipt[0]['paymentRefAmt'].toString())}',
                                                      style: pw.TextStyle(
                                                          fontSize: 10.sp))
                                                ],
                                              ),
                                            ),
                                            // pw.Text(
                                            //     '₦ ${formatNumberWithCommas(receipt[0]['paymentRefAmt'].toString())}',
                                            //     style: pw.TextStyle(
                                            //       fontSize: 8.sp,
                                            //     )),
                                          ],
                                        ),
                                        pw.Divider(),
                                        pw.Row(
                                          mainAxisAlignment:
                                              pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Text(
                                              'BALANCE',
                                              style: pw.TextStyle(
                                                fontSize: 8.sp,
                                                fontWeight: pw.FontWeight.bold,
                                              ),
                                            ),
                                            pw.RichText(
                                              text: pw.TextSpan(
                                                children: [
                                                  pw.TextSpan(
                                                    text: '₦',
                                                    style: pw.TextStyle(
                                                        font: font,
                                                        fontSize: 10.sp),
                                                  ),
                                                  pw.TextSpan(
                                                      text:
                                                          '${formatNumberWithCommas((receipt[0]['invoice'][0]['balanceDue'] - receipt[0]['paymentRefAmt']).toString())}',
                                                      style: pw.TextStyle(
                                                          fontSize: 10.sp))
                                                ],
                                              ),
                                            ),
                                            // pw.Text(
                                            //     '₦ ${formatNumberWithCommas((receipt[0]['invoice'][0]['balanceDue'] - receipt[0]['paymentRefAmt']).toString())}',
                                            //     style: pw.TextStyle(
                                            //       fontSize: 8.sp,
                                            //     )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                pw.SizedBox(height: 10.sp),
                pw.Container(
                  width: 1000.sp,
                  padding: pw.EdgeInsets.only(right: 20.sp),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Text('1.'),
                          pw.SizedBox(
                            width: 10.sp,
                          ),
                          pw.SizedBox(
                            width: 500.sp,
                            child: pw.Text(
                              'All our products carries 6months warranty from the day of purchase.',
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                      pw.SizedBox(height: 10.sp),
                      pw.SizedBox(
                        width: double.infinity,
                        child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text('2.'),
                            pw.SizedBox(
                              width: 10.sp,
                            ),
                            pw.SizedBox(
                              width: 500.sp,
                              child: pw.Text(
                                'Returned goods will take two weeks for inspection and troubleshooting before conclusion can be made over it.',
                                maxLines: 3,
                              ),
                            )
                          ],
                        ),
                      ),
                      pw.SizedBox(height: 10.sp),
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('3.'),
                          pw.SizedBox(
                            width: 10.sp,
                          ),
                          pw.SizedBox(
                            width: 500.sp,
                            child: pw.Text(
                              'Swapping of goods for another is allowed only within 3week of purchase, inclusive with additional #2000 cost.',
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                      pw.SizedBox(height: 10.sp),
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text('4.'),
                          pw.SizedBox(
                            width: 10.sp,
                          ),
                          pw.SizedBox(
                            width: 500.sp,
                            child: pw.Text(
                              "We don't Refund Money in any occasion, we can swap/change one goods for another, based on condition of item you are willing to swap",
                              maxLines: 3,
                            ),
                          )
                        ],
                      ),
                      pw.SizedBox(height: 10.sp),
                    ],
                  ),
                ),
                pw.SizedBox(height: 30.sp),
                pw.Container(
                  height: 10.sp,
                  width: double.infinity,
                  color: PdfColor.fromHex('#b6b6f7'),
                )
              ],
            ),
          ),
        ]);
      },
    ));
    final output = await getTemporaryDirectory();
    debugPrint("${output.path}/example.pdf");
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(await pdf.save());
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    print(calculateTotalAmount.toString());

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SalesRepMainPage(),
              ),
              (route) => false);
          return false;
        },
        child: PdfPreview(
          build: (format) => generatePdf(),
        ),
      ),
    );
  }
}
