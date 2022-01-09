import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:katliotopark/controllers/arabagirisi_controller.dart';
import 'package:katliotopark/models/arabagirisi.dart';
import 'package:katliotopark/otopark.dart';
import 'package:katliotopark/screens/kayit.dart';
import 'package:katliotopark/ui/theme.dart';
import 'package:katliotopark/widgets/button.dart';
import 'package:katliotopark/widgets/task_tile.dart';

class kayitlarPage extends StatefulWidget {
  const kayitlarPage({Key? key}) : super(key: key);

  @override
  _kayitlarPageState createState() => _kayitlarPageState();
}

class _kayitlarPageState extends State<kayitlarPage> {
  final _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("parkLots").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new Text('Loading...');
          return new ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        color: Colors.grey,
                        child: Card(
                            color: Colors.grey,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                document["plaka"],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    fontFamily: "NotoSerif"),
                                                textAlign: TextAlign.justify,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "araç: " + document["marka"],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: "NotoSerif"),
                                              textAlign: TextAlign.justify,
                                              maxLines: 1,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Çıkış Yapacak: " +
                                                      document["dateoftime"]
                                                          .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontFamily: "NotoSerif"),
                                                  textAlign: TextAlign.justify,
                                                  maxLines: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      )));
            }).toList(),
          );
        },
      ),
    );
  }
}
