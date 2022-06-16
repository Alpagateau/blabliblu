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
  // That's dirty af and don't even really work but I'll let you do the state saving thing

  @override
  Widget build(BuildContext context) {
    print(Get.theme.backgroundColor);
    ThemeMode _themeMode = (widget.home.themeS == 0)
        ? ThemeMode.system
        : (widget.home.themeS == 1 ? ThemeMode.light : ThemeMode.dark);

    ThemeData theme = ((widget.home.themeS == 0)
        ? Get.theme
        : (widget.home.themeS == 1 ? themes.MainTheme : themes.DarkTheme));

    bool darkMode = _themeMode == ThemeMode.dark;
    return Theme(
        data: theme,
        child: Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.options,
                style: theme.textTheme.headline2),
          ),
          body: ListView(
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

              CheckboxListTile(
                title: Text(
                  AppLocalizations.of(context)!.animSlow,
                  style: theme.textTheme.subtitle1,
                ),
                value: timeDilation != 1.0,
                onChanged: (bool? value) {
                  setState(() {
                    timeDilation = value! ? 3.0 : 1.0;
                  });
                },
                secondary: Icon(
                  Icons.hourglass_empty,
                  color: theme.textTheme.subtitle1?.color,
                ),
              ),

              CheckboxListTile(
                title: Text(
                  AppLocalizations.of(context)!.showMemContentDebug,
                  style: theme.textTheme.subtitle1,
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
                  color: theme.textTheme.subtitle1?.color,
                ),
              ),
              //Dark mode settings
              CheckboxListTile(
                title: Text(
                  AppLocalizations.of(context)!.systemTheme,
                  style: theme.textTheme.subtitle1,
                ),
                value: widget.home.themeS == 0,
                onChanged: (bool? value) {
                  setState(() {
                    _themeMode = ThemeMode.system;
                    Get.changeThemeMode(ThemeMode.system);
                    widget.home.themeS = (widget.home.themeS == 0)
                        ? (Get.isDarkMode ? 2 : 1)
                        : 0;
                    SharedPreferences.getInstance().then((value) {
                      value.setInt("themeS", widget.home.themeS);
                    });
                  });
                },
                secondary: Icon(
                  Icons.account_circle,
                  color: theme.textTheme.subtitle1?.color,
                ),
              ),
              Visibility(
                visible: widget.home.themeS != 0,
                child: SwitchListTile(
                  title: Text(
                    (widget.home.themeS == 1)
                        ? AppLocalizations.of(context)!.lightTheme
                        : AppLocalizations.of(context)!.darkTheme,
                    style: theme.textTheme.subtitle1,
                  ),
                  value: _themeMode == ThemeMode.dark,
                  onChanged: (bool? value) {
                    setState(() {
                      if (widget.home.themeS == 1) {
                        _themeMode = ThemeMode.dark;
                        Get.changeThemeMode(ThemeMode.dark);
                        widget.home.themeS = 2;
                      } else {
                        _themeMode = ThemeMode.light;
                        Get.changeThemeMode(ThemeMode.light);
                        widget.home.themeS = 1;
                      }

                      SharedPreferences.getInstance().then((value) {
                        value.setInt("themeS", widget.home.themeS);
                      });
                    });
                  },
                  secondary: Icon(
                    _themeMode == ThemeMode.dark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: theme.textTheme.subtitle1?.color,
                  ),
                ),
              ),
/*
              ListTile(
                leading: Icon(
                  Icons.language,
                  color: theme.textTheme.subtitle1?.color,
                ),
                title: DropdownButton<String>(
                  value: widget
                      .home.PossiblesLanguages[widget.home.languageSetting],
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
                  elevation: 0,
                ),
              ),
*/
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
              CheckboxListTile(
                title: Text(
                  AppLocalizations.of(context)!.sendNotif,
                  style: theme.textTheme.subtitle1,
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
                  color: theme.textTheme.subtitle1?.color,
                ),
              ),
            ],
          ),
        ));
  }
}
