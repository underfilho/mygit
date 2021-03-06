import 'package:flutter/material.dart';

class FocusList extends StatefulWidget {
  final List<Widget> items;
  final int initialIndex;
  final Function(int) onTap;
  final Duration duration;

  FocusList({this.items, this.initialIndex, this.onTap, this.duration});

  @override
  _FocusListState createState() => _FocusListState();
}

class _FocusListState extends State<FocusList> with TickerProviderStateMixin {
  List<AnimationController> animControllers = [];
  List<Animation> curves = [];

  @override
  void initState() {
    super.initState();

    int length = widget.items.length;
    for (int i = 0; i < length; i++) {
      animControllers
          .add(AnimationController(duration: widget.duration, vsync: this));
      curves.add(
          CurvedAnimation(parent: animControllers[i], curve: Curves.easeInOut));
    }

    if (widget.initialIndex != null)
      animControllers[widget.initialIndex].forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (_, index) {
          return AnimatedBuilder(
            animation: curves[index],
            builder: (_, child) {
              return Transform.scale(
                scale: 1 + curves[index].value * 0.3,
                child: GestureDetector(
                  onTap: () {
                    setScale(index);
                    widget.onTap(index);
                  },
                  child: ColorFiltered(
                    colorFilter: colorScale(0.5 + curves[index].value * 0.5,
                        0.5 - curves[index].value * 0.5),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: widget.items[index],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void setScale(int index) {
    for (AnimationController anim in animControllers)
      if (anim.status == AnimationStatus.forward) return;

    int length = widget.items.length;
    for (int i = 0; i < length; i++) {
      if (i == index) {
        if (animControllers[i].status == AnimationStatus.dismissed)
          animControllers[i].forward();
      } else {
        if (animControllers[i].status == AnimationStatus.completed)
          animControllers[i].reverse();
      }
    }
  }

  ColorFilter colorScale(double diag, double off_diag) {
    return ColorFilter.matrix(<double>[
      diag,
      off_diag,
      off_diag,
      0,
      0,
      off_diag,
      diag,
      off_diag,
      0,
      0,
      off_diag,
      off_diag,
      diag,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
  }

  @override
  void dispose() {
    for (AnimationController anim in animControllers) anim.dispose();

    super.dispose();
  }
}
