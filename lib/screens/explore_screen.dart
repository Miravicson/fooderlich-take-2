import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/models/explore_data.dart';

class ExploreScreen extends StatelessWidget {
  final mockService = MockFooderlichService();

  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    futureBuilder(context, AsyncSnapshot<ExploreData> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final recipes = snapshot.data?.todayRecipes ?? [];

        return ListView(
          scrollDirection: Axis.vertical,
          children: [
            TodayRecipeListView(
              recipes: recipes,
            ),
            const SizedBox(
              height: 16,
            ),
            // TODO: Replace this with FriendPostListView
            Container(
              height: 400,
              color: Colors.green,
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
}
