import 'package:flutter/material.dart';
import 'package:home_tracking_app/FoodTrackingFiles/food_item_class.dart';
import 'food_tracker_add_item.dart';

//? Search bar

class TrackStoredFoods extends StatefulWidget {
  const TrackStoredFoods({super.key});

  @override
  State<TrackStoredFoods> createState() => _TrackStoredFoodsState();
}

class _TrackStoredFoodsState extends State<TrackStoredFoods> {

  List<FoodItemClass> foodItems = [FoodItemClass("Cheese Pizza", 2, "pizza_Image.jpg", true), FoodItemClass("Garlic Bread", 1, "garlic_Bread.jpg", false), FoodItemClass("Chicken Drummer", 4, "garlic_Bread.jpg", true), FoodItemClass("Turkey Dinosaurs", 2, "turkey_Dinosaurs.jpg", true)];
  
  int currentFoodFilterIndex = 0;

  List<FoodItemClass> get filteredFoodItems {
    if (currentFoodFilterIndex == 1) {
      return foodItems.where((item) => item.isMain).toList();
    } else if (currentFoodFilterIndex == 2) {
      return foodItems.where((item) => !item.isMain).toList();
    }
    return foodItems;
  }

  void updateTabBarIndex(int value) {
    setState(() {
      currentFoodFilterIndex = value;
    });
  }

  void updateState() {
    setState((){});
  }

  void increaseAmount(int index) {
    setState(() {
      foodItems[index].amountOfItem += 1;
    });
  }

  void decreaseOrRemoveAmount(int index) {
    setState(() {
      if (index != -1) {
        if (foodItems[index].amountOfItem > 1) {
          foodItems[index].amountOfItem -= 1;
        } else {
          foodItems.removeAt(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(preferredSize: const Size(200, 90), child: FoodListAppBar(foodItems: foodItems, updateIndex: updateTabBarIndex, updateState: updateState,)),
        body: Center(
          child: FoodItemListView(foodItems: foodItems, filteredFoodItems: filteredFoodItems, increaseAmount: increaseAmount, decreaseOrRemoveAmount: decreaseOrRemoveAmount)
        )
      ),
    );
  }
}

class FoodListAppBar extends StatelessWidget implements PreferredSizeWidget{
  final List<FoodItemClass> foodItems;
  final Function(int) updateIndex;
  final Function updateState;
  const FoodListAppBar ({super.key, required this.foodItems, required this.updateIndex, required this.updateState});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Stored Foods"),
      bottom: TabBar(
        onTap: (value) => updateIndex(value),
        tabs: const [
          Tab(child: Text("All Foods"),),
          Tab(child: Text("Mains"),),
          Tab(child: Text("Sides"))
        ]
      ),
      actions: [
        IconButton(
          onPressed: () async {
            // Await the result from AddNewFood page
            final result = await Navigator.push(
              context, 
              MaterialPageRoute(builder: (context) => AddNewFood(foodItems: foodItems)),
            );
            if (result != null) {
              updateState();
            }
          }, 
          icon: const Icon(Icons.add_box_outlined, size: 30,)
        )
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}

class FoodItemListView extends StatelessWidget {
  final List<FoodItemClass> foodItems;
  final List<FoodItemClass> filteredFoodItems;
  final Function(int) increaseAmount;
  final Function(int) decreaseOrRemoveAmount;

  const FoodItemListView({super.key, required this.foodItems, required this.filteredFoodItems, required this.increaseAmount, required this.decreaseOrRemoveAmount});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: filteredFoodItems.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(
              children: [

                //Image of item
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SizedBox(
                    width: 80,
                    child: Image.asset("assets/${filteredFoodItems[index].imageURL}")
                  ),
                ),
                const SizedBox(width: 10,),

                //Text to display both name and if its a side or main
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(filteredFoodItems[index].foodName, textScaler: const TextScaler.linear(1.2), style: const TextStyle(fontWeight: FontWeight.bold),),
                    Text(filteredFoodItems[index].isMain ? "Main" : "Side")
                  ],
                ),
                const Spacer(),

                //display the amount of the item currently stored
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Amount", textScaler: TextScaler.linear(1.2), style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(filteredFoodItems[index].amountOfItem.toString(), textScaler: const TextScaler.linear(1.1),)
                  ],
                ),
                const SizedBox(width: 10,),

                //Icon buttons to increase/decrease amount
                Column(
                  children: [
                    IncreaseButton(foodItems: foodItems, filteredFoodItems: filteredFoodItems, index: index, increaseAmount: increaseAmount),
                    DecreaseButton(foodItems: foodItems, filteredFoodItems: filteredFoodItems, index: index, decreaseOrRemoveAmount: decreaseOrRemoveAmount)
                  ],
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.shade400,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        );
      }
    );
  }
}

class IncreaseButton extends StatelessWidget {
  final List<FoodItemClass> foodItems;
  final List<FoodItemClass> filteredFoodItems;
  final int index;
  final Function(int) increaseAmount;

  const IncreaseButton({super.key, required this.foodItems, required this.filteredFoodItems, required this.index, required this.increaseAmount});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final mainListIndex = foodItems.indexWhere(
          (item) => item.foodName == filteredFoodItems[index].foodName,
        );
        if (mainListIndex != -1) {
          increaseAmount(mainListIndex);
        }
      },
      icon: const Icon(Icons.add),
    );
  }
}

class DecreaseButton extends StatelessWidget {
  final List<FoodItemClass> foodItems;
  final List<FoodItemClass> filteredFoodItems;
  final int index;
  final Function(int) decreaseOrRemoveAmount;

  const DecreaseButton({super.key, required this.foodItems, required this.filteredFoodItems, required this.index, required this.decreaseOrRemoveAmount});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final mainListIndex = foodItems.indexWhere(
          (item) => item.foodName == filteredFoodItems[index].foodName,
        );
        decreaseOrRemoveAmount(mainListIndex);
      },
      icon: const Icon(Icons.remove),
    );
  }
}