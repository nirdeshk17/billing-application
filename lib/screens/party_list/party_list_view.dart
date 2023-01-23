import 'package:billing_app/constants/colors.dart';
import 'package:billing_app/screens/payment_successful/payment_sucessful_view.dart';
import 'package:billing_app/utils/database.dart';
import 'package:billing_app/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
class PartyListView extends StatefulWidget {
final  int ? paymentId;
final String ? total;
  const PartyListView({Key? key,this.total,this.paymentId}) : super(key: key);

  @override
  _PartyListViewState createState() => _PartyListViewState();
}

class _PartyListViewState extends State<PartyListView> {
  TextEditingController billNameController=TextEditingController();
  List partyDtls=[];
  getPartydtls() async {
    Database db = await SQLiteDbProvider.db.database;
    var a = await db.rawQuery("select * from party_mastr");
    setState(() {
      partyDtls=a;
    });
  }
  @override
  void initState() {
    getPartydtls();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.arrow_back,color: Colors.white,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor:AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: Text("Select Bill Name",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      child: PrimaryFormField(
                        controller: billNameController,
                        hintText: "Select Bill Name",
                        onChanged: (value) async {
                          Database db = await SQLiteDbProvider.db.database;
                          List partyData = await db.rawQuery(
                              "SELECT * FROM party_mastr pm where pm.party_name LIKE '${billNameController.text}%'");
                          setState(() {
                            partyDtls = partyData;
                          });
                        },
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: partyDtls != null ? partyDtls.length : 0,
                      itemBuilder: (BuildContext, index) {
                        return GestureDetector(
                          onTap: () async{
                            Navigator.of(context).pop({"partyName":partyDtls[index]["party_name"],"partyId":partyDtls[index]["party_id"]});
                            // Navigator.pop(context,partyDtls[index][
                            // "party_name"]);
                            // Navigator.push(context,MaterialPageRoute(builder: (context)=>PaymentSucessfullScreenView(partyName:  partyDtls[index][
                            // "party_name"],partyId: partyDtls[index]["party_id"],paytype: widget.paymentId,total: widget.total,)));
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10,right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // padding: EdgeInsets.only(top: 5),
                                  child: Card(
                                    child: Row(
                                      children: [
                                        Container(
                                          // padding: EdgeInsets.all(2),
                                          width: 50,
                                          height: 50,
                                          child: Container(
                                            child: Center(
                                              child: Text(
                                                partyDtls[index]["party_name"]
                                                [0] ==
                                                    null
                                                    ? ""
                                                    : partyDtls[index]
                                                ["party_name"][0],
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                              color:AppColor.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          // padding: EdgeInsets.all(1),
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.75,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      partyDtls[index][
                                                      "party_name"] ==
                                                          null
                                                          ? ""
                                                          : partyDtls[index]
                                                      ["party_name"],
                                                      style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 12),
                                                      maxLines: 2,
                                                      softWrap: false,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),

    );
  }

}
