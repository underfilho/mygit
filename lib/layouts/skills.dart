import 'package:flutter/material.dart';
import 'package:mygit/utils/const.dart';

class Skills extends StatefulWidget {
  final Function onTap;
  final int selectedIndex;

  Skills({this.onTap, this.selectedIndex});

  @override
  _SkillsState createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 20),
      height: 100,
      child: ListView.builder(
        itemCount: Const.images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => widget.onTap(index),
            child: Container(
              margin: EdgeInsets.all((index == widget.selectedIndex) ? 15 : 20),
              child: (index == widget.selectedIndex)
                  ? Image.asset(Const.images_focus[index],
                      width: 70, height: 70)
                  : Image.asset(Const.images[index], width: 60, height: 60),
            ),
          );
        },
      ),
    );
  }
}
