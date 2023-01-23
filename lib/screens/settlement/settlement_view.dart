import 'package:billing_app/constants/assets.dart';
import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/payment_successful/payment_sucessful_view.dart';
import 'package:billing_app/screens/settlement/controller/settlement_controller.dart';
import 'package:billing_app/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';

class SettlementScreenView extends StatefulWidget {
  final String? paymentType;
  final String? total;
  final int? indexPosition;
  final int? paymentId;
  const SettlementScreenView({Key? key, required this.paymentType,this.total,this.indexPosition,this.paymentId})
      : super(key: key);

  @override
  _SettlementScreenViewState createState() => _SettlementScreenViewState();
}

class _SettlementScreenViewState extends State<SettlementScreenView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context
          .read<SettlementController>()
          .initState(context, widget.paymentType ?? "",widget.indexPosition,widget.total);
      print(widget.paymentId);
      print(widget.total);
    });
  }
  onBack(){
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<SettlementController>();
    final read = context.read<SettlementController>();
    return Scaffold(
      body:Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(color: AppColor.primaryColor),
                height: 80,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 7, right: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "Amount due Rs ${widget.total}",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PaymentSucessfullScreenView(total: widget.total,paytype: widget.paymentId,)));
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child:
              SingleChildScrollView(
                child:   Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Remaining Rs 0.00",
                            style: TextStyle(fontSize: 18),
                          ),
                          // watch.isSplitBtnPressed==false?Container(
                          //   height: 50,
                          //   width: 130,
                          //   child: ElevatedButton(
                          //       onPressed: () {
                          //         read.onSplitBtnPressed();
                          //       },
                          //       child: Text(
                          //         "Split",
                          //         style: TextStyle(fontSize: 18),
                          //       ),
                          //       style: ButtonStyle(
                          //           backgroundColor:
                          //           MaterialStateProperty.all(
                          //               AppColor.primaryColor),
                          //           shape: MaterialStateProperty.all(
                          //               RoundedRectangleBorder(
                          //                   borderRadius:
                          //                   BorderRadius.circular(10))))),
                          // ):Container()

                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      watch.isSplitBtnPressed
                          ? Container(
                        child: Column(
                          children: [
                            ListView.builder(itemCount:watch.paymentData?.length,itemBuilder:(BuildContext,index){
                              if(index==widget.indexPosition){
                                watch.paymentController?[widget.indexPosition??0].text=widget.total.toString();
                              }
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        watch.paymentData?[index].paytypeName??"",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'whitneysemibold',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 250,
                                        child: PrimaryFormField(
                                          textAlign: TextAlign.end,
                                          textDirection: TextDirection.ltr,
                                          controller: watch.paymentController?[index],
                                          width: 250,
                                          hintText:  watch.paymentData?[index].paytypeName,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                ],
                              );
                            },
                              shrinkWrap: true,
                            ),

                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Row(
                            //   mainAxisAlignment:
                            //   MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "Google Pay",
                            //       style: TextStyle(
                            //           fontSize: 16,
                            //           fontFamily: 'whitneysemibold',
                            //           fontWeight: FontWeight.w600),
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     PrimaryFormField(
                            //       textAlign: TextAlign.end,
                            //       textDirection: TextDirection.ltr,
                            //       controller: watch.card1Controller,
                            //       width: 250,
                            //       hintText: "Card 1",
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Row(
                            //   mainAxisAlignment:
                            //   MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "Card 2",
                            //       style: TextStyle(
                            //           fontSize: 16,
                            //           fontFamily: 'whitneysemibold',
                            //           fontWeight: FontWeight.w600),
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     PrimaryFormField(
                            //       textAlign: TextAlign.end,
                            //       textDirection: TextDirection.ltr,
                            //       controller: watch.card2Controller,
                            //       width: 250,
                            //       hintText: "Card 2",
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                          ],
                        ),
                      )
                          :
                      Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.total??"",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(watch.paymentType??"",style: TextStyle(fontSize:20,color: Colors.grey),),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        height: 250,
                        width: 245,
                        child: CustomPaint(
                          painter: MyCustomPainter(frameSFactor: .1, padding:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 200,
                                child: Image.asset(
                                  AssetImages.assetsImageQrCode,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            ),
          ],
        ),
    );
  }
}
class MyCustomPainter extends CustomPainter {
  final double padding;
  final double frameSFactor;

  MyCustomPainter({
    required this.padding,
    required this.frameSFactor,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final frameHWidth = size.width * frameSFactor;

    Paint paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 5;

    /// background
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(0, 0, size.width, size.height),
          Radius.circular(18),
        ),
        paint);

    /// top left
    canvas.drawLine(
      Offset(0 + padding, padding),
      Offset(
        padding + frameHWidth,
        padding,
      ),
      paint..color = Colors.black,
    );

    canvas.drawLine(
      Offset(0 + padding, padding),
      Offset(
        padding,
        padding + frameHWidth,
      ),
      paint..color = Colors.black,
    );

    /// top Right
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(size.width - padding - frameHWidth, padding),
      paint..color = Colors.black,
    );
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(size.width - padding, padding + frameHWidth),
      paint..color = Colors.black,
    );

    /// Bottom Right
    canvas.drawLine(
      Offset(size.width - padding, size.height - padding),
      Offset(size.width - padding - frameHWidth, size.height - padding),
      paint..color = Colors.black,
    );
    canvas.drawLine(
      Offset(size.width - padding, size.height - padding),
      Offset(size.width - padding, size.height - padding - frameHWidth),
      paint..color = Colors.black,
    );

    /// Bottom Left
    canvas.drawLine(
      Offset(0 + padding, size.height - padding),
      Offset(0 + padding + frameHWidth, size.height - padding),
      paint..color = Colors.black,
    );
    canvas.drawLine(
      Offset(0 + padding, size.height - padding),
      Offset(0 + padding, size.height - padding - frameHWidth),
      paint..color = Colors.black,
    );
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true; //based on your use-cases
}