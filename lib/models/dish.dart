class Dish {
  final int id;
  final String name;
  final String description;
  final List<String> allergens;
  final String category;


  Dish.create({
    this.id,
    this.name,
    this.description,
    this.allergens,
    this.category,
  });
}
