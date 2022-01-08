import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:katli_otopark_flutter/controllers/arabagirisi_controller.dart';
import 'package:katli_otopark_flutter/models/arabagirisi.dart';
import 'package:katli_otopark_flutter/otopark.dart';
import 'package:katli_otopark_flutter/screens/kayit.dart';
import 'package:katli_otopark_flutter/ui/theme.dart';
import 'package:katli_otopark_flutter/widgets/button.dart';
import 'package:katli_otopark_flutter/widgets/task_tile.dart';


class kayitlarPage extends StatefulWidget {
  const kayitlarPage({ Key? key }) : super(key: key);

  @override
  _kayitlarPageState createState() => _kayitlarPageState();
}

class _kayitlarPageState extends State<kayitlarPage> {
  final _taskController = Get.put(TaskController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFD40700),
      title: Text("Kayıtlı Araçlar"),),
      body: Column(
        children: [
          _addKayitBar(),
          SizedBox(height: 20,),
           Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 0.6,
            width: 400,
            color: Colors.black87,
          ),
          SizedBox(height: 10),
          _showTasks()
         
        
        ],
      ),
      
    );
  }
_showTasks(){
  return Expanded(
    child:Obx((){
      return ListView.builder(
        itemCount: _taskController.taskList.length,

        itemBuilder: (_, index){
        print(_taskController.taskList.length);
          
            
            return AnimationConfiguration.staggeredList(
              position: index,
               child: SlideAnimation(
                 child: FadeInAnimation(
                   child: Row(
                     children: [
                       GestureDetector(
                         onTap:(){
                           _showBottomSheet(context, _taskController.taskList[index]);
                         },
                         child:TaskTile(_taskController.taskList[index]),
                       )
                     ],
                   ),
                 ),

               )
               );
          

  }
  );

     }),
     );
}

    _showBottomSheet(BuildContext context, Task task){
      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.only(top: 4),
          height: task.isComplated==1?
          MediaQuery.of(context).size.height*0.24:
          MediaQuery.of(context).size.height*0.32,
          color: Colors.white,
          child: Column(
            children: [
              Container(
               height:6,
               width: 200,
               decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(10),
                color: Colors.grey[600]

              )
              ),
              Spacer(),
              task.isComplated==1
              ?Container()
                 : _bottomSheetButton(
                   label: "Ücret Ödendi",
                   onTap: (){
                     Get.back();
                     },
                   clr: blueishClr,
                   
                   context:context
                   ),
                    _bottomSheetButton(
                   label: "Kaydı Sil",
                   onTap: (){
                     _taskController.delete(task);
                     _taskController.getTasks();
                     Get.back();
                     },
                   clr: Colors.red[300]!,
                   
                   context:context
                   ),
                   SizedBox(height: 10,),
                   _bottomSheetButton(
                   label: "Geri",
                   onTap: (){
                     Get.back();
                     },
                   clr: Colors.red[300]!,
                   isClose: true,
                   
                   context:context
                   ),
                   SizedBox(height: 1,)
              ],


          ),

        )
      );
      
    }
    _bottomSheetButton({

      required String label,
      required Function()? onTap,
      required Color clr,
      bool isClose=false,
      required BuildContext context,
    }){
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            height: 55,
            width: MediaQuery.of(context).size.width*0.9,
            
            decoration: BoxDecoration(
              border:Border.all(
                width:2,
                color: isClose==true?Colors.red:clr
              ),
              borderRadius: BorderRadius.circular(20),
              color:isClose==true?Colors.transparent:clr ,
            ),

            child: Center(
              child: Text(
                label,
                style:isClose?titleStyle:titleStyle.copyWith(color: Colors.white )
              ),
            ),

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
              
              
              ],
              
            ),
          );
           
    
  }
}