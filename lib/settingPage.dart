part of homePage;

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, required this.storage, required this.home})
      : super(key: key);

  CounterStorage storage;
  _MyHomePageState home;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: (widget.home.forceMode)
          ? ((widget.home.darkMode) ? themes.DarkTheme : themes.MainTheme)
          : Theme.of(context),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.diary,
              style: Theme.of(context).textTheme.headline2),
        ),
        body: Theme(
          data: (widget.home.forceMode)
              ? ((widget.home.darkMode) ? themes.DarkTheme : themes.MainTheme)
              : Theme.of(context),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(4, 16, 4, 0),
                child: Text(
                  AppLocalizations.of(context)!.momorySettings,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  widget.storage.writeCounter("{\"Memory\":[{}");
                  widget.home.inFile = "{\"Memory\":[{}";
                  // ignore: avoid_print
                  print('or');
                },
                child: Text(
                  AppLocalizations.of(context)!.deleteMemory,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              TextButton(
                  onPressed: () {
                    print(Theme.of(context).backgroundColor);
                  },
                  child: Text(
                    "TEST",
                    style: TextStyle(fontSize: 18),
                  )),
              TextButton(
                  onPressed: () {
                    widget.home.resetCounter();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.resetMemoryLen,
                    style: TextStyle(fontSize: 18),
                  )),
              //Notifs
              Padding(
                padding: EdgeInsets.fromLTRB(4, 16, 4, 0),
                child: Text(
                  AppLocalizations.of(context)!.appSettings,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(),

              DropdownButton<String>(
                value:
                    widget.home.PossiblesLanguages[widget.home.languageSetting],
                items: widget.home.PossiblesLanguages
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    final choosen =
                        widget.home.PossiblesLanguages.indexOf(value!);
                    widget.home.languageSetting = choosen;
                    SharedPreferences.getInstance().then((value) {
                      value.setInt("langS", choosen);
                    });
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  AppLocalizations.of(context)!.animSlow,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                value: timeDilation != 1.0,
                onChanged: (bool? value) {
                  setState(() {
                    timeDilation = value! ? 3.0 : 1.0;
                  });
                },
                secondary: Icon(
                  Icons.hourglass_empty,
                  color: Theme.of(context).textTheme.subtitle1?.color,
                ),
              ),
              CheckboxListTile(
                title: Text(
                  AppLocalizations.of(context)!.showMemContentDebug,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                value: widget.home.showContent,
                onChanged: (bool? value) {
                  setState(() {
                    widget.home.showContent = value! ? true : false;
                    SharedPreferences.getInstance().then((value) {
                      value.setBool("contentS", widget.home.showContent);
                    });
                  });
                },
                secondary: Icon(
                  Icons.text_fields,
                  color: Theme.of(context).textTheme.subtitle1?.color,
                ),
              ),

              //Dark mode settings
              CheckboxListTile(
                title: Text(
                  AppLocalizations.of(context)!.showMemContentDebug,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                value: widget.home.forceMode,
                onChanged: (bool? value) {
                  setState(() {
                    widget.home.forceMode = value! ? true : false;
                    SharedPreferences.getInstance().then((value) {
                      value.setBool("forcemode", widget.home.forceMode);
                    });
                  });
                },
                secondary: Icon(
                  Icons.light_mode,
                  color: Theme.of(context).textTheme.subtitle1?.color,
                ),
              ),
              Visibility(
                visible: widget.home.forceMode,
                child: CheckboxListTile(
                  title: Text(
                    AppLocalizations.of(context)!.showMemContentDebug,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  value: widget.home.darkMode,
                  onChanged: (bool? value) {
                    setState(() {
                      widget.home.darkMode = value! ? true : false;
                      SharedPreferences.getInstance().then((value) {
                        value.setBool("darkmode", widget.home.darkMode);
                      });
                    });
                  },
                  secondary: Icon(
                    Icons.dark_mode,
                    color: Theme.of(context).textTheme.subtitle1?.color,
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.fromLTRB(4, 16, 4, 0),
                child: Text(
                  AppLocalizations.of(context)!.notifSettings,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(),
              const Divider(),
              CheckboxListTile(
                title: Text(
                  AppLocalizations.of(context)!.sendNotif,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                value: widget.home.schedulNotifs,
                onChanged: (bool? value) {
                  setState(() {
                    widget.home.schedulNotifs = value! ? true : false;

                    SharedPreferences.getInstance().then((value) {
                      value.setBool("notifs", widget.home.schedulNotifs);
                    });

                    if (!widget.home.schedulNotifs) {
                      cancelScheduledNotifications();
                    } else {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then((TimeOfDay? value) {
                        createReminderNotification(
                            1, value!.hour, value.minute);
                        createReminderNotification(2, value.hour, value.minute);
                        createReminderNotification(3, value.hour, value.minute);
                        createReminderNotification(4, value.hour, value.minute);
                        createReminderNotification(5, value.hour, value.minute);
                        createReminderNotification(6, value.hour, value.minute);
                        createReminderNotification(7, value.hour, value.minute);
                      });
                    }
                  });
                },
                secondary: Icon(
                  Icons.ad_units,
                  color: Theme.of(context).textTheme.subtitle1?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
