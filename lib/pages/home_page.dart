import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mygit/layouts/carousel_list.dart';
import 'package:mygit/pages/repository_page.dart';
import 'package:mygit/models/skill.dart';
import 'package:mygit/models/profile.dart';
import 'package:mygit/utils/getapi.dart';
import 'package:mygit/utils/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetApi getApi = GetApi();
  int id = 0;
  late final profileFuture;

  @override
  void initState() {
    super.initState();
    profileFuture = getApi.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: myTheme.background,
        height: double.infinity,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: constraints.copyWith(
                    maxWidth: 800,
                    minHeight: constraints.maxHeight,
                    maxHeight: double.infinity,
                  ),
                  child: FutureBuilder(
                    future: profileFuture,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
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
                      Profile profileInfo = snapshot.data as Profile;

                      return buildLayout(profileInfo);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLayout(Profile profileInfo) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          appBar(),
          profile(profileInfo.function),
          divider(),
          body(profileInfo),
          Container(height: 25),
          Expanded(child: footer()),
          Container(height: 35),
        ],
      ),
    );
  }

  List<Widget> skillsIcon(List<Skill> skills) {
    List<Widget> icons = [];

    for (var skill in skills) {
      Widget icon = Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Image.network(skill.urlIcon, width: 60, height: 60),
      );
      icons.add(icon);
    }

    return icons;
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

  Widget profile(String function) {
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
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.headline1),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Text(function,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.subtitle1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget body(Profile profileInfo) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: 20, vertical: 10),
            height: 100,
            child: CarouselList(
              onTap: (index) => setState(() => id = index),
              items: skillsIcon(profileInfo.skills),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Text(profileInfo.skills[id].title,
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline1),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
                horizontal: 40, vertical: 15),
            child: Text(profileInfo.skills[id].description,
                style: Theme.of(context)
                    .primaryTextTheme
                    .subtitle1),
          ),
        ],
      ),
    );
  }
  
  Widget divider() {
    return Container(
      margin: EdgeInsets.only(top: 30, right: 30, left: 30),
      color: myTheme.divider,
      height: 0.5,
    );
  }

  Widget footer() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => launchURL('https://github.com/underfilho'),
            child: FaIcon(FontAwesomeIcons.github, color: Colors.white, size: 24),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () => launchURL('https://linkedin.com/in/underfilho'),
            child: FaIcon(FontAwesomeIcons.linkedin, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      throw 'Could not launch $url';
  }
}
