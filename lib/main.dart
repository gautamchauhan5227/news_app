import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:isar/isar.dart';
import 'package:news_app/core/local_model/article_model.dart';
import 'package:news_app/core/utils/theme_provider.dart';
import 'package:news_app/presentation/onboarding/splash_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

late final Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [ArticleModelSchema],
    directory: dir.path,
  );
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: const NewsApp(),
  ));
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: theme.themeMode,
      home: const SplashScreen(),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.poppinsTextTheme(),
      iconTheme: const IconThemeData(color: Colors.black),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: const Color(0xFF121212), // Dark background
      textTheme: GoogleFonts.poppinsTextTheme(
        const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F1F1F), // Dark app bar
        iconTheme: IconThemeData(color: Colors.white),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Color(0xFF1F1F1F),
      ),
    );
  }
}
