import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconImage, this.text});
  Widget iconImage;
  Widget text;
}

// ignore: must_be_immutable
class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
    this.selectedIndex,
  }) {
    assert(this.items.length == 2 || this.items.length == 4);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  var selectedIndex;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    items.insert(items.length >> 1, _buildMiddleTabItem());

    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(35.0),
        topRight: Radius.circular(35.0),
      ),
      child: BottomAppBar(
        shape: widget.notchedShape,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: items,
        ),
        color: widget.backgroundColor,
      ),
    );
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? '',
              style: TextStyle(color: widget.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color =
        widget.selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: GestureDetector(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // margin: const EdgeInsets.only(left: 5),
                  height: 77,
                  width: 80,
                  //padding: EdgeInsets.only(right: 15, left: 15),
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      )),
                  child: Column(
                    children: [
                      item.iconImage,
                      item.text,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
