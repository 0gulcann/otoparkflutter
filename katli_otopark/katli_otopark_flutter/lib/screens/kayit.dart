import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:katliotopark/controllers/arabagirisi_controller.dart';
import 'package:katliotopark/models/arabagirisi.dart';
import 'package:katliotopark/widgets/button.dart';
import 'package:katliotopark/widgets/input_field.dart';
import 'package:katliotopark/screens/kayitlar.dart';

class kayitPage extends StatefulWidget {
  @override
  _kayitPageState createState() => _kayitPageState();
}

class _kayitPageState extends State<kayitPage> {
  final TaskController _taskController = Get.put(TaskController());
  final TextEditingController _markaController = TextEditingController();
  final TextEditingController _plakaController = TextEditingController();
  String _endTime = "10:00 AM ";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  var taskCollections = FirebaseFirestore.instance.collection("parkLots");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD40700),
      ),
      body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Araba Girişi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                MyInputField(
                  title: "Plaka",
                  hint: "Plakayı Girin",
                  controller: _plakaController,
                ),
                MyInputField(
                  title: "Marka",
                  hint: "Markayı Girin",
                  controller: _markaController,
                ),
                Row(children: [
                  Expanded(
                    child: MyInputField(
                      title: "Giriş Saati",
                      hint: _startTime,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _getTimeFromUser(isStartTime: true);
                    },
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: MyInputField(
                      title: "Çıkış Saati",
                      hint: _endTime,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _getTimeFromUser(isStartTime: false);
                    },
                    icon: Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[700],
                      size: 20,
                    ),
                  ),
                ]),
                SizedBox(height: 20),
                MyButton(label: "Kaydet", onTap: () => _validateDate())
              ],
            ),
          )),
    );
  }

  _validateDate() {
    if (_plakaController.text.isNotEmpty && _markaController.text.isNotEmpty) {
      _addTaskToDb();
      _taskController.getTasks();
      taskCollections.doc(_plakaController.text.toString()).set({
        "plaka": _plakaController.text,
        "marka": _markaController.text,
        "dateoftime": _startTime,
      });
      Get.to(() => kayitlarPage());
    } else if (_plakaController.text.isEmpty || _markaController.text.isEmpty) {
      Get.snackbar(
        "Zorunlu",
        "Bütün Alanların Doldurulması Zorunludur",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.pink,
        icon: Icon(Icons.warning_amber_rounded, color: Colors.red),
      );
    }
  }

  _addTaskToDb() async {
    int value = await _taskController.addTask(
        task: Task(
      plaka: _plakaController.text,
      marka: _markaController.text,
      startTime: _startTime,
      endTime: _endTime,
    ));
    print("My id is " + "$value");
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Saat iptal edildi");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }
}
