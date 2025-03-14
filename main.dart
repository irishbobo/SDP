import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

///
/// The root widget of the application.
/// Sets up our MaterialApp, theme, and named routes for navigation.
///
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom AppBar Hamburger',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        ProfilePage.routeName: (context) => ProfilePage(),
        DietSettingsPage.routeName: (context) => DietSettingsPage(),
        SavedRecipesPage.routeName: (context) => SavedRecipesPage(),
        MyMacrosPage.routeName: (context) => MyMacrosPage(),
      },
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

///
/// HomePage widget:
/// - No top AppBar at all.
/// - Uses a BottomAppBar with a hamburger icon on the right side.
/// - Uses endDrawer to open from the right side of the screen.
///
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // A GlobalKey to access the ScaffoldState so we can open the endDrawer programmatically.
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Connect the Scaffold to our global key, allowing control over the drawer.
      key: _scaffoldKey,

      // We won't have a top AppBar, so just place the main content in the body.
      body: Center(
        child: Text(
          'Home page bullshit',
          textAlign: TextAlign.center,
        ),
      ),

      // Use an endDrawer that slides in from the right side.
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 150, 216, 74),
              ),
              child: Text(
                'MENU',
                style: TextStyle(color: Colors.black, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('PROFILE'),
              onTap: () {
                Navigator.pushNamed(context, ProfilePage.routeName);
              },
            ),
            ListTile(
              title: Text('DIET SETTINGS'),
              onTap: () {
                Navigator.pushNamed(context, DietSettingsPage.routeName);
              },
            ),
            ListTile(
              title: Text('SAVED RECIPES'),
              onTap: () {
                Navigator.pushNamed(context, SavedRecipesPage.routeName);
              },
            ),
            ListTile(
              title: Text('MY MACROS'),
              onTap: () {
                Navigator.pushNamed(context, MyMacrosPage.routeName);
              },
            ),
          ],
        ),
      ),

      // BottomAppBar goes at the bottom of the screen.
      // We place an IconButton (hamburger) on the right to open the endDrawer.
      bottomNavigationBar: BottomAppBar(
        // You can shape or style the BottomAppBar if you wish, but here we keep it simple.
        child: Row(
          // Push the icon button to the far right.
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Programmatically open the end drawer using the Scaffold key.
                _scaffoldKey.currentState?.openEndDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }
}

///
/// PROFILE PAGE
/// Shows four fields:
///   1) Profile Name
///   2) Email
///   3) Password (obscured)
///   4) Logout
///
class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We can keep a top AppBar on sub-pages if we want.
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Profile Name'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Typically you'd also clear the user's session, etc.
                Navigator.pop(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// DIET SETTINGS PAGE
/// Shows a list of excluded foods that the user can add/remove.
///
class DietSettingsPage extends StatefulWidget {
  static const routeName = '/dietSettings';

  @override
  _DietSettingsPageState createState() => _DietSettingsPageState();
}

class _DietSettingsPageState extends State<DietSettingsPage> {
  final List<String> _excludedFoods = [];
  final TextEditingController _foodController = TextEditingController();

  @override
  void dispose() {
    _foodController.dispose();
    super.dispose();
  }

  void _addFood() {
    if (_foodController.text.trim().isNotEmpty) {
      setState(() {
        _excludedFoods.add(_foodController.text.trim());
      });
      _foodController.clear();
    }
  }

  void _removeFood(int index) {
    setState(() {
      _excludedFoods.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Field + button to add a new excluded food.
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _foodController,
                    decoration:
                        InputDecoration(labelText: 'Add food to exclude'),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addFood,
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // The list of excluded foods.
            Expanded(
              child: ListView.builder(
                itemCount: _excludedFoods.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_excludedFoods[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeFood(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// SAVED RECIPES PAGE
/// Shows a list of saved recipes that the user can add/remove.
/// Tapping a recipe opens a dialog for details.
///
class SavedRecipesPage extends StatefulWidget {
  static const routeName = '/savedRecipes';

  @override
  _SavedRecipesPageState createState() => _SavedRecipesPageState();
}

class _SavedRecipesPageState extends State<SavedRecipesPage> {
  final List<String> _recipes = [];
  final TextEditingController _recipeController = TextEditingController();

  @override
  void dispose() {
    _recipeController.dispose();
    super.dispose();
  }

  void _addRecipe() {
    if (_recipeController.text.trim().isNotEmpty) {
      setState(() {
        _recipes.add(_recipeController.text.trim());
      });
      _recipeController.clear();
    }
  }

  void _removeRecipe(int index) {
    setState(() {
      _recipes.removeAt(index);
    });
  }

  void _openRecipeDetails(String recipeTitle) {
    TextEditingController detailsController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(recipeTitle),
          content: TextField(
            controller: detailsController,
            decoration: InputDecoration(labelText: 'Recipe Details'),
            maxLines: 5,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Recipes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // + button to add new recipes.
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _recipeController,
                    decoration: InputDecoration(labelText: 'Recipe title'),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addRecipe,
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),
            // The list of saved recipes.
            Expanded(
              child: ListView.builder(
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_recipes[index]),
                    onTap: () => _openRecipeDetails(_recipes[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _removeRecipe(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///
/// MY MACROS PAGE
/// Three integer fields (Calories, Protein, Sugar).
/// A 'Save' button prints them (in a real app, you'd store them).
///
class MyMacrosPage extends StatefulWidget {
  static const routeName = '/myMacros';

  @override
  _MyMacrosPageState createState() => _MyMacrosPageState();
}

class _MyMacrosPageState extends State<MyMacrosPage> {
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _sugarController = TextEditingController();

  @override
  void dispose() {
    _caloriesController.dispose();
    _proteinController.dispose();
    _sugarController.dispose();
    super.dispose();
  }

  void _saveMacros() {
    setState(() {
      // Convert text fields to integers (default to 0 if parsing fails).
      int calories = int.tryParse(_caloriesController.text) ?? 0;
      int protein = int.tryParse(_proteinController.text) ?? 0;
      int sugar = int.tryParse(_sugarController.text) ?? 0;

      // For demo, just print to console. In production, save these somewhere else.
      print('Calories: $calories, Protein: $protein, Sugar: $sugar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Macros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _caloriesController,
              decoration: InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _proteinController,
              decoration: InputDecoration(labelText: 'Protein'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _sugarController,
              decoration: InputDecoration(labelText: 'Sugar'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveMacros,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
