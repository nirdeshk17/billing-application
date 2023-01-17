import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/payment/controller/payment_controller.dart';
import 'package:billing_app/screens/payment_successful/payment_sucessful_view.dart';
import 'package:billing_app/screens/settlement/settlement_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentScreenView extends StatefulWidget {
  final String ? totRate;
  const PaymentScreenView({Key? key,this.totRate}) : super(key: key);

  @override
  _PaymentScreenViewState createState() => _PaymentScreenViewState();
}

class _PaymentScreenViewState extends State<PaymentScreenView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<PaymentController>().initState(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final watch = context.watch<PaymentController>();
    final read = context.read<PaymentController>();
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Split"),
            ],
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body:watch.isLoading==true?
      Center(
        child: CircularProgressIndicator(),
      ):SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.totRate??"0",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "Total amount due",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Loyality Customer"),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.primaryColor),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Praveen"),
                    Text("Discount Rs 12.86"),
                  ],
                ),
              ],
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: watch.paymentData?.length ?? 0,
                      itemBuilder: (BuildContext, index) {
                        print(watch.paymentData);
                        final element=watch.paymentData?[index];
                        return Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child:
                              ElevatedButton(

                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SettlementScreenView(
                                                paymentType: element?.paytypeName,
                                                total: widget.totRate,
                                                indexPosition: index,
                                              )));
                                },
                                child: Text(
                                  element?.paytypeName??"",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        AppColor.paymentButtonColor),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PaymentSucessfullScreenView(total: widget.totRate,)));
                      },
                      child: Text(
                        "Pay Later",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColor.paymentButtonColor),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
