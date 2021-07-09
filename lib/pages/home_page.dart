import 'package:mygit/layouts/carousel_list.dart';
import 'package:mygit/pages/repository_page.dart';
import 'package:mygit/models/profile.dart';
import 'package:mygit/utils/getapi.dart';
import 'package:mygit/utils/mycolors.dart';
import 'package:mygit/utils/const.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetApi getApi = GetApi();
  int id = 0;

  @override
  Widget build(BuildContext context) {
    final profile = getApi.getProfile();

    return Scaffold(
      body: Container(
        color: myTheme.background,
        height: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  appBar(),
                  body(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    height: 100,
                    child: CarouselList(
                      onTap: (index) => setState(() => id = index),
                      items: Const.images.map((url) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Image.asset(url, width: 60, height: 60),
                        );
                      }).toList(),
                    ),
                  ),
                  FutureBuilder(
                    future: profile,
                    builder: (context, snapshot) {
                      Profile profile = snapshot.data;

                      if (profile == null) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 90),
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(myTheme.textColor),
                            ),
                          ),
                        );
                      }

                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            child: AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: Text(profile.skills[id].title,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline1),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            child: Text(profile.skills[id].description,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .subtitle1),
                          ),
                          Container(height: 20)
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return Container(
      alignment: Alignment.bottomRight,
      margin: EdgeInsets.only(right: 20, top: 25),
      child: FloatingActionButton(
        backgroundColor: myTheme.accent,
        tooltip: "Meus Repositórios",
        child: Icon(Icons.code, color: myTheme.textColor),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RepositoryPage()));
        },
      ),
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage("https://i.imgur.com/6tKcSqt.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("Anderson Santos",
                    style: Theme.of(context).primaryTextTheme.headline1),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text("Desenvolvedor Mobile/Desktop",
                    style: Theme.of(context).primaryTextTheme.subtitle1),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            color: myTheme.divider,
            height: 0.5,
          )
        ],
      ),
    );
  }
}
