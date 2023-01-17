import 'package:billing_app/constants/assets.dart';
import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/payment/payment_view.dart';
import 'package:billing_app/widgets/searchbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutViewScreen extends StatefulWidget {
  final List? checkoutList;
  final String? itemQty;
  final String? total;
  const CheckoutViewScreen({Key? key,this.checkoutList,this.itemQty,this.total}) : super(key: key);

  @override
  _CheckoutViewScreenState createState() => _CheckoutViewScreenState();
}

class _CheckoutViewScreenState extends State<CheckoutViewScreen> {
  _showPopupMenu(Offset offset) async {
    double left = offset.dx;
    double top = offset.dy;
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left, top, 0, 0),
      items: [
        PopupMenuItem<String>(
            child: const Text('Clear'), value: 'Clear'),
      ],
      elevation: 8.0,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: Row(
          children: [
            SizedBox(
              width: 15,
            ),
           InkWell(
             onTap: (){
               Navigator.pop(context);
             },
             child: Icon(Icons.arrow_back),
           ),
            SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: (){

              },
              child: Row(
                children: [
                  Text("Items"),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.withOpacity(0.7),
                    ),
                    height: 20,
                    width: 20,
                    child:
                    Center(
                      child: Text(widget.itemQty??"0"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Image.asset(AssetsIcon.assetsIconUserAdd,color: Colors.white,height: 25,width: 25,),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showPopupMenu(details.globalPosition);
            },
            child: Image.asset(AssetsIcon.assetsIconDots,width: 20,height: 20,color: Colors.white,),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(

              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Image.asset(AssetsIcon.assetsIconBarcode,height: 20,),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(child:  SearchBar(),),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(itemCount:widget.checkoutList?.length,shrinkWrap: true,itemBuilder:(BuildContext,index){
                  return
                    Container(
                        padding:EdgeInsets.symmetric(vertical:10,horizontal:15,),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text(widget.checkoutList?[index]["itm_name"]),
                    Text(widget.checkoutList?[index]["itm_rate"].toString()??"0"),
                    ],
                    ),
                  );
                  }),
                  Divider(
                    thickness: 1,
                  ),
                  Padding(padding: EdgeInsets.only(left: 15,right: 15),child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                         Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Text(widget.total??"0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    ],
                  ),)

                ],
              ),


          )),
          Align(
            child: InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>PaymentScreenView(totRate: widget.total,)));
              },
              child: Container(
                margin: EdgeInsets.only(left: 15,right: 15,bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primaryColor,
                ),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    Text("Charge",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white),),
                    SizedBox(
                      height: 3,
                    ),
                    Text(widget.total??"0.0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.white),)
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
