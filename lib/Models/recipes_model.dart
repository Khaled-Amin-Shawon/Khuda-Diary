import 'dart:convert';

import 'package:flutter/foundation.dart';

RecipesModel recipesModelFromJson(String str) => RecipesModel.fromJson(json.decode(str));

String recipesModelToJson(RecipesModel data) => json.encode(data.toJson());

class RecipesModel {
  List<Recipe> recipes;
  int total;
  int skip;
  int limit;

  RecipesModel({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory RecipesModel.fromJson(Map<String, dynamic> json) => RecipesModel(
        recipes: List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
        total: json["total"] ?? 0,
        skip: json["skip"] ?? 0,
        limit: json["limit"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Recipe {
  int id;
  String name;
  List<String> ingredients;
  List<String> instructions;
  int prepTimeMinutes;
  int cookTimeMinutes;
  int servings;
  Difficulty difficulty;
  String cuisine;
  int caloriesPerServing;
  List<String> tags;
  int userId;
  String image; // Nullable
  double rating; // Nullable
  int reviewCount;
  List<String> mealType;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating, // Nullable
    required this.reviewCount,
    required this.mealType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    try {
      return Recipe(
        id: json["id"],
        name: json["name"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        instructions: List<String>.from(json["instructions"].map((x) => x)),
        prepTimeMinutes: json["prepTimeMinutes"] ?? 0,
        cookTimeMinutes: json["cookTimeMinutes"] ?? 0,
        servings: json["servings"] ?? 0,
        difficulty: difficultyValues.map[json["difficulty"]] ?? Difficulty.EASY,
        cuisine: json["cuisine"] ?? "Unknown",
        caloriesPerServing: json["caloriesPerServing"] ?? 0,
        tags: List<String>.from(json["tags"].map((x) => x)),
        userId: json["userId"] ?? 0,
        image: json["image"],
        rating: json["rating"]?.toDouble(),
        reviewCount: json["reviewCount"] ?? 0,
        mealType: List<String>.from(json["mealType"].map((x) => x)),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Error parsing recipe: $e");
      }
      rethrow; // Optional: rethrow or handle gracefully
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "instructions": List<dynamic>.from(instructions.map((x) => x)),
        "prepTimeMinutes": prepTimeMinutes,
        "cookTimeMinutes": cookTimeMinutes,
        "servings": servings,
        "difficulty": difficultyValues.reverse[difficulty],
        "cuisine": cuisine,
        "caloriesPerServing": caloriesPerServing,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "userId": userId,
        "image": image,
        "rating": rating,
        "reviewCount": reviewCount,
        "mealType": List<dynamic>.from(mealType.map((x) => x)),
      };
}

enum Difficulty { EASY, MEDIUM }

final difficultyValues = EnumValues({
  "Easy": Difficulty.EASY,
  "Medium": Difficulty.MEDIUM,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
