import 'package:flutter/material.dart';
import 'package:mygit/models/experience.dart';
import 'package:mygit/utils/mycolors.dart';

class TimelineTile extends StatelessWidget {
  final Experience experience;

  TimelineTile({Key? key, required this.experience}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildMarker(experience.completed),
        SizedBox(height: 5),
        Text(
          experience.title,
          style: Theme.of(context).primaryTextTheme.headline2,
        ),
        SizedBox(height: 5),
        Text(experience.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.subtitle1),
      ],
    );
  }

  Container buildMarker(bool completed) {
    return Container(
      width: 15,
      height: 15,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: MyColors.textColor, width: 1),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: completed ? MyColors.textColor : null,
        ),
      ),
    );
  }
}
