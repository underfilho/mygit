import 'package:mygit/layouts/repository_item.dart';
import 'package:mygit/utils/enums.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mygit/models/repository.dart';
import 'package:mygit/utils/getapi.dart';
import 'package:mygit/utils/mycolors.dart';
import 'package:flutter/material.dart';

class RepositoryPage extends StatefulWidget {
  final Language language;

  const RepositoryPage({Key? key, required this.language}) : super(key: key);

  @override
  _RepositoryPageState createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  final GetApi getapi = GetApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            appBar(context),
            FutureBuilder<List<Repository>?>(
              future: getapi.getRepositories(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 90),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(MyColors.textColor),
                        ),
                      ),
                    ),
                  );
                }
                List<Repository> items = snapshot.data!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () => launchURL(items[index].url),
                        child: RepositoryItem(items[index]),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Icon(Icons.arrow_back_ios,
                  size: 24, color: MyColors.textColor),
            ),
          ),
          Container(width: 10),
          Text(
              widget.language == Language.pt_BR
                  ? 'Repositórios'
                  : 'Repositories',
              style: Theme.of(context).primaryTextTheme.headline1),
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
