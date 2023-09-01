import 'package:smart_resto/models/dishes_model.dart';

class DishesCommanded {
  final int id;
  final String employeeId,
      dishId,
      categoryId,
      restaurantId,
      userId,
      done,
      created_at,
      updated_at;

  final Employee employee;
  final DishesItem dishes;

  const DishesCommanded(
      {required this.id,
      required this.employeeId,
      required this.dishId,
      required this.categoryId,
      required this.restaurantId,
      required this.userId,
      required this.done,
      required this.created_at,
      required this.updated_at,
      required this.employee,
      required this.dishes});

  factory DishesCommanded.fromJson(Map<String, dynamic> json) {
    return DishesCommanded(
      id: json['id'],
      employeeId: json['employeeId'],
      dishId: json['dishId'],
      categoryId: json['categoryId'],
      restaurantId: json['restaurantId'],
      userId: json['userId'],
      done: json['done'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      employee: Employee.fromJson(json['employee']),
      dishes: DishesItem.fromJson(json['dishes']),
    );
  }
}

class Employee {
  final int id;

  final String userId,
      organizationId,
      groupId,
      identityCode,
      first_login,
      created_at,
      updated_at;
  final UserOFrestaurant user;

  const Employee(
      {required this.id,
      required this.userId,
      required this.organizationId,
      required this.groupId,
      required this.identityCode,
      required this.first_login,
      required this.created_at,
      required this.updated_at,
      required this.user});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
        id: json['id'],
        userId: json['userId'],
        organizationId: json['organizationId'],
        groupId: json['groupId'],
        identityCode: json['identityCode'],
        first_login: json['first_login'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        user: UserOFrestaurant.fromJson(json['user']));
  }
}

class DishesItem {
  final int id;

  final String name,
      description,
      categoryId,
      restaurantId,
      picture1,
      picture2,
      picture3,
      created_at,
      updated_at;

  const DishesItem({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryId,
    required this.restaurantId,
    required this.picture1,
    required this.picture2,
    required this.picture3,
    required this.created_at,
    required this.updated_at,
  });

  factory DishesItem.fromJson(Map<String, dynamic> json) {
    return DishesItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categoryId: json['categoryId'],
      restaurantId: json['restaurantId'],
      picture1: json['picture1'],
      picture2: json['picture2'],
      picture3: json['picture3'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
