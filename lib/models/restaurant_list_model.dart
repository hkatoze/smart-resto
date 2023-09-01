import 'package:smart_resto/models/dishes_model.dart';

class AllRestaurant {
  final int id;
  final String userId, description,
      slogan,
      schedules,
      localization,
      availability,
      created_at,
      updated_at;
  final Pivot pivot;
  final UserOFrestaurant user;

  const AllRestaurant(
      {required this.id,
      required this.userId,
      required this.description,
      required this.slogan,
      required this.schedules,
      required this.localization,
      required this.availability,
      required this.created_at,
      required this.updated_at,
      required this.pivot,
      required this.user});

  factory AllRestaurant.fromJson(Map<String, dynamic> json) {
    return AllRestaurant(
      id: json['id'],
      userId: json['userId'],
      description: json['description'],
      slogan: json['slogan'],
      schedules: json['schedules'],
      localization: json['localization'],
      availability: json['availability'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      pivot: Pivot.fromJson(json['pivot']),
      user: UserOFrestaurant.fromJson(json['user']),
    );
  }
}

class Pivot {
  final String organization_id, restaurant_id;

  const Pivot({required this.organization_id, required this.restaurant_id});

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      organization_id: json['organization_id'],
      restaurant_id: json['restaurant_id'],
    );
  }
}
