import 'dart:async';
import 'dart:convert';

import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:smart_resto/models/amount_model.dart';
import 'package:smart_resto/models/dishes_commanded_model.dart';
import 'package:smart_resto/models/dishes_model.dart';
import 'package:smart_resto/models/restaurant_list_model.dart';
import 'package:smart_resto/models/ticket_model.dart';
import 'package:smart_resto/models/user_model.dart';

//Verifier la connexion internet
Future<int> internetCheck() async {
  try {
    var response = await http.get(
      Uri.parse("https://www.google.com"),
    );

    return response.statusCode;
  } catch (e) {
    return 400;
  }
}

//Verificaton du code identifiant
Future<String> codeChecked(String code) async {
  try {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://test.smt-group.net/api/check_code'));
    request.fields.addAll({
      'firstn': code[0].toString(),
      'secondn': code[1].toString(),
      'thirdn': code[2].toString(),
      'fourthn': code[3].toString(),
      'fifthn': code[4].toString(),
      'sixthn': code[5].toString()
    });

    http.StreamedResponse response = await request.send();
    print(response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 429) {
    } else {
      print(response.reasonPhrase);
    }
    return response.statusCode.toString();
  } catch (e) {
    return "error";
  }
}

//Connexion de l'utilisateur
Future<UserConnected> loginChecked(String phone, String password) async {
  UserConnected userConnected = UserConnected(
    auth_token: "auth_token",
    user: UserOfLogin(
      id: 0,
      uuid: "uuid",
      roleId: "roleId",
      firstname: "firstname",
      lastname: "lastname",
      phone: "phone",
      email: "email",
      profile: "profile",
      phone_verified_at: "phone_verified_at",
      email_verified_at: "email_verified_at",
      status: "status",
      created_at: "created_at",
      updated_at: "updated_at",
    ),
  );


    var request = http.MultipartRequest(
        'POST', Uri.parse('https://test.smt-group.net/api/login'));
    request.fields.addAll({'phone': phone, 'password': password});

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      userConnected = UserConnected.fromJson(json);
      return await userConnected;
    } else {
      print(response.reasonPhrase);
      return userConnected;
    }
 
}

//Mot de passe oublié
Future<String> forgetPassword(String email) async {
  var resultat = null;
  var internet = await internetCheck();
  try {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://test.smt-group.net/api/forget-password'));
    request.fields.addAll({
      'email': email,
    });

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);

      resultat = json['success'];

      return resultat;
    } else {
      print(response.reasonPhrase);
      return resultat;
    }
  } catch (e) {
    return resultat;
  }
}

//Reccupération des données de l'utilisateur
Future<User> getUser(String auth_token) async {
  User user = User(
      employeeId: 10000,
      uuid: "uuid",
      organizationName: "organizationName",
      groupName: "groupName",
      firstname: "firstname",
      lastname: "lastname",
      phone: "phone",
      email: "email",
      profile: "profile");

  try {
    var response = await http.get(
        Uri.parse("https://test.smt-group.net/api/userInformation"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $auth_token',
        });

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);

      return User(
        employeeId: json["employeeId"],
        organizationName: json["organizationName"],
        uuid: json["uuid"],
        groupName: json["groupName"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        email: json["email"],
        profile: json["profile"],
      );
    } else {
      print(response.reasonPhrase);
      return user;
    }
  } catch (e) {
    return user;
  }
}

//creation d'un fichier en local pour stocker le auth_token
writeCredentials(String auth) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/auth.txt');
  await file.writeAsString(auth);
}

//stocker l'id de l'employé connecté
writeId(String id) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/employeeId.txt');
  await file.writeAsString(id);
}

//reccupération de l'id de l'employé
Future<String> readId() async {
  String text = '';
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/employeeId.txt');
    text = await file.readAsString();
  } catch (e) {
    print("Couldn't read file");
  }
  return text;
}

//reccupération du auth_token stocké en local
Future<String> readCredentials() async {
  String text = '';
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/auth.txt');
    text = await file.readAsString();
  } catch (e) {
    print("Couldn't read file");
  }
  return text;
}

//Reccupération des plats
Future<List<Dishes>> getDishes(String auth_token) async {
  List<Dishes> dishes = [];

  try {
    var response = await http
        .get(Uri.parse("https://test.smt-group.net/api/dishes"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth_token',
    });

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['data'];

      List<Dishes> dishesModel =
          body.map((dynamic item) => Dishes.fromJson(item)).toList();

      return dishesModel;
    }

    throw Exception("Une erreur s'est produite ");
  } catch (e) {
    return dishes;
  }
}

//Reccupération des restaurant de l'employé
Future<List<AllRestaurant>> getRestaurants(String auth_token) async {
  List<AllRestaurant> restaurants = [];
  try {
    var response = await http
        .get(Uri.parse("https://test.smt-group.net/api/restaurants"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth_token',
    });

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['data'];

      List<AllRestaurant> restaurantModel =
          body.map((dynamic item) => AllRestaurant.fromJson(item)).toList();

      return restaurantModel;
    }
  } catch (e) {}

  return restaurants;
}

