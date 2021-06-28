import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {

  ChatMessage(this.data);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: data['type']  == "receiver"?
      EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.3)
      : EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3) ,
      child: Container(
        decoration: BoxDecoration(
            color: data['type']  == "receiver"?Color(0xff5C2E85):Color(0xffF8F7FC),
            borderRadius: data['type']  == "receiver"?
              BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              ) :
              BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
        ),
        padding: EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Align(
          alignment: data['type'] == "receiver"?Alignment.topLeft:Alignment.topRight,
          child: Center(
            child: Text(data['text'],
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: data['type']  == "receiver"? Colors.white : Colors.grey,
                  fontSize: 16
              ),
            ),
          ),
        ),
      ),
    );
  }
}
