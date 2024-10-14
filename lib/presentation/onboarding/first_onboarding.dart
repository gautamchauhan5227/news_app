import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/core/const/app_const.dart';
import 'package:news_app/core/const/string_const.dart';
import 'package:news_app/presentation/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstOnboarding extends StatelessWidget {
  FirstOnboarding({super.key});

  final TextEditingController _controller = TextEditingController();

  // Method to save name to SharedPreferences
  Future<void> _saveName(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final name = _controller.text.trim();

    // Check if the name contains only alphabets
    if (RegExp(r'^[a-zA-Z]+$').hasMatch(name)) {
      await prefs.setString('name', name);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Name saved: $name')),
      );
      kUserName = name;
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid name (alphabets only)')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? Colors.grey[200]
                    : Colors.grey[800],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TextField(
                controller: _controller,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^[a-zA-Z]*$'),
                  ),
                ],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveName(context),
              child: const Text(StringConst.saveName),
            ),
          ],
        ),
      ),
    );
  }
}
