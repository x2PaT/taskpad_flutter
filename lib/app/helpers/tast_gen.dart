import 'dart:math';

String createTaskTitle() {
  final verbs = [
    "Buy",
    "Make",
    "Create",
    "Find",
    "Take",
    "Cook",
    "Build",
    "Write",
    "Discover",
    "Gather"
  ];
  final objects = [
    "Fresh vegetables",
    "Paper airplanes",
    "Digital artwork",
    "Lost keys",
    "Photographs",
    "Spaghetti",
    "Sandcastle",
    "Novel",
    "Treasure",
    "Information"
  ];
  final preposition = [
    "At",
    "From",
    "On",
    "Under",
    "In",
    "With",
    "On",
    "About",
    "Near",
    "During",
  ];
  final location = [
    "Grocery store",
    "Origami paper",
    "Computer",
    "Sofa",
    "National park",
    "Tomato sauce",
    "Beach",
    "Adventure",
    "Ancient ruins",
    "Conference"
  ];
  
  final random = Random();
  return "${verbs[random.nextInt(verbs.length)]} ${objects[random.nextInt(objects.length)]} ${preposition[random.nextInt(preposition.length)]} ${location[random.nextInt(location.length)]}";
}

int randomID() {
  return Random().nextInt(0xFFFFFF);
}
