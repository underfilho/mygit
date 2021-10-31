import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class CarouselList extends StatefulWidget {
  final List<Widget> items;
  final Function(int) onTap;

  CarouselList({required this.items, required this.onTap});

  @override
  _CarouselListState createState() => _CarouselListState();
}

class _CarouselListState extends State<CarouselList>
    with TickerProviderStateMixin {
  List<AnimationController> animControllers = [];
  List<Animation> curves = [];

  @override
  void initState() {
    super.initState();

    int length = widget.items.length;
    for (int i = 0; i < length; i++) {
      animControllers.add(AnimationController(
          duration: Duration(milliseconds: 200), vsync: this));
      curves.add(
          CurvedAnimation(parent: animControllers[i], curve: Curves.easeInOut));
    }

    animControllers[0].forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollSnapList(
      itemSize: 100,
      dynamicItemSize: true,
      itemCount: widget.items.length,
      onItemFocus: (id) {
        setAnimation(id);
        widget.onTap(id);
      },
      itemBuilder: (_, index) {
        return AnimatedBuilder(
          animation: curves[index],
          builder: (_, child) {
            return ColorFiltered(
              colorFilter: colorScale(0.5 + curves[index].value * 0.5,
                  0.5 - curves[index].value * 0.5),
              child: widget.items[index],
            );
          },
        );
      },
    );
  }

  void setAnimation(int index) {
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
}
