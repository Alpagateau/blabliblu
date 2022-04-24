// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO continues the about page

class AboutPage extends StatelessWidget {
  const AboutPage({
    Key? key,
    required this.pathE,
  }) : super(key: key);

  final String pathE;

  @override
  Widget build(BuildContext context) {
    String a = "hello";
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(title: const Text("About")),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(
                "Hello world",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                "\n    Hi, thanks for using this app! It's a joy to know that my app can be useful to someone. \n",
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
                "Why this app ?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                "\n    This application was created to help people who feel bad to get better. The idea came from an advice given by a friend when I was feeling bad. She told me to write down every night three things that made me smile during the day. After doing this for about two months, I decided to create this application to help people apply this advice. It also served as my first project to learn how to code applications for the general public. \n",
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
                "How does it work ?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                "\n    Every day, you'll receive a notification to remind you to write down the things that made you smile. Only one notification per day is sent. (you can disable them in the settings). When you enter information in the fields provided, the content is saved in a file of your own on your phone. Nothing is sent to anyone. Everything happens on your phone, in private. When you open the Diary, the file is opened and displayed in a convenient way. ",
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
                "Some tips",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                "\n    So, from my view, you sould try to be as precise as possible while writing, it will make the text longer and may force you to use multiple cells, at the end, when you'll look back at it, it would seems like u did more work !!",
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
                "Three good things ?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                "\n    The \"3 good things\" principle is an idea that allows us to focus on the positive. It has been used in particular for health care workers in order to combat possible depression",
                style: TextStyle(
                  fontSize: 18,
                  wordSpacing: 5,
                  letterSpacing: 1,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
                textAlign: TextAlign.justify,
              ),
              Text(
                "Sources : ",
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
                "Credits",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Theme.of(context).textTheme.caption?.color,
                ),
              ),
              Text(
                "\n    The code was mainly made by Martin Nadaud (Alpagateau), but helped by the contributors on github. The icon was made by Marie Perrier (@art_with_marie)",
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