//Reccupération des plats commandés par l'employé mais pas encore validé
Future<List<DishesCommanded>> getCommandDishes(String auth_token) async {
  List<DishesCommanded> dishes_commended = [];

  try {
    var response = await http
        .get(Uri.parse("https://test.smt-group.net/api/getCommands"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth_token',
    });

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['data'];

      print(response.body);

      List<DishesCommanded> dishesCommandedModel =
          body.map((dynamic item) => DishesCommanded.fromJson(item)).toList();

      return dishesCommandedModel;
    }

    throw Exception("Une erreur s'est produite ");
  } catch (e) {
    return dishes_commended;
  }
}

//Reccupération du solde actuel de l'utilisateur
Future<Amount> getAmount(String auth_token) async {
  Amount amount = Amount(solde: "inconnu");

  try {
    var response = await http
        .get(Uri.parse("https://test.smt-group.net/api/get_amount"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth_token',
    });

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);

      return Amount(
        solde: json["Votre solde est de "],
      );
    } else {
      print(response.reasonPhrase);
    }

    throw Exception("Une erreur s'est produite ");
  } catch (e) {
    return amount;
  }
}

//Reccupération du nombre total de ticket de l'utilisateur
Future<Ticket> getTicket(String auth_token) async {
  Ticket nbr_ticket = Ticket(nbr_ticket: 0, employeeId: 1000);

  try {
    var response = await http
        .get(Uri.parse("https://test.smt-group.net/api/get_tickets"), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth_token',
    });

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);

      return Ticket(
          nbr_ticket: json["le nombre de tickets est de "],
          employeeId: json["employeeId"]);
    } else {
      print(response.reasonPhrase);
    }

    throw Exception("Une erreur s'est produite ");
  } catch (e) {
    return nbr_ticket;
  }
}

//Changer le mot de passe
Future<int> changePassword(
    String password, String confirmPassword, String auth_token) async {
  var operation = 0;
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://test.smt-group.net/api/changePassword'),
    );

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth_token',
    });

    request.fields
        .addAll({'password': password, 'confirm_password': confirmPassword});

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);

      return response.statusCode;
    } else {
      print(response.reasonPhrase);
    }

    throw Exception('Some arbitrary error');
  } catch (e) {
    print(e);
    return operation;
  }
}

//Déconnexion de la plateforme
Future<int> logout(String auth_token) async {
  var operation = null;
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://test.smt-group.net/api/logout'),
    );

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth_token',
    });

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);
      print(json);

      return response.statusCode;
    } else {
      print(response.reasonPhrase);
    }

    throw Exception('Some arbitrary error');
  } catch (e) {
    print(e);
    return operation;
  }
}

//Changer les informtions de l'utilisateur
Future<int> changeInformations(
    String firstname, String lastname, String phone, String auth_token) async {
  var operation = null;
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://test.smt-group.net/api/changeData'),
    );

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth_token',
    });

    request.fields
        .addAll({'lastname': lastname, 'firstname': firstname, 'phone': phone});

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);

      return response.statusCode;
    } else {
      print(response.reasonPhrase);
    }

    throw Exception('Some arbitrary error');
  } catch (e) {
    print(e);
    return operation;
  }
}

//Lancer un commande de plat
Future<String> CommandDishes(String employeeId, String dishId,
    String restaurantId, String userId, String auth_token) async {
  var operation = null;
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://test.smt-group.net/api/commands'),
    );

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth_token',
    });

    request.fields.addAll({
      'employeeId': employeeId,
      'dishId': dishId,
      'restaurantId': restaurantId,
      'userId': userId,
      'done': "0"
    });

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);
    print(response.statusCode);

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);
      print("Resultat de la commande :" + response.body);

      return json['success'];
    } else {
      print(response.reasonPhrase);
    }

    throw Exception('Some arbitrary error');
  } catch (e) {
    print(e);
    return operation;
  }
}

//Faire un dépôt sur le compte
Future<int> MakeDeposit(
    String phone, String amount, String otp_code, String auth_token) async {
  var operation = null;
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://test.smt-group.net/api/deposit'),
    );

    request.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $auth_token',
    });

    request.fields
        .addAll({'phone': phone, 'amount': amount, 'otp_code': otp_code});

    http.StreamedResponse streamedResponse = await request.send();

    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200 || response.statusCode == 429) {
      Map<String, dynamic> json = jsonDecode(response.body);

      return response.statusCode;
    } else {
      print(response.reasonPhrase);
    }

    throw Exception('Some arbitrary error');
  } catch (e) {
    return operation;
  }
}

//Achat de tickets
Future<String> buyTicket(
    String employeeId, String ticketNumber, String auth_token) async {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('https://test.smt-group.net/api/buy_ticket'),
  );

  request.headers.addAll({
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $auth_token',
  });

  request.fields.addAll({
    'employeeId': employeeId,
    'ticketNumber': ticketNumber,
  });

  http.StreamedResponse streamedResponse = await request.send();

  var response = await http.Response.fromStream(streamedResponse);

  Map<String, dynamic> json = jsonDecode(response.body);

  print(json['success']);
  return json['success'];
}
