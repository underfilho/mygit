import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mygit/models/experience.dart';
import 'package:mygit/utils/mycolors.dart';
import 'package:url_launcher/url_launcher.dart';

class TimelineTile extends StatelessWidget {
  final Experience experience;

  TimelineTile({Key? key, required this.experience}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildMarker(experience.icon, experience.typeString),
        SizedBox(height: 10),
        Text(
          experience.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).primaryTextTheme.headline2,
        ),
        SizedBox(height: 5),
        buildDescription(
          description: divideString(experience.description),
          style: Theme.of(context).primaryTextTheme.subtitle1,
          linkStyle: Theme.of(context)
              .primaryTextTheme
              .subtitle1
              ?.copyWith(color: Colors.blue),
        ),
      ],
    );
  }

  Widget buildMarker(IconData icon, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 15,
        height: 15,
        padding: EdgeInsets.all(3),
        child: Icon(icon, color: MyColors.textColor, size: 18),
      ),
    );
  }

  RichText buildDescription(
      {required List<String> description,
      TextStyle? style,
      TextStyle? linkStyle}) {
    List<TextSpan> content = [];

    description.asMap().forEach((i, e) {
      final text = e.split(';');
      final isEven = i % 2 == 0;
      final tapRecognizer = TapGestureRecognizer()
        ..onTap = () => launchURL(text[1]);

      var textSpan = TextSpan(
        text: text[0],
        style: isEven ? style : linkStyle,
        recognizer: !isEven ? tapRecognizer : null,
      );

      content.add(textSpan);
    });

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: style,
        children: content,
      ),
    );
  }

  List<String> divideString(String text) {
    final result = text.split(RegExp("<|\\>"));
    return result;
  }

  launchURL(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      throw 'Could not launch $url';
  }
}
