
import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {

  TextComposer({this.sendMessage});

  final Function({String text}) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {

  final TextEditingController _controller = TextEditingController();

  bool _isComposing = false;

  void _reset(){
    _controller.clear();
    setState(() {
      _isComposing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey
                          .withAlpha(30),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                      onChanged: (text){
                        setState(() {
                          _isComposing = text.isNotEmpty;
                        });
                      },
                    onSubmitted: (text){
                      widget.sendMessage(text: text);
                      _reset();
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enviar uma mensagem'),
                  ),
                )),
          ),
          Material(
            color: Color(0xff5C2E85),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white,),
              onPressed: _isComposing ? (){
                widget.sendMessage(text: _controller.text);
                _reset();
              } : null,
            ),
          )
        ],
      ),
    );
  }
}
