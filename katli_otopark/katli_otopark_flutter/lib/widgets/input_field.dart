import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyInputField extends StatelessWidget {
  
  
  final String title;
  final String hint;
  final  TextEditingController? controller;
  final Widget? widget;
  const MyInputField({ Key? key,

    required final this.title,
    required final this.hint,
    this.controller,
    this.widget,
    

   }) : super(key: key);
    

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: [
        Text(
          title,
          style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,),
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          padding: EdgeInsets.only(left: 14.0),
          height: 52,
          decoration: BoxDecoration(
            border: Border.all(
              color:Colors.grey,
              width: 1.0
            ),
            borderRadius: BorderRadius.circular(12)
          ),
          child: Row(
            children: [
              Expanded(
              child: TextFormField(
                readOnly: widget==null?false:true,
                autofocus:true,
                cursorColor: Colors.grey[400],
                controller: controller,
                style:  TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Colors.grey[600]),
                decoration: InputDecoration(

                  hintText: hint,
                  hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,color:
                  Colors.grey[600],  ),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color:Colors.white) 
                ),
                
              )
              )
              )
              


              ],
          ),
          )

      ],
      ),
      
    );
  }
}