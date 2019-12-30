/*
 * @Author Bangjin Yu
 * @Email: 1227169416@qq.com
 * @Address: 梦想小镇互联网村
 * @Date 2019-12-24 19:15:35 Tuesday
 */

import 'package:flutter/material.dart';

import 'flutter_uikit.dart';

class DialogState {
  final String title;
  final String leftStr;
  final String rightStr;
  final double titleHeight;
  final double buttonHeight;
  final int titleColor;
  final int textColor;
  final int leftColor;
  final int rightColor;
  final double titleSize;
  final double textSize;
  final double buttonSize;

  final TextAlign textAlign;

  final Function backgroundAction;

  DialogState({
    this.title = '提示',
    this.leftStr = '取消',
    this.rightStr = '确认',
    this.titleHeight = 45,
    this.buttonHeight = 50,
    this.titleColor = 0xFF333333,
    this.textColor = 0xFF666666,
    this.leftColor = 0xFF666666,
    this.rightColor = 0xFF4AA3FF,
    this.titleSize = 18,
    this.textSize = 15,
    this.buttonSize = 16,
    this.textAlign = TextAlign.center,
    this.backgroundAction,
  });
}

class UIDialog extends StatefulWidget {
  final int color;
  final DialogState dialogState;
  final double width;
  final double height;
  final String text;
  const UIDialog({
    Key key,
    this.color = 0x51000000,
    this.text,
    this.dialogState,
    this.width,
    this.height,
  }) : super(key: key,);
  _UIDialog createState() => new _UIDialog();
}

class _UIDialog extends State<UIDialog> {
  double width = 280;
  double height = 170;
  DialogState dialogState;
  @override
  void initState() {
    super.initState();
    if(widget.dialogState==null){
      dialogState = new DialogState();
    }else{
      dialogState = widget.dialogState;
    }
  }
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () => dialogState?.backgroundAction ?? Navigator.pop(context),
      onDoubleTap: (){},
      child: new Scaffold(
        backgroundColor: Color(widget.color),
        body: new GestureDetector(
          onTap: () {},
          child: new Center(
            child: new Container(
            width: widget.width ?? width,
            height: widget.height ?? height,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: new Column(
              children: <Widget>[
                _titleView(),
                _textView(),
                Divider(
                  height: 1,
                  color: Color(0xFFEAEAEA),
                ),
                _buttonView(),
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }

  Widget _titleView() {
    return new Container(
      height: dialogState?.titleHeight,
      child: Center(
        child: UIText(
          data: dialogState?.title,
          color: dialogState?.titleColor,
          fontSize: dialogState?.titleSize,
        ),
      ),
    );
  }

  Widget _textView() {
    return new Expanded(
      flex: 1,
      child: new Container(
        height: dialogState?.titleHeight,
        child: Center(
          child: UIText(
            textAlign: dialogState?.textAlign,
            data: widget.text ?? '',
            color: dialogState?.textColor,
            fontSize: dialogState?.textSize,
          ),
        ),
      ),
    );
  }

  Widget _buttonView() {
    return new Container(
      height: dialogState?.buttonHeight,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: _getLiftBtn(),
          ),
          new Container(
            width: 1,
            color: Color(0xFFEAEAEA),
          ),
          new Expanded(
            child: _getRightBtn(),
          ),
        ],
      ),
    );
  }

  Widget _getLiftBtn() {
    return UIButton(
      onPressed: () {
        Navigator.pop(context, false);
      },
      buttonState: new UIButtonState(title: dialogState?.leftStr),
      padding: EdgeInsets.symmetric(vertical: 10),
      color: 0xFFFFFFFF,
      child: new UIText(
        data: dialogState?.leftStr,
        color: dialogState?.leftColor,
        fontSize: dialogState?.buttonSize,
      ),
    );
  }

  Widget _getRightBtn() {
    return UIButton(
      onPressed: () {
        Navigator.pop(context, true);
      },
      buttonState: new UIButtonState(title: dialogState?.rightStr),
      padding: EdgeInsets.symmetric(vertical: 10),
      color: 0xFFFFFFFF,
      child: new UIText(
        data: dialogState?.rightStr,
        color: dialogState?.rightColor,
        fontSize: dialogState?.buttonSize,
      ),
    );
  }
}
