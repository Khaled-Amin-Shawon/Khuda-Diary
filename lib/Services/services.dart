import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:khuda_diary/Models/recipes_model.dart';

Future<List<Recipe>> recipesItem() async {
  // API endpoint
  final Uri url = Uri.parse("https://dummyjson.com/recipes");

  try {
    // Sending GET request
    final response = await http.get(url);

    // Check response status
    if (response.statusCode == 200) {
      // Parse JSON response
      final jsonResponse = recipesModelFromJson(response.body);
      return jsonResponse.recipes; // Assuming `recipes` is a list in the parsed model
    } else {
      // Handle non-200 responses
      if (kDebugMode) {
        print("Failed to load recipes: ${response.statusCode}");
      }
      return [];
    }
  } catch (e) {
    // Handle exceptions
    if (kDebugMode) {
      print("Error fetching recipes: $e");
    }
    return [];
  }
}
