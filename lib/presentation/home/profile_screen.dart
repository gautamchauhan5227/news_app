import 'package:flutter/material.dart';
import 'package:news_app/core/const/app_const.dart';
import 'package:news_app/core/const/string_const.dart';
import 'package:news_app/core/utils/theme_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 40,
            child: Icon(
              Icons.person_rounded,
              size: 50,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            kUserName,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                StringConst.themeChange,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
