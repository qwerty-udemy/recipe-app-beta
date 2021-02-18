import 'package:final_year_project/models/recipe_bundle.dart';
import 'package:final_year_project/screens/home/components_home/recipe_bundle_card.dart';
import 'package:final_year_project/screens/home/components_home/categories.dart';
import 'package:final_year_project/shared/constants/xScreenSize.dart';
import 'package:flutter/material.dart';

class BodyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Categories(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConfig.defaultSize * 2),
              child: GridView.builder(
                itemCount: recipeBundles.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: SizeConfig.orientation == Orientation.landscape ? 2 : 1,
                  crossAxisSpacing: SizeConfig.orientation == Orientation.landscape ? SizeConfig.defaultSize * 2 : 0,
                  childAspectRatio: 1.65,
                ),
                itemBuilder: (context, index) => RecipeBundleCard(
                  recipeBundle: recipeBundles[index],
                  press: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
