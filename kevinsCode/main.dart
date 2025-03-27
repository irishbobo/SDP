import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const RecipeListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({super.key});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  late Future<List<Map<String, dynamic>>> recipes;

  @override
  void initState() {
    super.initState();
    recipes = fetchRecipes();
  }

  Future<List<Map<String, dynamic>>> fetchRecipes() async {
    const url =
        'https://3akmnevyl0.execute-api.us-east-1.amazonaws.com/default/GetRecipesLambda';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load recipes: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipes')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: recipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final recipeList = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
              ),
              itemCount: recipeList.length,
              itemBuilder: (context, index) {
                final recipe = recipeList[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => RecipePopup(recipe: recipe),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            recipe['image_url'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[300],
                                alignment: Alignment.center,
                                child: const Icon(Icons.broken_image,
                                    size: 40, color: Colors.grey),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recipe['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class RecipePopup extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipePopup({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final ingredients = recipe['ingredients'] as List<dynamic>;
    final nutrition = recipe['nutrition_profile'] as Map<String, dynamic>;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        recipe['image_url'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[300],
                            alignment: Alignment.center,
                            child: const Icon(Icons.broken_image, size: 40),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Ingredients:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...ingredients.asMap().entries.map((entry) {
                      final i = entry.key + 1;
                      final item = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                            "$i. ${item['quantity']} ${item['unit']} ${item['name']}",
                            style: const TextStyle(fontSize: 16)),
                      );
                    }).toList()
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            recipe['name'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text("Nutrition:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...nutrition.entries.map((e) => Text("${e.key}: ${e.value}",
                        style: const TextStyle(fontSize: 16))),
                    const SizedBox(height: 24),
                    const Text("Instructions:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(recipe['instructions'],
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
