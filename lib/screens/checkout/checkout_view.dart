import 'package:billing_app/constants/assets.dart';
import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/home/controller/home_screen_controller.dart';
import 'package:billing_app/screens/payment/payment_view.dart';
import 'package:billing_app/widgets/searchbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<HomeScreenController>().initState(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    final watch=context.watch<HomeScreenController>();
    final read=context.read<HomeScreenController>();
    return Scaffold(
      backgroundColor: Colors.white,
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
                      child: Text(watch.selectedItmList?.length.toString()??"0"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Image.asset(AssetsIcon.assetsIconUserAdd,color: Colors.white,height: 25,width: 25,),
          SizedBox(
            width: 10,
          ),
          // GestureDetector(
          //   onTapDown: (TapDownDetails details) {
          //     _showPopupMenu(details.globalPosition);
          //   },
          //   child: Image.asset(AssetsIcon.assetsIconDots,width: 20,height: 20,color: Colors.white,),
          // ),
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
                      Expanded(child: SearchBar(
                          label: "Search",
                          controller: watch.searchController,
                          onChanged: (value){
                            read.onCheckoutSearch(value);
                          },
                      ),),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListView.builder(itemCount:watch.selectedItmList?.length??0,shrinkWrap: true,itemBuilder: (BuildContext,index){
                    return GestureDetector(
                      onTap: (){
                        // Navigator.push(context,MaterialPageRoute(builder: (BuildContext)=>ItemCartScreenView(itemName: watch.selectedItmList?[index]["itm_name"],itemRate: watch.selectedItmList?[index]["itm_rate"].toString(),qty: watch.selectedItmList?[index]["qty"].toString(),)));
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                      Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,

                        secondaryActions: [
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.delete,
                            onTap: () {
                             read.onDeletePressed(watch.selectedItmList?[index]["itm_id"]);
                            },
                          ),
                        ],
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 10),
                            width:
                            MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      child:    Text(watch.selectedItmList?[index]["itm_name"].toString()??"",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('\u{20B9}',style:TextStyle(
                                    color: Colors.black),),
                                        Text(
                                          watch.selectedItmList?[index]["itm_rate"].toString()??"",
                                          style: TextStyle(
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            watch.selectedItmList?[index]["qty"].toString()??"",
                                            style: TextStyle(
                                                color:
                                                Colors.green)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('\u{20B9}',style:TextStyle(
                                            color: Colors.black,fontSize: 16),),
                                        watch.selectedItmList?[index]["qty"]!=null?
                                        Text( "${(watch.selectedItmList?[index]["qty"]*watch.selectedItmList?[index]["itm_rate"]).toStringAsFixed(2)}",
                                          style: TextStyle(
                                              color: Colors.black,fontSize: 16),
                                        ):   Text("0.0",
                                          style: TextStyle(
                                              color: Colors.black,fontSize: 16),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Container(
                          //   padding:EdgeInsets.symmetric(vertical:10,horizontal:10),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Text(watch.selectedItmList?[index]["itm_name"].toString()??""),
                          //       Text(watch.selectedItmList?[index]["itm_rate"].toString()??""),
                          //     ],
                          //   ),
                          //   decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.black)
                          //   ),
                          // ),
                      ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(padding: EdgeInsets.only(left: 15,right: 15),child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                         Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Text(watch.totSum??"0",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
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
