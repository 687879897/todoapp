import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo1/prvider/language_provider.dart';
import 'package:todo1/prvider/providerhtem.dart';


import '../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({Key? key}) : super(key: key);
  static const String routeName = "setting";

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  String language = "English";
  String mode = "light";
  late Settingprovider provider;
  late Themprovider themprovider;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      language = prefs.getString('language') ?? "English";
      mode = prefs.getString('mode') ?? "light";
    });
  }

  Future<void> savePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
    prefs.setString('mode', mode);
  }

  Future<void> changeAppSettings() async {
    await savePreferences();
    provider.setcurrentlocal(language == "English" ? 'en' : 'ar');
    themprovider.setcurrentmode(
      mode == "Light" ? ThemeMode.light : ThemeMode.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    themprovider = Provider.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30, top: 30, right: 30),
          child: Text(
            AppLocalizations.of(context)!.language,
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          margin: const EdgeInsets.all(25),
          height: 57,
          width: MediaQuery.of(context)!.size.width * .2,
          decoration: BoxDecoration(
            border: Border.all(color: app_colors.primarycolor),
            color: app_colors.white,
          ),
          padding: const EdgeInsets.only(left: 30, top: 2, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                language,
                textAlign: TextAlign.left,
                style: const TextStyle(color: app_colors.primarycolor),
              ),
              IconButton(
                onPressed: () {
                  viwebottomsheetlanguage();
                },
                icon: const Icon(Icons.arrow_drop_down),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Text(
            AppLocalizations.of(context)!.mode,
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          height: 57,
          margin: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            border: Border.all(color: app_colors.primarycolor),
            color: app_colors.white,
          ),
          padding: const EdgeInsets.only(left: 30, top: 2, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mode,
                textAlign: TextAlign.left,
                style: const TextStyle(color: app_colors.primarycolor),
              ),
              IconButton(
                onPressed: () {
                  viwebottomsheetmode();
                },
                icon: const Icon(Icons.arrow_drop_down),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void viwebottomsheetlanguage() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        side: BorderSide(width: 6),
      ),
      context: context,
      builder: (_) => Container(
        color: themprovider.colorbottomsheet(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    language = "English";
                    mode = "mode";
                    changeAppSettings();
                  });
                  Navigator.pop(context);
                },
                child:  Text("English", textAlign: TextAlign.left,style: TextStyle(color: themprovider.colorunselectclaender()),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    language = "العربيه";
                    mode = "الوضع";
                    changeAppSettings();
                  });
                  Navigator.pop(context);
                },
                child:  Text("العربيه", textAlign: TextAlign.left,style: TextStyle(color: themprovider.colorunselectclaender())),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void viwebottomsheetmode() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        side: BorderSide(width: 6),
      ),
      context: context,
      builder: (_) => Container(

        color: themprovider.colorbottomsheet(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    mode = "Light";
                    changeAppSettings();
                  });
                  Navigator.pop(context);
                },
                child: Text("light", textAlign: TextAlign.left,style: TextStyle(color: themprovider.colorunselectclaender())),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    mode = "Dark";
                    changeAppSettings();
                  });
                  Navigator.pop(context);
                },
                child: Text("Dark", textAlign: TextAlign.left,style: TextStyle(color: themprovider.colorunselectclaender())),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
