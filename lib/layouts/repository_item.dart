import 'package:mygit/models/repository.dart';
import 'package:mygit/utils/const.dart';
import 'package:mygit/utils/mycolors.dart';
import 'package:flutter/material.dart';

class RepositoryItem extends StatelessWidget {
  final Repository repository;

  RepositoryItem(this.repository);

  @override
  Widget build(BuildContext context) {
    String url_icon = Const.icon[repository.language];

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(right: 25, left: 25, bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: myTheme.divider),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Icon(Icons.book, color: myTheme.textColor, size: 22),
              Container(width: 12),
              Text(repository.title,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline2
                      .copyWith(fontSize: 22)),
              Spacer(),
              (url_icon != null)
                  ? Image.asset(Const.icon[repository.language],
                      width: 25, height: 25)
                  : Container()
            ]),
            Container(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                repository.description,
                style: Theme.of(context)
                    .primaryTextTheme
                    .caption
                    .copyWith(fontSize: 14),
              ),
            ),
            Container(height: 10),
            Row(children: <Widget>[
              Icon(Icons.star_border, size: 18, color: myTheme.textColor),
              Container(width: 5),
              Text(
                repository.stars.toString(),
                style: TextStyle(color: myTheme.textColor),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
