import 'package:flutter/material.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/models/models.dart';

class TodayRecipeListView extends StatelessWidget {
  final List<ExploreRecipe> recipes;

  const TodayRecipeListView({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    listViewItemBuilder(BuildContext context, int index) {
      final recipe = recipes[index];
      return buildCard(recipe);
    }

    listViewSeparatorBuilder(BuildContext context, int index) {
      return const SizedBox(
        width: 16,
      );
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recipes of the Day 🍳',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 400,
            color: Colors.transparent,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recipes.length,
              itemBuilder: listViewItemBuilder,
              separatorBuilder: listViewSeparatorBuilder,
            ),
          )
        ],
      ),
    );
  }

  Widget buildCard(ExploreRecipe recipe) {
    if (recipe.cardType == RecipeCardType.card1) {
      return Card1(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card2) {
      return Card2(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card3) {
      return Card3(recipe: recipe);
    } else {
      throw Exception('This card doesn\'t exist yet');
    }
  }
}
