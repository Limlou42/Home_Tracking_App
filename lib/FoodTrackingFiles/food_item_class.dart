class FoodItemClass{
  late String foodName;
  late int amountOfItem;
  late String imageURL;
  late bool isMain;

  FoodItemClass(String name, int amount, String image, bool mainOrSide) {
    foodName = name;
    amountOfItem = amount;
    imageURL = image;
    isMain = mainOrSide;
  }
}