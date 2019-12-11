///
///Author: YoungChan
///Date: 2019-05-27 17:21:06
///LastEditors: YoungChan
///LastEditTime: 2019-12-11 14:55:26
///Description: 弹出菜单
///
import 'package:flutter/material.dart';
import 'nc_triangle_painter.dart';

class NCPopupMenu extends StatefulWidget {
  ///锚点坐标
  final Offset anchorOffset;
  final Size anchorSize;

  ///菜单项
  final List<NCMenuItem> menuItems;

  ///菜单点击事件
  final void Function(dynamic) onMenuItemTap;

  ///菜单宽度
  final double width;

  ///横向偏移
  final double offsetX;

  ///纵向偏移
  final double offsetY;
  NCPopupMenu(
      {@required this.anchorOffset,
      @required this.anchorSize,
      @required this.menuItems,
      this.onMenuItemTap,
      this.width = 130,
      this.offsetX = 0,
      this.offsetY = 0})
      : assert(anchorOffset != null),
        assert(anchorSize != null),
        assert(menuItems != null);

  @override
  _NCPopupMenuState createState() => _NCPopupMenuState();
}

class _NCPopupMenuState extends State<NCPopupMenu> {
  //是否倒三角
  bool _isTriangleReverse = false;
  //三角形锚点坐标
  double _py = 0;
  double _px = 0;
  //菜单窗体坐标
  double _menuLeft = 0;
  double _menuTop = 0;
  List<Widget> _menuChildren;

  void _initMenuPosition() {
    final screenSize = MediaQuery.of(context).size;

    //计算三角形锚点坐标
    var py = widget.anchorOffset.dy + widget.anchorSize.height / 2;
    var px = widget.anchorOffset.dx + widget.anchorSize.width / 2;
    //计算左右顶角是否超边界, 默认三角距离屏幕边界最小16px
    var pLeft = px - 6;
    var pRight = px + 6;
    if (pLeft < 16) {
      px += 16 - pLeft;
    } else if (pRight > screenSize.width) {
      px -= 16 - screenSize.width + pRight;
    }
    //预计计算是否倒三角， 默认菜单项高度44, 菜单默认距离底边距8px
    if (screenSize.height - (widget.menuItems.length * 44 + py + 12 * 0.85) <
        8) {
      _isTriangleReverse = true;
      //如果超出底边界，则为倒三角, 三角锚点定在archorView上边界
      py = widget.anchorOffset.dy - widget.anchorSize.height / 2;
    }
    py += widget.offsetY;
    _px = px;
    _py = py;

    //计算menu窗体坐标 , 默认距离屏幕边缘8px
    var menuLeft = px - widget.width / 2;
    var menuRight = px + widget.width / 2;
    if (menuLeft < 8) {
      menuLeft = 8;
    } else if (menuRight > screenSize.width) {
      menuLeft -= 8 - screenSize.width + menuRight;
    }
    var menuTop = py + 12 * 0.85 - 1;
    if (_isTriangleReverse) {
      //如果倒三角，三角在窗体底边
      menuTop = py - 12 * 0.85 - 44 * widget.menuItems.length + 1;
    }
    _menuLeft = menuLeft;
    _menuTop = menuTop;
  }

  @override
  void initState() {
    _menuChildren = [];
    for (var i = 0; i < widget.menuItems.length; i++) {
      var item = widget.menuItems[i];
      _menuChildren.add(InkWell(
        child: SizedBox.fromSize(
          size: Size.fromHeight(44),
          child: item,
        ),
        onTap: () {
          if (widget.onMenuItemTap != null) {
            widget.onMenuItemTap(item.value);
          }
        },
      ));
      if (i < widget.menuItems.length - 1) {
        _menuChildren.add(Divider(
          height: 1,
          color: Color(0xFFEEEEEE),
          indent: 8,
        ));
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initMenuPosition();
    return Stack(
      children: <Widget>[
        //绘制菜单窗体
        Positioned(
          left: _menuLeft + widget.offsetX,
          top: _menuTop,
          width: widget.width,
          //为了点击ink 效果，用Material 包裹下
          child: DecoratedBox(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(blurRadius: 6, color: Colors.black26, spreadRadius: 4)
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Material(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: _menuChildren,
                ),
              ),
            ),
          ),
        ),
        //绘制三角形
        Positioned(
          left: _px,
          top: _py,
          child: CustomPaint(
              painter: NCTrianglePainter(context,
                  isReverse: _isTriangleReverse,
                  color: Colors.white,
                  size: 12)),
        ),
      ],
    );
  }
}

/// 下拉弹出对话框菜单项
class NCMenuItem extends StatelessWidget {
  final dynamic value;
  final Widget child;

  NCMenuItem({this.value, this.child});

  factory NCMenuItem.textWithIcon(
      {@required dynamic value, Widget icon, Text text}) {
    return NCMenuItem(
      value: value,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            icon,
            Container(
              width: 8,
            ),
            text
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => child;
}
