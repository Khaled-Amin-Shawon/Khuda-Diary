import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:khuda_diary/Models/recipes_model.dart';
import 'package:khuda_diary/Pages/details_screen.dart';
import 'package:khuda_diary/Services/services.dart';
import 'package:khuda_diary/main.dart';

class RecipesHomeScreen extends StatefulWidget {
  const RecipesHomeScreen({super.key});

  @override
  State<RecipesHomeScreen> createState() => _RecipesHomeScreenState();
}

class _RecipesHomeScreenState extends State<RecipesHomeScreen> {
  List<Recipe> recipesModel = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    myRecipes(); // Call to fetch recipes on screen load
  }

  void myRecipes() {
    setState(() {
      isLoading = true;
    });
    recipesItem().then(
      (value) {
        setState(() {
          recipesModel = value;
          isLoading = false;
        });
      },
    ).catchError((error) {
      setState(() {
        isLoading = false;
      });
      // Log error or show a SnackBar/AlertDialog
      if (kDebugMode) {
        print("Error fetching recipes: $error");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Khuda Diary",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              themeNotifier.value == ThemeMode.light
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              setState(() {
                themeNotifier.value = themeNotifier.value == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              });
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : recipesModel.isEmpty
              ? const Center(
                  child: Text(
                    "No recipes found!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : ListView.builder(
                  itemCount: recipesModel.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final recipe = recipesModel[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: size.height * 0.02,
                        horizontal: size.width * 0.05,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(recipe: recipe),
                            ),
                          );
                        },
                        child: RecipeCard(size: size, recipe: recipe),
                      ),
                    );
                  },
                ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.size,
    required this.recipe,
  });

  final Size size;
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(recipe.image),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2.0,
                blurRadius: 10.0,
                offset: const Offset(-5, 7),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            height: size.height * 0.07,
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          recipe.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Text(
                        "Difficulty : " +
                            (recipe.difficulty == Difficulty.EASY
                                ? "Easy"
                                : "Medium"),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.restaurant, color: Colors.white),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            recipe.cuisine,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.star, color: Colors.yellow),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            recipe.rating.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
