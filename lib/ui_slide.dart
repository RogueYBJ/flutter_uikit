/*
 * @author: 余邦锦（RogueYBJ） 
 * @date 2020/12/8.
 * slogan: 每行代码的开始都意味着新的征程
 * E-Mail Address：15179861454@163.com
 * Work Address: 浙江省杭州市滨江区聚光中心1704
 * file Address: lib/ui_kit/ui_slide
 * description: ui_slide
 */

import 'package:flutter/material.dart' hide Action;

enum UISlideType { NORMAL, LEFT, TOP, BOTTOM, RIGHT } // 默认为右侧

class UISlide extends StatefulWidget {
  final UISlideType type; // 上下左右侧滑
  final Widget child; // 子组件
  final double sp; // 侧滑距离 默认值为 1
  const UISlide({Key key, this.child, this.type, this.sp = 1})
      : super(key: key);

  _UISlide createState() => new _UISlide();
}

class _UISlide extends State<UISlide> {
  //静止状态下的offset
  Offset _startOffset = Offset(0, 0);

  //本次移动的offset
  Offset _moveOffset = Offset(0, 0);

  //最后一次down事件的offset
  Offset _endOffset = Offset(0, 0);

  bool _isSlide = false;


  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _moveOffset,
      child: GestureDetector(
        onPanStart: (detail) {
          _startOffset = detail.localPosition;
        },
        onPanUpdate: (detail) {
          _moveOffset = detail.localPosition - _startOffset;
          _setMoveOffset();
          setState(() {});
        },
        onPanEnd: (detail) {
          _setEndOffset();
          setState(() {
          });
        },
        child: widget.child,
      ),
    );
  }

  void _setMoveOffset() {
    if(widget.type==UISlideType.TOP || widget.type == UISlideType.BOTTOM){
      if(widget.type==UISlideType.TOP){
        if(_isSlide){
          _moveOffset = Offset(0, _moveOffset.dy + (widget.sp??0.0));
        }
        _moveOffset = Offset(0, _moveOffset.dy>0.0?_moveOffset.dy:0);
      }else{
        if(_isSlide){
          _moveOffset = Offset(0, _moveOffset.dy - (widget.sp??0.0));
        }
        _moveOffset = Offset(0, _moveOffset.dy<0.0?_moveOffset.dy:0);
      }
    }else{
      if(widget.type==UISlideType.LEFT){
        if(_isSlide){
          _moveOffset = Offset(_moveOffset.dx + (widget.sp??0.0), 0);
        }
        _moveOffset = Offset(_moveOffset.dx>0.0?_moveOffset.dx:0, 0);
      }else{
        if(_isSlide){
          _moveOffset = Offset(_moveOffset.dx - (widget.sp??0.0), 0);
        }
        _moveOffset = Offset(_moveOffset.dx<0.0?_moveOffset.dx:0, 0);
      }
    }
  }

  void _setEndOffset(){
    if(widget.type==UISlideType.TOP || widget.type == UISlideType.BOTTOM){
      if(widget.type==UISlideType.TOP){
        if(_isSlide && (_moveOffset.dy - (widget.sp??0.0)) < 0){
          _isSlide = false;
          _moveOffset = Offset(0, 0);
        }else if(_moveOffset.dy > 0){
          _isSlide = true;
          _moveOffset = Offset(0, widget.sp??0.0);
        }
      }else{
        if(_isSlide && (_moveOffset.dy + (widget.sp??0.0)) > 0){
          _isSlide = false;
          _moveOffset = Offset(0, 0);
        }else if(_moveOffset.dy < 0){
          _isSlide = true;
          _moveOffset = Offset(0, - widget.sp??0.0);
        }
      }
    }else{
      if(widget.type==UISlideType.LEFT){
        if(_isSlide && (_moveOffset.dx - (widget.sp??0.0)) < 0){
          _isSlide = false;
          _moveOffset = Offset(0, 0);
        }else if(_moveOffset.dx > 0){
          _isSlide = true;
          _moveOffset = Offset(widget.sp??0.0, 0);
        }
      }else{
        if(_isSlide && (_moveOffset.dx + (widget.sp??0.0)) > 0){
          _isSlide = false;
          _moveOffset = Offset(0, 0);
        }else if(_moveOffset.dx < 0){
          _isSlide = true;
          _moveOffset = Offset(- widget.sp??0.0, 0);
        }
      }
    }
  }
}
