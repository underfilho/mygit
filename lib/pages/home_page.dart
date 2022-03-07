import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mygit/layouts/carousel_list.dart';
import 'package:mygit/layouts/timeline_tile.dart';
import 'package:mygit/models/experience.dart';
import 'package:mygit/pages/repository_page.dart';
import 'package:mygit/models/skill.dart';
import 'package:mygit/models/profile.dart';
import 'package:mygit/utils/const.dart';
import 'package:mygit/utils/getapi.dart';
import 'package:mygit/utils/mycolors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GetApi getApi = GetApi();
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
        color: MyColors.background,
        height: double.infinity,
        child: SafeArea(
          child: Stack(
            children: [
              LayoutBuilder(
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
                                  valueColor: AlwaysStoppedAnimation(
                                      MyColors.textColor),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.1, 0.8],
                      colors: [
                        MyColors.accent,
                        MyColors.background.withOpacity(0.5),
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  height: 50,
                  child: footer(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLayout(Profile profileInfo) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        appBar(),
        profile(profileInfo.profilePic, profileInfo.function),
        divider(),
        body(profileInfo.skills),
        SizedBox(height: 100),
      ],
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
      child: FloatingActionButton.extended(
        backgroundColor: MyColors.accent,
        tooltip: "Meus Repositórios",
        label: Icon(Icons.code, color: MyColors.textColor),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RepositoryPage()));
        },
      ),
    );
  }

  Widget profile(String urlImg, String function) {
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
                image: NetworkImage(urlImg),
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

  Widget body(List<Skill> skills) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 100,
            child: CarouselList(
              onTap: (index) => setState(() => id = index),
              items: skillsIcon(skills),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Text(skills[id].title,
                style: Theme.of(context).primaryTextTheme.headline1),
          ),
          experiences(skills[id].experiences),
          /*Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            child: Text(skills[id].description,
                style: Theme.of(context).primaryTextTheme.subtitle1),
          ),*/
        ],
      ),
    );
  }

  Widget experiences(List<Experience> experiences) {
    return Column(
      children: experiences.map(
        (e) {
          return Padding(
            padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
            child: TimelineTile(experience: e),
          );
        },
      ).toList(),
    );
  }

  Widget divider() {
    return Container(
      margin: EdgeInsets.only(top: 30, right: 30, left: 30),
      color: MyColors.divider,
      height: 0.5,
    );
  }

  Widget footer() {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => launchURL('https://github.com/underfilho'),
            child:
                FaIcon(FontAwesomeIcons.github, color: Colors.white, size: 24),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () => launchURL('https://linkedin.com/in/underfilho'),
            child: FaIcon(FontAwesomeIcons.linkedin,
                color: Colors.white, size: 24),
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
