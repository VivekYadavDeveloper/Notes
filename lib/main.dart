import 'package:flutter/material.dart';
import 'package:notes/Screens/create_note.dart';
import 'package:notes/Screens/display_note.dart';
import 'package:notes/Themes/theme_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final isDark = sharedPreferences.getBool('isDark') ?? false;
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isDark});
  final bool isDark;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeModel>(
      create: (context) => ThemeModel(isDark),
      builder: (context, snapshot) {
        final setting = Provider.of<ThemeModel>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes',
          theme: setting.currentTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const Home(),
            '/CreateNote': (context) => const CreateNote(),
            '/ShowNote': (context) => const ShowNote(),
          },
        );
      },
    );
  }
}
