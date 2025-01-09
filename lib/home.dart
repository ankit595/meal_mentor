import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:stroke_text/stroke_text.dart';

import 'details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "Fast Food";
  List<Map<String, dynamic>> foodItems = [];
  List<Map<String, dynamic>> filteredItems = [];
  List<Map<String, dynamic>> recommendedItems = [];

  @override
  void initState() {
    super.initState();
    loadFoodData();
  }

  Future<void> loadFoodData() async {
    final jsonString =
        await DefaultAssetBundle.of(context).loadString("assets/food.json");
    final List<dynamic> data = jsonDecode(jsonString);
    setState(() {
      foodItems = List<Map<String, dynamic>>.from(data);
      filterItemsByCategory();
      generateRecommendedItems();
    });
  }

  void filterItemsByCategory() {
    filteredItems = foodItems
        .where((item) => item["category"] == selectedCategory)
        .toList();
  }

  void generateRecommendedItems() {
    recommendedItems = List<Map<String, dynamic>>.from(foodItems);
    recommendedItems.shuffle();
    recommendedItems = recommendedItems.take(10).toList(); // Display 4 items
  }

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
      filterItemsByCategory();
    });
  }

  String getSalutation() {
    final hour = DateTime.now().hour; // Get the current hour

    if (hour >= 5 && hour < 12) {
      return "Good Morning!!";
    } else if (hour >= 12 && hour < 17) {
      return "Good Afternoon!!";
    } else if (hour >= 17 && hour < 21) {
      return "Good Evening!!";
    } else {
      return "Good Night!!";
    }
  }

  final List<String> nicknames = [
    "Pancake",
    "Toastie",
    "Muffin",
    "Bagel",
    "Cereal Buddy",
    "Noodle",
    "Pizza Slice",
    "Taco Champ",
    "Sushi Roll",
    "Sandwich Star",
    "Biryani Boss",
    "Burger Buddy",
    "Pasta Pal",
    "Fries Fan",
    "Soup Sipper",
    "Cupcake",
    "Honey Bun",
    "Sugarplum",
    "Cinnamon Roll",
    "Choco Muffin",
    "Sweet Pea",
    "Candy Cane",
    "Donut",
    "Milkshake",
    "Lollipop",
    "Brownie",
    "Cookie",
    "Pudding Pie",
    "Caramel Crunch",
    "Jellybean",
    "Cheesecake",
    "Ice Cream",
    "Marshmallow",
    "Buttercup",
    "Candyfloss",
    "Gummy Bear",
    "Peachy Pie",
    "Choco Chip",
    "Sugar Cookie"
  ];

  final item = Random().nextInt(17) + 1;
  final index = Random().nextInt(39);
  @override
  Widget build(BuildContext context) {
    final salutation = getSalutation();
    print(item);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      StrokeText(
                        text: salutation,
                        textStyle: GoogleFonts.atma(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        strokeColor: Colors.deepOrangeAccent,
                        strokeWidth: 2,
                      ),
                      Text(
                        "${nicknames[index]} ❣️",
                        style: GoogleFonts.rubikPuddles(
                            color: Colors.deepOrangeAccent,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.height * .12,
                    width: MediaQuery.of(context).size.height * .12,
                    child: Card(
                      shadowColor: Colors.brown,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Image.asset(
                        "assets/profile_pics/$item.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft, // Aligns the text to the left
                child: Text(
                  "Offerings",
                  style: GoogleFonts.deliusSwashCaps(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final category in [
                      "Fast Food",
                      "Fruits",
                      "Veg",
                      "Non-Veg",
                      "Seafood",
                      "Drinks",
                      "Cakes",
                      "Salads",
                      "Soups",
                      "Desserts",
                      "Sweets"
                    ])
                      GestureDetector(
                        onTap: () => onCategorySelected(category),
                        child: CategoryCard(
                          category: category,
                          isSelected: category == selectedCategory,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * .25,
                child: filteredItems.isEmpty
                    ? const Center(child: Text("No items available"))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = filteredItems[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: FoodItemCard(item: item),
                          );
                        },
                      ),
              ),
              Align(
                alignment: Alignment.centerLeft, // Aligns the text to the left
                child: Text(
                  "Recommended for You",
                  style: GoogleFonts.deliusSwashCaps(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    crossAxisSpacing: 10.0, // Spacing between columns
                    childAspectRatio:
                        2 / 4, // Adjusts the aspect ratio of each grid item
                  ),
                  itemCount: recommendedItems.length,
                  itemBuilder: (context, index) {
                    final item = recommendedItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(item: item),
                          ),
                        );
                      },
                      child: Hero(
                        tag: item["name"],
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .17,
                                  width:
                                      MediaQuery.of(context).size.height * .18,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        item["images"][0],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Spacer(),
                                Text(
                                  item["name"],
                                  style: GoogleFonts.deliusSwashCaps(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                RichText(
                                    text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Price Range : ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: item["price_range"],
                                        style: TextStyle(
                                          color: Colors.black,
                                        )),
                                  ],
                                )),
                                Spacer(),
                                Text(
                                  "Protein: ${item["nutritions"]["protein"]}, Carbs: ${item["nutritions"]["carbohydrates"]}, Fat: ${item["nutritions"]["fat"]}",
                                ),
                                Spacer(),
                                Text("Details: ${item["details"]}"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final bool isSelected;

  const CategoryCard({
    required this.category,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.deepOrangeAccent : Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Text(
          category,
          style: GoogleFonts.atma(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class FoodItemCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const FoodItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      width: MediaQuery.of(context).size.height * .2,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(item: item),
            ),
          );
        },
        child: Hero(
          tag: item["name"],
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .17,
                    width: MediaQuery.of(context).size.height * .18,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          item["images"][0],
                          fit: BoxFit.cover,
                        )),
                  ),
                  Spacer(),
                  Text(
                    item["name"],
                    style: GoogleFonts.deliusSwashCaps(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item["price_range"],
                    style: GoogleFonts.carterOne(
                      fontSize: 10,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
