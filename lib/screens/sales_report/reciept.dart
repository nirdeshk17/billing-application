import 'dart:convert';
import 'dart:typed_data';
import 'package:billing_app/network/base_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
class Reciept extends StatefulWidget {
  final String ?tranNo;
  const Reciept({Key? key,required this.tranNo}) : super(key: key);

  @override
  _RecieptState createState() => _RecieptState();
}

class _RecieptState extends State<Reciept> {
  List itmList=[];
  getSalesDetails()async{
    print(widget.tranNo);
    SharedPreferences pref = await SharedPreferences.getInstance();
    var res = await http.get(Uri.parse("${BaseUrl.getSalesDetails}&token=${pref.getString("LICENCE")}&tran_no=${widget.tranNo}"));
    print(res.body);
    var a = jsonDecode(res.body);
    print(a);
    if(a["status"]=="1"){
      setState(() {
        itmList=jsonDecode(a["data"]);
      });
    }
  }
  @override
  void initState() {
    getSalesDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PdfPreview(
          build: (format) => _generatePdf(format),
        ));

  }
  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Container(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text("SYUT technologies ".toUpperCase(),
                          style: pw.TextStyle(
                              fontSize: 22,
                              fontWeight: pw.FontWeight.bold,
                              letterSpacing: 0.5
                          )),
                    ]),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Text("Behind Holy Family Convent,".toUpperCase(),
                              style: pw.TextStyle(fontSize: 18,))),
                    ]
                ),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text("Chembukkav, THRISSUR".toUpperCase(), style: pw.TextStyle(fontSize: 18,)),
                    ]),
                pw.SizedBox(
                  height: 5,
                ),
                pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text("Contact: ".toUpperCase(),
                            style: pw.TextStyle(fontSize: 18, lineSpacing: 0.5)),
                        pw.Text("0487 2979422".toUpperCase(),
                            style: pw.TextStyle(
                              fontSize: 18,))
                      ]),
                ),
                pw.SizedBox(height: 7),
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(),
                    ),
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(0),
                  child: pw.Table(
                    columnWidths: const <int, pw.TableColumnWidth>{
                      0: pw.FixedColumnWidth(25),
                      1: pw.FixedColumnWidth(30),
                      2:pw.FixedColumnWidth(10),
                      3:pw.FixedColumnWidth(20),
                      4:pw.FixedColumnWidth(20),
                    },
                    children: [
                      pw.TableRow(

                        children: [
                          pw.Container(
                            padding: pw.EdgeInsets.only(right: 7,top: 3,bottom: 3),
                            child:
                            pw.Text("Sl", style: pw.TextStyle(fontSize: 16, lineSpacing: 0.5)),
                          ),
                          pw.Container(
                            padding: pw.EdgeInsets.only(top: 3,bottom: 3),
                            child: pw.Text("Name".toUpperCase(),
                                style: pw.TextStyle(fontSize: 16, lineSpacing: 0.5)),
                          ),
                          pw.Container(
                            padding: pw.EdgeInsets.only(top: 3,bottom: 3),
                            child:pw.Row(
                                children: [
                                  pw.Text("Qty".toUpperCase(),
                                      style: pw.TextStyle(fontSize: 16, lineSpacing: 0.5)),
                                ],
                                mainAxisAlignment: pw.MainAxisAlignment.end
                            ),

                          ),
                          pw.Container(
                            padding: pw.EdgeInsets.only(top: 3,bottom: 3),
                            child:pw.Row(
                                children: [
                                  pw.Text("Value".toUpperCase(),
                                      style: pw.TextStyle(fontSize: 16, lineSpacing: 0.5)),
                                ],
                                mainAxisAlignment: pw.MainAxisAlignment.end
                            ),

                          ),
                          pw.Container(
                            padding: pw.EdgeInsets.only(top: 3,bottom: 3),
                            child:pw.Row(
                                children: [
                                  pw.Text("Amount".toUpperCase(),
                                      style: pw.TextStyle(fontSize: 16, lineSpacing: 0.5)),
                                ],
                                mainAxisAlignment: pw.MainAxisAlignment.end
                            ),

                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(),
                    ),
                  ),
                ),
                pw.ListView.builder(
                  itemCount: itmList != null ? itmList.length : 0,
                  itemBuilder: (context, index) {
                    return pw.Column(
                        children: [
                          pw.Table(
                            columnWidths: const <int, pw.TableColumnWidth>{
                              0: pw.FixedColumnWidth(10),
                              1: pw.FixedColumnWidth(115),
                              2:pw.FixedColumnWidth(20),
                              3:pw.FixedColumnWidth(30),
                              4:pw.FixedColumnWidth(40),
                            },
                            children: [
                              pw.TableRow(
                                children: [
                                  pw.Container(
                                    child: pw.Text("${(index + 1).toString()}",
                                        style: pw.TextStyle(fontSize: 18)),
                                    padding: pw.EdgeInsets.only(top:2,right: 8,),
                                  ),
                                  pw.Container(
                                    child:pw.Column(
                                        children: [
                                          pw.Row(
                                              children: [
                                                pw.Text(itmList[index]["itm_name"],
                                                    style: pw.TextStyle(fontSize: 16, lineSpacing: 1)),
                                              ]
                                          ),
                                        ]
                                    ),

                                    padding: pw.EdgeInsets.only(top: 2,right: 5,bottom: 1),
                                  ),
                                  pw.Container(
                                    child:pw.Column(
                                        children: [
                                          pw.Row(
                                              children: [
                                                pw.Text(itmList[index]["itm_qty"],
                                                    style: pw.TextStyle(fontSize: 16, lineSpacing: 1)),
                                              ]
                                          ),
                                        ]
                                    ),

                                    padding: pw.EdgeInsets.only(top: 2,right: 5,bottom: 1),
                                  ),
                                  pw.Container(
                                    child:pw.Row(
                                        children: [
                                          pw.Text(
                                              itmList[index]["itm_val"],
                                              style: pw.TextStyle(fontSize: 16, lineSpacing: 1)),
                                        ],
                                        mainAxisAlignment: pw.MainAxisAlignment.end
                                    ),

                                    padding: pw.EdgeInsets.only(top: 2),
                                  ),
                                  pw.Container(
                                    child:pw.Row(
                                        children: [
                                          pw.Text(
                                              itmList[index]["tax_amt"],
                                              style: pw.TextStyle(fontSize: 16, lineSpacing: 1)),
                                        ],
                                        mainAxisAlignment: pw.MainAxisAlignment.end
                                    ),

                                    padding: pw.EdgeInsets.only(top: 2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]
                    );

                  },
                ),
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(),
                    ),
                  ),
                ),
                pw.SizedBox(height: 5),


                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(),
                    ),
                  ),
                ),

                pw.SizedBox(
                    height: 5
                ),

                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    children: [
                      pw.SizedBox(height: 10),
                      pw.Text(
                        "Thank You",
                        style: pw.TextStyle(fontSize: 18, lineSpacing: 1),
                      ),
                      pw.Text(
                        "Visit again",
                        style: pw.TextStyle(fontSize: 18, lineSpacing: 1),
                      ),
                    ]),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
