import 'package:billing_app/constants/assets.dart';
import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/checkout/checkout_view.dart';
import 'package:billing_app/screens/drawer/menuscreen.dart';
import 'package:billing_app/screens/home/controller/home_screen_controller.dart';
import 'package:billing_app/screens/item_cart/item_cart_view.dart';
import 'package:billing_app/screens/login/login_view.dart';
import 'package:billing_app/utils/database.dart';
import 'package:billing_app/widgets/searchbar.dart';
import 'package:billing_app/widgets/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class HomeScreenView extends StatefulWidget {

  const HomeScreenView({Key? key}) : super(key: key);

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}
bool isLoading=true;
class _HomeScreenViewState extends State<HomeScreenView> {
  void initState() {
    isLoading=true;
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      context.read<HomeScreenController>().initState(context);
    });
    isLoading=false;


  }


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

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );

  final outerBoxDecoration = BoxDecoration(
    gradient: LinearGradient(

        colors: [Color(0xffba8b46), Color(0xffE6CB81)]),

    borderRadius: BorderRadius.circular(32),
  );

  final innerBoxDecoration = BoxDecoration(
    gradient: LinearGradient(colors: [Colors.white, Colors.white]),

    borderRadius: BorderRadius.circular(32),
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final watch = context.watch<HomeScreenController>();
    final read = context.read<HomeScreenController>();
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      drawer: Container(
          width: MediaQuery.of(context).size.width/1.3,
      child: Drawer(
      backgroundColor:AppColor.primaryColor,

      child: SingleChildScrollView(
        child:  Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      height: 70,
                      width:70,
                      decoration: BoxDecoration(
                        color:Colors.white,
                          border: Border.all(color: Colors.white,width: 3),
                          shape: BoxShape.circle),
                      child: Center(
                        child:Container(
                          child:  Image.asset(
                            "assets/images/syutlogo.png",
                            height: 35,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 100,
                          child:      Text(
                            "Syut Technologies",
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'whitneymedium',
                                fontWeight: FontWeight.w300),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Container(
                          height: 50,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft:Radius.circular(30),bottomLeft:Radius.circular(30) ),
                            color: Colors.white,
                          ),
                          child:  Icon(Icons.arrow_back,color: AppColor.primaryColor,size: 30,)
                      ),
                    ],
                  ),
                ),


              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(right: 40),
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Color(0xffba8b46),
            ),
            Container(
              padding: EdgeInsets.only(left: 25,right: 25,top: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: (){
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            context = context;
                            return AlertDialog(
                              content: Text("Syncing..."),
                            );
                          });
                      read.getAllItems(context);

                    },
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: outerBoxDecoration,
                          child:Container(
                            height: 50,
                            width: 50,
                            //   margin: EdgeInsets.all(2.5),
                            decoration: innerBoxDecoration,
                            child: Center(
                              child:Container(
                                width: 20,
                                height: 20,
                                child:Icon(Icons.download,color: AppColor.primaryColor,),
                              ),
                            ),
                          ),


                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Sync",style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'whitneysemibold',
                            fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: (){
                      showDialog(context: context,
                          builder: (BuildContext index) {
                            return Dialog(
                              child: SingleChildScrollView(
                                child: Stack(
                                  overflow: Overflow.visible,
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 40,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Are you sure you want to logout!!",
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 17),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "All data will be cleared",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 8,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),

                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              RaisedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                color: Colors.red,
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              RaisedButton(
                                                onPressed: () async{
                                                  Navigator.push(context,MaterialPageRoute(builder:(context)=>LoginScreenView()));
                                                },
                                                color: Colors.green,
                                                child: Text(
                                                  'Ok',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .white),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      child: CircleAvatar(
                                        radius: 30,
                                        backgroundColor:AppColor.primaryColor,
                                        child: Icon(
                                          Icons.flag,
                                          color: Colors.white,
                                        ),
                                      ),
                                      top: -28,
                                    ),
                                  ],
                                ),
                              ),

                            );
                          });

                    },
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: outerBoxDecoration,
                          child:Container(
                            height: 50,
                            width: 50,
                            //   margin: EdgeInsets.all(2.5),
                            decoration: innerBoxDecoration,
                            child: Center(
                              child:Container(
                                width: 20,
                                height: 20,
                                child:Icon(Icons.logout,color: AppColor.primaryColor,),
                              ),
                            ),
                          ),


                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text("Logout",style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'whitneysemibold',
                            fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

    ),
    ),

      appBar: AppBar(
        leadingWidth: 150,
        leading: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: (){
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Image.asset(AssetsIcon.assetsIconDrawer,width: 20,height: 20,color: Colors.white,),
            ),
            SizedBox(
              width: 15,
            ),
            InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckoutViewScreen(checkoutList:watch.selectedItmList,itemQty:watch.selectedItmList?.length.toString(),total: watch.totSum,)));
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
      body: WillPopScope(
           onWillPop: ()async{
             return false;
           },
           child: SingleChildScrollView(
             child: Column(
               children: [
                 InkWell(
                   onTap:(){
                     Navigator.push(context,MaterialPageRoute(builder: (context)=>CheckoutViewScreen(checkoutList:watch.selectedItmList,itemQty:watch.selectedItmList?.length.toString(),total: watch.totSum,)));
                   },
                   child:      Container(
                     margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                     padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                       color: AppColor.primaryColor.withOpacity(0.9),
                     ),
                     child: Column(
                       children: [
                         Text("CHARGE",style: TextStyle(color: Colors.white,fontSize: 17,),),
                         Text(watch.totSum!='null'?watch.totSum??"0.0":"0.0",style:  TextStyle(color: Colors.white,fontSize: 17),),
                       ],
                     ),
                   ),
                 ),
                 !watch.isSearchBarVisible? Row(
                   children: [
                     Expanded(
                       child:Container(
                         height: 50,
                         child: DropdownSearch(
                           filterFn: (a, b) {
                             if (a
                                 .toString()
                                 .toUpperCase()
                                 .startsWith(b.toUpperCase())) {
                               return true;
                             } else {
                               return false;
                             }
                           },
                           items:watch.itemNameList,
                           onSaved: (value){

                             print(value);
                           },
                           showSearchBox: true,
                           onChanged: (value){
                             Navigator.push(context,MaterialPageRoute(builder: (context)=>ItemCartScreenView(itemName: value.toString(),)));
                           },
                           selectedItem: "All Items",
                         ),
                       ),

                     ),
                     Container(
                       height: 49,
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.grey)
                       ),
                       child: Row(
                         children: [
                           SizedBox(
                             width: 5,
                           ),
                           Row(
                             children: [
                               Image.asset(AssetsIcon.assetsIconBarcode,width: 20,height: 20,),
                               SizedBox(
                                 width: 10,
                               ),
                               InkWell(
                                 onTap: (){
                                   read.onSearchPressed();
                                 },
                                 child:  Icon(Icons.search),
                               ),

                             ],
                           ),
                         ],
                       ),
                     ),
                   ],
                 ):SearchBar(
                     label: "Search",
                     controller: watch.searchController,
                     onChanged: (value){

                     },
                     suffixIcon: InkWell(child:Icon(Icons.close,color: Colors.black),onTap: (){
                       read.onClosePressed();
                     },)
                 ),
                 ListView.builder(itemCount:watch.selectedItmList?.length??0,shrinkWrap: true,itemBuilder: (BuildContext,index){
                   return GestureDetector(
                     onTap: (){
                       Navigator.push(context,MaterialPageRoute(builder: (BuildContext)=>ItemCartScreenView(itemName: watch.selectedItmList?[index]["itm_name"],itemRate: watch.selectedItmList?[index]["itm_rate"].toString(),qty: watch.selectedItmList?[index]["qty"].toString(),)));
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
                                           fontSize: 20),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                   ),
                                 ],
                                 mainAxisAlignment: MainAxisAlignment.center,
                               ),

                               SizedBox(
                                 height: 5,
                               ),
                               Row(
                                 mainAxisAlignment:
                                 MainAxisAlignment
                                     .spaceBetween,
                                 children: [
                                   Row(
                                     children: [
                                       Text(
                                         watch.selectedItmList?[index]["itm_rate"].toString()??"",
                                         style: TextStyle(
                                             color: Colors.black),
                                       ),
                                       SizedBox(
                                         width: 5,
                                       ),
                                       Text(
                                           watch.selectedItmList?[index]["qty"].toString()??"",
                                           style: TextStyle(
                                               color:
                                               Colors.black)),
                                     ],
                                   ),
                                   Row(
                                     children: [
                                       Text("${(double.parse( watch.selectedItmList?[index]["qty"])*double.parse( watch.selectedItmList?[index]["itm_rate"])).toStringAsFixed(2)}",
                                         style: TextStyle(
                                             color: Colors.black,fontSize: 18),
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
               ],
             ),
           ),
         ), // Container()



    );
  }
  Widget BottomSheetContainer() {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {

            },
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color:  Color(0xff8b0e1a),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: Image.asset(
                        "assets/icons/explore/appointment1.png",
                        height: 25,
                        color: Colors.white,
                        width: 25,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Book Store Appointment",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'whitneysemibold',
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            height: 0.2,
            color: Colors.grey,
            width: MediaQuery.of(context).size.width,
          ),
          InkWell(
            onTap: () {

            },
            child: Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color:  Color(0xff8b0e1a),
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: Image.asset(
                        "assets/icons/explore/videoconfrence1.png",
                        height: 25,
                        color: Colors.white,
                        width: 25,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "Book Video Call",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontFamily: 'whitneysemibold',
                      fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
