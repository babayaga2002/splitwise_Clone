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
  static const Map<String, String> headers = {
    "Content-Type": "application/json"
  };
  static Future<bool> addNewUser(String name) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
    var res = await http.post(
      Uri.parse(_addNewUser),
      body: jsonEncode({
        "name": name,
      }),
      headers: headers,
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
    var res = await http.post(
      Uri.parse(_addNewUser + uidA + "/friends"),
      body: jsonEncode({
        "friendId": uidB,
      }),
      headers: headers,
    );
    if (res.statusCode == 200 || res.statusCode == 400) {
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
      headers: headers,
    );
    print(res.body);
    if (res.statusCode == 200 || res.statusCode == 400) {
      return true;
    } else {
      print("Error");
      return false;
    }
  }

  static Future<bool> settleUp(
      String groupId, String payerId, String receiverId, num amount) async {
    var res = await http.post(
      Uri.parse(_addNewGroup + groupId + "/settle-up"),
      body: jsonEncode({
        "payerId": payerId,
        "receiverId": receiverId,
        "amount": amount,
      }),
      headers: headers,
    );
    print(res.body);
    if (res.statusCode == 200) {
      return true;
    } else {
      print("Error");
      return false;
    }
  }

  static Future<Map<String, String>> getFriendsData(List<String> uids) async {
    Map<String, String> m = {};
    for (var element in uids) {
      String a = await getUserName(element);
      m[element] = a;
    }
    return m;
  }

  static Future<Map<String, String>> getGroupMembersData(
      List<String> uids) async {
    Map<String, String> m = {};
    for (var element in uids) {
      String a = await getUserName(element);
      m[element] = a;
    }
    return m;
  }

  static Future<UserModel> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String uid = sharedPreferences.getString("uid") ?? "sid";
    http.Response response = await http.get(Uri.parse(_addNewUser + uid));
    var status = response.statusCode;
    var body = jsonDecode(response.body);
    print(body);
    if (status == 200) {
      UserModel user = UserModel.fromJson(body);
      return user;
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
      return body["name"];
    } else {
      print("Error");
      throw Error();
      throw Exception("Data could not be fetched");
    }
  }

  static Future<bool> addNewGroup(String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String uid = sharedPreferences.getString("uid") ?? "sid";
    var res = await http.post(
      Uri.parse(_addNewGroup),
      body: jsonEncode({
        "title": name,
        "userId": uid,
      }),
      headers: headers,
    );
    if (res.statusCode == 201) {
      return true;
    }
    throw Error();
    throw Exception("Unexpected error");
  }

  static Future<bool> addNewExpensePaidEqually(String groupId, String title,
      int category, String paid_by, int expense) async {
    print([groupId, title, category, paid_by, expense]);
    var res = await http.post(
      Uri.parse(_addNewGroup + groupId + "/items/"),
      body: jsonEncode({
        "title": title,
        "category": category,
        "paid_by": paid_by,
        "split_type": "paid_equally",
        "expense": expense,
      }),
      headers: headers,
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
      headers: headers,
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
      headers: headers,
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
    for (var element in groupList) {
      http.Response response =
          await http.get(Uri.parse(_addNewGroup + element));
      var status = response.statusCode;
      var body = jsonDecode(response.body);
      if (status == 200) {
        GroupModel g = GroupModel.fromJson(body);
        a.add(GroupModel.fromJson(body));
      } else {
        print("Error");
        throw Error();
        throw Exception("Data could not be fetched");
      }
    }
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
        print(element);
        a.add(ExpenseModel.fromJson(element));
      }
    } else {
      print("Error");
      throw Error();
      throw Exception("Data could not be fetched");
    }
    if (a.isNotEmpty) a.sort((a, b) => a.date!.compareTo(b.date!));
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
