import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/models/explore_data.dart';

class ExploreScreen extends StatelessWidget {
  final mockService = MockFooderlichService();

  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    futureBuilder(context, AsyncSnapshot<ExploreData> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final recipes = snapshot.data?.todayRecipes ?? [];
        // TODO: Replace this with TodayRecipeListView

        return Center(
          child: Container(
            child: const Text('Show TodayRecipeListView'),
          ),
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
