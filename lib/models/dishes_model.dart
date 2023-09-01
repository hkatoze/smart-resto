class Dishes {
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
  final Category category;
  final Restaurant restaurant;

  const Dishes(
      {required this.id,
      required this.name,
      required this.description,
      required this.categoryId,
      required this.restaurantId,
      required this.picture1,
      required this.picture2,
      required this.picture3,
      required this.created_at,
      required this.updated_at,
      required this.category,
      required this.restaurant});

  factory Dishes.fromJson(Map<String, dynamic> json) {
    return Dishes(
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
      category: Category.fromJson(json['category']),
      restaurant: Restaurant.fromJson(json['restaurant']),
    );
  }
}

class Category {
  final int id;
  final String name, restaurantId, created_at, updated_at;

  const Category(
      {required this.created_at,
      required this.name,
      required this.id,
      required this.restaurantId,
      required this.updated_at});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        name: json['name'],
        restaurantId: json['restaurantId'],
        created_at: json['created_at'],
        updated_at: json['updated_at']);
  }
}

class Restaurant {
  final int id;
  final UserOFrestaurant user;
  final String userId,
      description,
      slogan,
      schedules,
      localization,
      availability,
      created_at,
      updated_at;

  const Restaurant(
      {required this.id,
      required this.userId,
      required this.description,
      required this.slogan,
      required this.schedules,
      required this.localization,
      required this.availability,
      required this.created_at,
      required this.updated_at,
      required this.user});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        id: json['id'],
        userId: json['userId'],
        description: json['description'],
        slogan: json['slogan'],
        schedules: json['schedules'],
        localization: json['localization'],
        availability: json['availability'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        user: UserOFrestaurant.fromJson(json['user']));
  }
}

class UserOFrestaurant {
  final int id;

  final String uuid,
      roleId,
      firstname,
      lastname,
      phone,
      phone_verified_at,
      email,
      email_verified_at,
      profile,
      status,
      created_at,
      updated_at;

  const UserOFrestaurant(
      {required this.id,
      required this.uuid,
      required this.roleId,
      required this.firstname,
      required this.lastname,
      required this.phone,
      required this.phone_verified_at,
      required this.email,
      required this.email_verified_at,
      required this.profile,
      required this.status,
      required this.created_at,
      required this.updated_at});

  factory UserOFrestaurant.fromJson(Map<String, dynamic> json) {
    return UserOFrestaurant(
        id: json['id'],
        uuid: json['uuid'],
        roleId: json['roleId'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        phone: json['phone'],
        phone_verified_at: json['phone_verified_at'],
        email: json['email'],
        email_verified_at: json['email_verified_at'],
        profile: json['profile'],
        status: json['status'],
        created_at: json['created_at'],
        updated_at: json['updated_at']);
  }
}
