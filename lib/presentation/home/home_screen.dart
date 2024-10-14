import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/application/news_bloc.dart';
import 'package:news_app/core/const/app_const.dart';
import 'package:news_app/presentation/home/category_screen.dart';
import 'package:news_app/presentation/home/news_screen.dart';
import 'package:news_app/presentation/home/profile_screen.dart';
import 'package:news_app/presentation/home/save_news_screen.dart';
import 'package:news_app/presentation/home/widget/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String getGreetingMessage() {
      final hour = DateTime.now().hour;

      if (hour < 12) {
        return 'Good Morning! $kUserName';
      } else if (hour < 17) {
        return 'Good Afternoon! $kUserName';
      } else if (hour < 21) {
        return 'Good Evening! $kUserName';
      } else {
        return 'Good Night! $kUserName';
      }
    }

    return BlocProvider(
      create: (context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Widget> body = [
            NewsScreen(
              onTap: () {
                context.read<NewsCubit>().changeIndex(1);
              },
            ),
            const CategoryScreen(),
            const SaveNewsScreen(),
            const ProfileScreen(),
          ];
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: Text(
                getGreetingMessage(),
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: body[state.currentIndex],
            bottomNavigationBar: BottomNavBar(
              currentIndex: state.currentIndex,
              onTap: (v) {
                context.read<NewsCubit>().changeIndex(v);
              },
            ),
          );
        },
      ),
    );
  }
}
