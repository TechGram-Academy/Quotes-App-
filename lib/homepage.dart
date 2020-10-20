import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  static const Color textColor = Colors.white;
  static const Color cardBackColor = Colors.lightBlue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quotes App"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("quotes").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data.docs.map((document) {
              return Card(
                color: cardBackColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.yellow, width: 1),
                  borderRadius: BorderRadius.circular(15.0),
                ),

                elevation: 20,
                margin: EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        document["quote"],
                        style: TextStyle(fontSize: 20, color: textColor, fontWeight:FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "by ${document["by"]}",
                                style: TextStyle(color: textColor),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

//Text(document["quote"]),
//Text(document["by"]),
