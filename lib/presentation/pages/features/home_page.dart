import 'package:WeChat/configs/app_theme.dart';
import 'package:WeChat/presentation/components/text_editing/search_field.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            height: 135,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchArea(
                    controller: searchController,
                    hintText: 'Type W-Tag of user...',
                    onTap: () {},
                  ),
                )
                // const SizedBox(
                //     height: 20),
                // const TabBar(
                //   labelColor: Colors.white,
                //   unselectedLabelColor: Colors.grey,
                //   indicatorColor: Colors.white,
                //   tabs: [
                //     Tab(text: 'Chats'),
                //     Tab(text: 'Groups'),
                //     Tab(text: 'News'),
                //   ],
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
