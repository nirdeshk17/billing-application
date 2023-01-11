import 'package:billing_app/constants/assets.dart';
import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/item_cart/controller/item_cart_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemCartScreenView extends StatefulWidget {
  final String? itemName;
  final String? itemRate;
  final String? qty;
  const ItemCartScreenView({Key? key,required this.itemName,this.itemRate,this.qty}) : super(key: key);

  @override
  _ItemCartScreenViewState createState() => _ItemCartScreenViewState();
}

class _ItemCartScreenViewState extends State<ItemCartScreenView> {
  TextStyle keypadStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 40);
  BoxDecoration rightPadDecoration = BoxDecoration(
    border: Border(top: BorderSide(color: AppColor.primaryColor)),
  );
  BoxDecoration centerPadDecoration = BoxDecoration(
    border: Border(
        top: BorderSide(color: AppColor.primaryColor),
        left: BorderSide(color: AppColor.primaryColor),
        right: BorderSide(color: AppColor.primaryColor)),
  );
  BoxDecoration leftPadDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: AppColor.primaryColor),
    ),
  );

  BoxDecoration bottomRightPadDecoration = BoxDecoration(
    border: Border(
        bottom: BorderSide(color: AppColor.primaryColor),
        top: BorderSide(color: AppColor.primaryColor)),
  );
  BoxDecoration bottomCenterPadDecoration = BoxDecoration(
    border: Border(
        bottom: BorderSide(color: AppColor.primaryColor),
        left: BorderSide(color: AppColor.primaryColor),
        right: BorderSide(color: AppColor.primaryColor),
        top: BorderSide(color: AppColor.primaryColor)),
  );
  BoxDecoration bottomLeftPadDecoration = BoxDecoration(
    border: Border(
        bottom: BorderSide(color: AppColor.primaryColor),
        top: BorderSide(color: AppColor.primaryColor)),
  );
  String qty = "5.00";
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<ItemCartController>().initState(context,widget.itemName,widget.itemRate,widget.qty);
    });
  }
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<ItemCartController>();
    final read = context.read<ItemCartController>();
    return Scaffold(
      body:watch.isLoading?Center(
        child: CircularProgressIndicator(
          color: AppColor.primaryColor,
        ),
      ): Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 50),
            child: Column(
              children: [
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
                            Icons.close,
                            size: 25,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 230,
                          child:     Text(widget.itemName??"",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Stock 20 nos",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Rate ",style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),),
                            Text(watch.rate,
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nos",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      watch.qty!="null"? watch.qty:"0.0",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    read.onClearBtnPressed();
                  },
                  child: Image.asset(
                    AssetsIcon.assetsIconclear,
                    height: 25,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap("1");
                      },
                      child: Container(
                        decoration: leftPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "1",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap("2");
                      },
                      child: Container(
                        decoration: centerPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "2",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap("3");
                      },
                      child: Container(
                        decoration: rightPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "3",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap("4");
                      },
                      child: Container(
                        decoration: leftPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "4",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap("5");
                      },
                      child: Container(
                        decoration: centerPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "5",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap("6");
                      },
                      child: Container(
                        decoration: rightPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "6",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap("7");
                      },
                      child: Container(
                        decoration: leftPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "7",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap("8");
                      },
                      child: Container(
                        decoration: centerPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "8",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap("9");
                      },
                      child: Container(
                        decoration: rightPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "9",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap(".");
                      },
                      child: Container(
                        decoration: bottomLeftPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            ".",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onKeyPadTap("0");
                      },
                      child: Container(
                        decoration: bottomCenterPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "0",
                            style: keypadStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        read.onOkBtnPressed(watch.rate, widget.itemName,watch.qty,context);
                      },
                      child: Container(
                        decoration: bottomRightPadDecoration,
                        height: MediaQuery.of(context).size.height / 5.5,
                        child: Center(
                          child: Text(
                            "OK",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: AppColor.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(watch.message??"",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.red),)
            ],
          ),
        ],
      ),
    );
  }
}
