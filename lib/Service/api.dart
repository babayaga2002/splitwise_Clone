import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/ExpenseModel.dart';
import '../Models/GroupModel.dart';
import '../Models/UserModel.dart';

class APIService {
  static const String host = "https://pll-splitwise-app.azurewebsites.net";
  static const String _addNewUser = "$host/users/";
  static const String _addNewGroup = "$host/groups/";

  static Future<bool> addNewUser(String name) async {
    var res = await http.post(
      Uri.parse(_addNewUser),
      body: jsonEncode({
        "name": name,
      }),
    );
    var body = jsonDecode(res.body);
    if (res.statusCode == 201) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("uid", body["id"]);
      return true;
    } else {
      print("Error");
      throw Error();
    }
  }

  static Future<bool> addNewFriend(String uidA, String uidB) async {
    print(_addNewUser + uidA + "/friends");
    var res = await http.post(
      Uri.parse(_addNewUser + uidA + "/friends"),
      body: jsonEncode({
        "friendId": uidB,
      }),
    );
    if (res.statusCode == 200 || res.statusCode == 400) {
      print(res.body);
      return true;
    } else {
      print("Error");
      throw Error();
    }
  }

  static Future<bool> addNewUserToGroup(String groupId, String uid) async {
    var res = await http.post(
      Uri.parse(_addNewGroup + groupId + "/members"),
      body: jsonEncode({
        "memberId": uid,
      }),
    );
    if (res.statusCode == 200 || res.statusCode == 400) {
      return true;
    } else {
      print("Error");
      throw Error();
    }
  }

  static Future<Map<String, String>> getFriendsData(List<String> uids) async {
    Map<String, String> m = {};
    uids.forEach((element) async {
      String a = await getUserName(element);
      m[element] = a;
    });
    print(m);
    return m;
  }

  static Future<UserModel> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String uid = sharedPreferences.getString("uid") ?? "sid";
    print(uid);
    print(_addNewUser + uid);
    http.Response response = await http.get(Uri.parse(_addNewUser + uid));
    var status = response.statusCode;
    var body = jsonDecode(response.body);
    if (status == 200) {
      print(body);
      return UserModel.fromJson(body);
    } else {
      print("Data could not be fetched : User Data");
      throw Exception("Data could not be fetched : User Data");
    }
  }

  static Future<String> getUserName(String uid) async {
    http.Response response =
        await http.get(Uri.parse(_addNewUser + uid + "/name"));
    var status = response.statusCode;
    var body = jsonDecode(response.body);
    if (status == 200) {
      return body;
    } else {
      print("Error");
      throw Error();
      throw Exception("Data could not be fetched");
    }
  }

  static Future<bool> addNewGroup(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String uid = sharedPreferences.getString("uid") ?? "sid";
    print(uid);
    print(name);
    var res = await http.post(
      Uri.parse(_addNewGroup),
      body: jsonEncode({
        "title": name,
        "userId": uid,
      }),
    );
    if (res.statusCode == 201) {
      return true;
    }
    print(res.statusCode);
    throw Error();
    throw Exception("Unexpected error");
  }

  static Future<bool> addNewExpensePaidEqually(String groupId, String title,
      int category, String paid_by, int expense) async {
    var res = await http.post(
      Uri.parse(_addNewGroup + groupId + "/items/"),
      body: jsonEncode({
        "title": title,
        "category": category,
        "paid_by": paid_by,
        "split_type": "paid_equally",
        "expense": expense,
      }),
    );
    if (res.statusCode == 200) {
      return true;
    }
    print("Error");
    throw Error();
    throw Exception("Unexpected error");
  }

  static Future<bool> addNewExpensePaidPercentage(String groupId, String title,
      int category, String paid_by, int expense, Map<String, int> owe) async {
    var res = await http.post(
      Uri.parse(_addNewGroup + groupId + "/items/"),
      body: jsonEncode({
        "title": title,
        "category": category,
        "paid_by": paid_by,
        "split_type": "by_percentage",
        "percent_split": owe,
        "expense": expense,
      }),
    );
    if (res.statusCode == 201) {
      return true;
    }
    print("Error");
    throw Error();
    throw Exception("Unexpected error");
  }

  static Future<bool> addNewExpensePaidManually(String groupId, String title,
      int category, String paid_by, int expense, Map<String, int> owe) async {
    var res = await http.post(
      Uri.parse(_addNewGroup + groupId + "/items/"),
      body: jsonEncode({
        "title": title,
        "category": category,
        "paid_by": paid_by,
        "split_type": "manually",
        "manually_split": owe,
        "expense": expense,
      }),
    );
    if (res.statusCode == 201) {
      return true;
    }
    print("Error");
    throw Error();
    throw Exception("Unexpected error");
  }

  static Future<List<GroupModel>> getGroupData(List<String> groupList) async {
    List<GroupModel> a = [];
    groupList.forEach((element) async {
      http.Response response =
          await http.get(Uri.parse(_addNewGroup + element));
      var status = response.statusCode;
      var body = jsonDecode(response.body);
      if (status == 200) {
        a.add(GroupModel.fromJson(body));
      } else {
        print("Error");
        throw Error();
        throw Exception("Data could not be fetched");
      }
    });
    return a;
  }

  static Future<List<ExpenseModel>> getGroupExpenses(String groupId) async {
    List<ExpenseModel> a = [];
    http.Response response =
        await http.get(Uri.parse(_addNewGroup + groupId + "/items"));
    var status = response.statusCode;
    var body = jsonDecode(response.body);
    if (status == 200) {
      for (var element in body) {
        a.add(ExpenseModel.fromJson(element));
      }
    } else {
      print("Error");
      throw Error();
      throw Exception("Data could not be fetched");
    }
    a.sort((a, b) => a.date!.compareTo(b.date!));
    return a;
  }

  static Future<List<ExpenseModel>> getUserExpenses(String uid) async {
    List<ExpenseModel> a = [];
    http.Response response =
        await http.get(Uri.parse(_addNewUser + uid + "/items"));
    var status = response.statusCode;
    var body = jsonDecode(response.body);
    if (status == 200) {
      for (var element in body) {
        a.add(ExpenseModel.fromJson(element));
      }
    } else {
      print("Error");
      throw Error();
      throw Exception("Data could not be fetched");
    }
    a.sort((a, b) => a.date!.compareTo(b.date!));
    return a;
  }
}