// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO continues the about page

class AboutPage extends StatelessWidget {
  const AboutPage({
    Key? key,
    required this.pathE,
  }) : super(key: key);

  final String pathE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.about)),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(
                AppLocalizations.of(context)!.helloWorld,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.one_thankYou,
                style: TextStyle(
                  fontSize: 18,
                  wordSpacing: 5,
                  letterSpacing: 1,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
                textAlign: TextAlign.justify,
              ),
              const Divider(),
              Text(
                AppLocalizations.of(context)!.whyDisApp,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.two_whydisapp,
                style: TextStyle(
                  fontSize: 18,
                  wordSpacing: 5,
                  letterSpacing: 1,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
                textAlign: TextAlign.justify,
              ),
              const Divider(),
              Text(
                AppLocalizations.of(context)!.howItWorks,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.three_howworks,
                style: TextStyle(
                  fontSize: 18,
                  wordSpacing: 5,
                  letterSpacing: 1,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
                textAlign: TextAlign.justify,
              ),
              const Divider(),
              Text(
                pathE,
                style: TextStyle(
                  fontSize: 18,
                  wordSpacing: 5,
                  letterSpacing: 1,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
                textAlign: TextAlign.justify,
              ),
              const Divider(),
              Text(
                AppLocalizations.of(context)!.tips,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.four_tips,
                style: TextStyle(
                  fontSize: 18,
                  wordSpacing: 5,
                  color: Theme.of(context).textTheme.caption?.color,
                  letterSpacing: 1,
                ),
                textAlign: TextAlign.justify,
              ),
              const Divider(),
              Text(
                AppLocalizations.of(context)!.goodThings,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.five_goodThings,
                style: TextStyle(
                  fontSize: 18,
                  wordSpacing: 5,
                  letterSpacing: 1,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                AppLocalizations.of(context)!.sources,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              InkWell(
                child: Text(
                  "Happy project : 3 good things",
                  style: Theme.of(context).textTheme.caption,
                ),
                onTap: () =>
                    launch("https://happyproject.in/three-good-things/"),
              ),
              InkWell(
                child: Text(
                  "Dr. J. Bryan Sexton - Three Good Things",
                  style: Theme.of(context).textTheme.caption,
                ),
                onTap: () =>
                    launch("https://www.youtube.com/watch?v=hZ4aT_RVHCs"),
              ),
              InkWell(
                child: Text(
                  "Dr. Seligman : Three Good Things",
                  style: Theme.of(context).textTheme.caption,
                ),
                onTap: () =>
                    launch("https://www.youtube.com/watch?v=ZOGAp9dw8Ac"),
              ),
              const Divider(),
              Text(
                AppLocalizations.of(context)!.credits,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                AppLocalizations.of(context)!.t_credits,
                style: TextStyle(
                  fontSize: 18,
                  wordSpacing: 5,
                  letterSpacing: 1,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ));
  }
}
