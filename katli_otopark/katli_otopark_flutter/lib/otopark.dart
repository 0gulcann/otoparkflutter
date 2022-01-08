import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:intl/intl.dart';
import 'package:katli_otopark_flutter/screens/kayit.dart';
import 'package:katli_otopark_flutter/screens/kayitlar.dart';
import 'package:katli_otopark_flutter/widgets/button.dart';

class OtoparkScreen extends StatefulWidget {
  const OtoparkScreen({ Key? key }) : super(key: key);
  

  @override
  _OtoparkScreenState createState() => _OtoparkScreenState();
}


class _OtoparkScreenState extends State<OtoparkScreen> {
  bool click = true;
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFFD40700),
        elevation: 0,
        title: Text("Otopark",style: TextStyle(color: Color(0xFFFFFFFF)),),
      ) ,
      
      body: Column(
        children: [
             _addKayitBar(),
              SizedBox(height: 20),
               Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 0.6,
            width: 400,
            color: Colors.black87
          ),
            
            Container(
              
              child: Column(
              children: [
             
                ],
                ),
            )
              ,
              
         
          SizedBox(height: 20,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              parkYeri(context),
              
            ],
          ),
         
           
           
        ],
        
      ),
    );
  }

  Widget parkYeri(BuildContext context) {
    return Container(
              decoration: BoxDecoration(                 
                border: Border.all(color: Colors.black12),
                color: (click == false) ? Colors.green : Colors.red
              ),
              margin: EdgeInsets.only(left: 10,right: 10),
              width: 75,
             height: 150, 
            child: Column(
              children: <Widget>[
                Image.asset("assets/carr.jpg"), 
                Container(
                  child: 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical:6,horizontal: 2),
                    child: RawMaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      fillColor:  Color( 0xFFFFFFFF),
                      onPressed: (){
                        setState(() {
                          click =!click ;
                        });
                        
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>kayitPage()));
                       
                      }, child: Text("Kayıt",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                    ),
                  ),
                  
                  
                )
              ],
              
            ),
            
          );
  }

  _addKayitBar(){  
    return Container(
            margin: const EdgeInsets.only(right: 10,top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child:
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DateFormat.yMMMd().format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),),
                    Text("Bugün",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),)
                    
                  ],
                ),
              ),
              MyButton(label: "+ Kayıtlar", onTap: ()async{
              await  Get.to(()=>kayitlarPage());
              _arabaController.getArabas();
              
              
              }

              )],
              
            ),
          );
           
    
  }

}

class _arabaController {
  static void getArabas() {}
}