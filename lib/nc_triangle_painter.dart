import 'dart:math';

///
///Author: YoungChan
///Date: 2019-05-27 13:53:12
///LastEditors: YoungChan
///LastEditTime: 2019-05-27 17:02:57
///Description: 三角形绘制
///
import "package:flutter/material.dart";

class NCTrianglePainter extends CustomPainter {
  Paint _paint = new Paint(); //画笔富含各种属性方法
  final BuildContext context;

  ///三角顶端锚点
  final Color color;

  ///true 倒三角， false 正三角
  final bool isReverse;

  ///三角行边长
  final int size;
  List spots;
  NCTrianglePainter(this.context,
      {this.color, this.isReverse = false, this.size = 12}) {
    spots = List(3);
    var y = size * 0.85;
    //上下顶点
    spots[0] = Offset.zero;
    if (isReverse) {
      //倒三角
      //左顶点
      spots[1] = Offset(-size / 2, -y);
      //右顶点
      spots[2] = Offset(size / 2, -y);
    } else {
      //正三角
      //左顶点
      spots[1] = Offset(-size / 2, y);
      //右顶点
      spots[2] = Offset(size / 2, y);
    }
  }

  @override
  void paint(Canvas canvas, Size siez) {
    Path path = new Path();
    path.moveTo(spots[0].dx, spots[0].dy);
    path.lineTo(spots[1].dx, spots[1].dy);
    path.lineTo(spots[2].dx, spots[2].dy);

    // 设置画笔
    _paint.style = PaintingStyle.fill;
    _paint.color = this.color;
    // 开始绘制
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
