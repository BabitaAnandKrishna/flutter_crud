import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: produtcDetails(),
    );
  }
}


class produtcDetails extends StatefulWidget {
  @override
  _produtcDetailsState createState() => _produtcDetailsState();
}

class _produtcDetailsState extends State<produtcDetails> {
  TextEditingController ProductNameController = TextEditingController();
  TextEditingController ProductImageController = TextEditingController();
  TextEditingController ProductPriceController = TextEditingController();
  TextEditingController ProductIDController = TextEditingController();

  //final Ref = Firestore.instance.collection("ProductsDetails");
  final Ref = Firestore.instance.collection("ProductsDetails");
  Map<String,dynamic> productToAdd;
  addProduct(){
    productToAdd = {
      "ProductName": ProductNameController.text,
      "ProductImage": ProductImageController.text,
      "productPrice":ProductPriceController.text,
      "productID":ProductIDController.text,
    };
    Ref.add(productToAdd).whenComplete(() {
      Navigator.pop(context);
      ProductImageController.text = "";
      ProductNameController.text = "";
      ProductPriceController.text = "";
      ProductIDController.text = "";

      print("Added to the DataBase");
    });
  }

  // updateProduct(){
  //   productToAdd = {
  //     "ProductName": ProductNameController.text,
  //     "ProductImage": ProductImageController.text,
  //     "productPrice":ProductPriceController.text,
  //     "productID":ProductIDController.text,
  //   };
  //   Ref.add(productToAdd).whenComplete(() {
  //     Navigator.pop(context);
  //     ProductImageController.text = "";
  //     ProductNameController.text = "";
  //     ProductPriceController.text = "";
  //     ProductIDController.text = "";
  //
  //     print("Update to the DataBase");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: StreamBuilder(
        stream: Ref.snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return Card(
                              // child: Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text(snapshot
                              //         .data.documents[index].data["ProductID"].toString(),
                              //       style: TextStyle(
                              //           fontSize: 25,
                              //           fontWeight: FontWeight.w700
                              //       ),),
                              //     Text(snapshot
                              //         .data.documents[index].data['ProductName'],
                              //       style: TextStyle(
                              //           fontSize: 25,
                              //           fontWeight: FontWeight.w700
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // child: ListTile(
                              //   // leading: ConstrainedBox(
                              //   //   constraints: BoxConstraints(
                              //   //     minWidth: 80,
                              //   //     minHeight: 80,
                              //   //   ),
                              //   //   child: Image.network(snapshot.data.documents[index].data["ProductUrl"], width: 120, height: 120),),
                              //
                              //   leading: CircleAvatar(
                              //      child: Image.network(snapshot.data.documents[index].data["ProductUrl"], width: 120, height: 120),
                              //     radius: 50,
                              //           ),
                              //   title: Text(snapshot.data.documents[index].data["ProductID"].toString(),
                              //     style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),),
                              //   subtitle: Text(snapshot.data.documents[index].data["ProductName"].toString() +"\n £"  + snapshot.data.documents[index].data["ProductPrice"].toString() ,
                              //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 15),),
                              //   isThreeLine: true,
                              //   trailing:  Icon(Icons.edit),
                              //   ),

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: (){
                                        ProductNameController.text = snapshot
                                            .data.documents[index].data["ProductName"];
                                        ProductImageController.text = snapshot
                                        .data.documents[index].data["ProductUrl"];
                                        // ProductIDController.text = snapshot
                                        //     .data.documents[index].data["ProductID"];
                                        // ProductPriceController.text = snapshot
                                        //     .data.documents[index].data["ProductPrice"];

                                        showDialog(context: context,builder: (_)=> Dialog(
                                          child: Container(
                                            height: 300,
                                            child:
                                            Column(
                                              children: [
                                                Padding(padding: const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller: ProductNameController,
                                                    decoration: InputDecoration(
                                                        hintText: "Name",
                                                        labelText: "Name"
                                                    ),

                                                  ),
                                                ),
                                                Padding(padding: const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller: ProductImageController ,
                                                    decoration: InputDecoration(
                                                        hintText: "Image",
                                                        labelText: "Image"
                                                    ),

                                                  ),
                                                ),
                                                SizedBox(height: 20,),
                                                Container(
                                                  height: 50,
                                                  width: 120,
                                                  color: Colors.blueAccent,
                                                  child: FlatButton(
                                                    onPressed: (){
                                                      updateProduct();
                                                    },
                                                    child: Text("Update"),
                                                  ),
                                                )
                                              ],
                                            ),

                                          ),

                                        ),);
                                      },
                                      child: Icon(Icons.edit)),
                                  SizedBox(width: 10,),
                                  Image.network(
                                    snapshot.data.documents[index].data["ProductUrl"],
                                    width: 100,height: 100,),
                                  SizedBox(width: 10,),
                                  Text(snapshot.data.documents[index].data["ProductName"]),
                                  InkWell(onTap: (){
                                    snapshot.data.documents[index].reference.delete().whenComplete(() => Navigator.pop);
                                  },

                                      child: Icon(Icons.clear))
                                ],
                              ),
                            );
                          },
                   ),
                  Container(
                    height: 50,
                    width: 300,
                    color: Colors.blue,
                    child: FlatButton(onPressed: (){
                      showDialog(context: context,builder: (_)=> Dialog(
                        child: Container(
                          height: 300,
                          child:
                          Column(
                            children: [
                              Padding(padding: const EdgeInsets.all(8.0),
                               child: TextFormField(
                                controller: ProductNameController,
                                decoration: InputDecoration(
                                  hintText: "Name",
                                  labelText: "Name"
                                ),

                              ),
                              ),
                              Padding(padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: ProductImageController ,
                                  decoration: InputDecoration(
                                      hintText: "Image",
                                      labelText: "Image"
                                  ),

                                ),
                              ),
                              SizedBox(height: 20,),
                              Container(
                                height: 50,
                                width: 120,
                                color: Colors.blueAccent,
                                child: FlatButton(
                                  onPressed: (){
                                    addProduct();
                                  },
                                  child: Text("Add"),
                                ),
                              )
                            ],
                          ),

                        ),

                      ),);
                    },
                        child: Text("Add New")),
                  )
                ],
              ),
            );
            } else {
              return CircularProgressIndicator();
            }
          }
      ),
    );
  }
}
