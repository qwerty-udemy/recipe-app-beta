import 'package:final_year_project/models/recipe_bundle.dart';
import 'package:final_year_project/shared/constants/xScreenSize.dart';
import 'package:flutter/material.dart';

class RecipeBundleCard extends StatelessWidget {
  final RecipeBundle recipeBundle;
  final Function press;

  const RecipeBundleCard({Key key, this.recipeBundle, this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: recipeBundle.color,
          borderRadius: BorderRadius.circular(defaultSize * 1.8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(defaultSize * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Text(
                      recipeBundle.title,
                      style: TextStyle(
                        fontSize: defaultSize * 2.2,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: defaultSize * 0.5,
                    ),
                    Text(
                      recipeBundle.description,
                      style: TextStyle(color: Colors.white54),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    buildInfoRow(
                      defaultSize,
                      icon: Icons.fastfood_rounded,
                      text: '${recipeBundle.recipes} Recipes',
                    ),
                    SizedBox(
                      height: defaultSize * 0.5,
                    ),
                    buildInfoRow(
                      defaultSize,
                      icon: Icons.person_pin_circle_rounded,
                      text: '${recipeBundle.chefs} Chefs',
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: defaultSize * 0.5,
            ),
            AspectRatio(
              aspectRatio: 0.71,
              child: Image.asset(
                recipeBundle.imageSrc,
                fit: BoxFit.cover,
                alignment: Alignment.centerLeft,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildInfoRow(double defaultSize, {IconData icon, String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        SizedBox(
          width: defaultSize,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
