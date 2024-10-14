import 'package:flutter/material.dart';
import 'package:news_app/core/const/string_const.dart';

class BottomNavBar extends StatelessWidget {
  final Function(int index) onTap;
  final int currentIndex;

  const BottomNavBar({
    super.key,
    required this.onTap,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.maxFinite,
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavBarItem(
            isSelected: 0 == currentIndex,
            icon: Icons.home_rounded,
            iconTitle: StringConst.home,
            onTap: () {
              onTap(0);
            },
          ),
          BottomNavBarItem(
            isSelected: 1 == currentIndex,
            icon: Icons.category_rounded,
            iconTitle: StringConst.category,
            onTap: () {
              onTap(1);
            },
          ),
          BottomNavBarItem(
            isSelected: 2 == currentIndex,
            icon: Icons.bookmark_add_rounded,
            iconTitle: StringConst.save,
            onTap: () {
              onTap(2);
            },
          ),
          BottomNavBarItem(
            isSelected: 3 == currentIndex,
            icon: Icons.person_rounded,
            iconTitle: StringConst.profile,
            onTap: () {
              onTap(3);
            },
          ),
        ],
      ),
    );
  }
}

class BottomNavBarItem extends StatelessWidget {
  final IconData icon;
  final String iconTitle;
  final Function() onTap;
  final bool isSelected;

  const BottomNavBarItem({
    super.key,
    required this.icon,
    required this.iconTitle,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColor.withOpacity(0.5);
    final textColor = isSelected
        ? Theme.of(context).primaryColor
        : Theme.of(context).primaryColor.withOpacity(0.5);

    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Icon(
              icon,
              color: iconColor,
            ),
            const SizedBox(height: 6),
            Text(
              iconTitle,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
