import 'package:flutter/material.dart';
import 'package:home_tracking_app/FoodTrackingFiles/food_item_class.dart';

//! needs slplitting up into stateless widgets
class AddNewFood extends StatefulWidget {
  final List<FoodItemClass> foodItems;
  const AddNewFood({super.key, required this.foodItems});

  @override
  State<AddNewFood> createState() => _AddNewFoodState();
}

class _AddNewFoodState extends State<AddNewFood> {
  bool needPicture = true;
  late TextEditingController controller;
  String foodName = '';
  int foodAmount = 0;
  bool? isMain = true;

  bool itemAlreadyInList(String foodName) {
    bool inList = false;

    for (FoodItemClass item in widget.foodItems) {
      if (item.foodName == foodName) {
        inList = true;
      }
    }

    return inList;
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add New Item"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),

              //Button that will take you to camera screen and then fill in the picture
              Container(
                  width: 250,
                  height: 250,
                  color: Colors.black,
                  child: needPicture
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              needPicture = false;
                            });
                          },
                          icon: const Icon(
                            Icons.camera_alt,
                            size: 120,
                            color: Colors.white,
                          ))
                      : Image.asset(
                          "assets/garlic_Bread.jpg",
                          fit: BoxFit.fill,
                        )),
              const SizedBox(height: 30),

              //Food name
              const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Food Name",
                      textScaler: TextScaler.linear(1.2),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),

              //Food name text field
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    foodName = value;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //Checkbox to say whether its a main or not
              CheckboxListTile(
                title: const Center(child: Text("Is this food a Main: ")),
                value: isMain,
                onChanged: (bool? newValue) {
                  setState(() {
                    isMain = newValue;
                  });
                },
                activeColor: Colors.blueAccent,
                checkColor: Colors.white,
              ),
              const SizedBox(height: 35),

              //All of the amount changing widgets
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Amount",
                        textScaler: TextScaler.linear(1.2),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        foodAmount.toString(),
                        textScaler: const TextScaler.linear(1.5),
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (foodAmount > 0) {
                                    foodAmount -= 1;
                                  }
                                });
                              },
                              icon: const Icon(Icons.remove)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  foodAmount += 1;
                                });
                              },
                              icon: const Icon(Icons.add)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),

              //Button to add the new item to the food item list and return to the previous page
              TextButton(
                  onPressed: () {
                    if (foodName != '' &&
                        foodAmount != 0 &&
                        needPicture == false) {
                      setState(() {
                        widget.foodItems.add(FoodItemClass(
                            foodName, foodAmount, "garlic_Bread.jpg", isMain!));
                      });
                      Navigator.pop(context, true);
                    } else if (itemAlreadyInList(foodName)) {
                      showDialog(
                          context: context,
                          builder: (context) => const AlertDialogItemCheck(
                                alertText: "Item is already stored",
                              ));
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => const AlertDialogItemCheck(
                              alertText: "Please complete all the fields"));
                    }
                  },
                  style: TextButton.styleFrom(
                      minimumSize: const Size(180, 60),
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.blueAccent),
                  child: const Text(
                    "Add To List",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class AlertDialogItemCheck extends StatelessWidget {
  final String alertText;
  const AlertDialogItemCheck({super.key, required this.alertText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"))
      ],
      title: Text(alertText),
    );
  }
}
