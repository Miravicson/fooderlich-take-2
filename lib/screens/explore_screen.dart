import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/models/explore_data.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final mockService = MockFooderlichService();

  late final ScrollController _scrollController;

  void scrollListener() {
    bool isAtEdge = _scrollController.position.atEdge;
    if (isAtEdge) {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        log("I am at the bottom");
      } else {
        log("I am at the top");
      }
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    futureBuilder(context, AsyncSnapshot<ExploreData> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final recipes = snapshot.data?.todayRecipes ?? [];

        return ListView(
          scrollDirection: Axis.vertical,
          controller: _scrollController,
          children: [
            TodayRecipeListView(
              recipes: recipes,
            ),
            const SizedBox(
              height: 16,
            ),
            FriendPostListView(
              friendPosts: snapshot.data?.friendPosts ?? [],
            ),
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    }

    return FutureBuilder(
      future: mockService.getExploreData(),
      builder: futureBuilder,
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    super.dispose();
  }
}
