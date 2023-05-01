// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitwise/Models/UserModel.dart';
import 'package:splitwise/components/ActivityTab/ActivityTile.dart';
import 'package:splitwise/components/Friends/FriendsTile.dart';

import '../Models/ExpenseModel.dart';
import '../Models/GroupModel.dart';
import '../Service/api.dart';
import '../components/Group/GroupTile.dart';

part 'homeStore.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  _HomeStore() {
    reaction((_) {
      return loadOperation.value;
    }, (_) {
      getData(loadOperation.value!);
    });
    autorun((p0) {
      getUserData();
      getUid();
    });
  }
  @observable
  Observable<String> uid = Observable("");

  @observable
  int indexAddExpense = 0;

  @action
  void setIndex(int i) {
    indexAddExpense = i;
  }

  @observable
  ObservableFuture<UserModel?> loadOperation = ObservableFuture.value(null);

  @observable
  Observable<String> owedString = Observable("");

  @observable
  ObservableFuture<List<GroupModel?>> groupOperation =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<Map<String, String>> friendOperation =
      ObservableFuture.value({});

  @observable
  ObservableList<Widget> groupTilesList = ObservableList<Widget>.of([]);

  @observable
  ObservableList<Widget> groupTilesAddExpenseList =
      ObservableList<Widget>.of([]);

  @observable
  ObservableList<Widget> friendsTilesList = ObservableList<Widget>.of([]);

  @observable
  ObservableList<Widget> friendsTilesActivityList =
      ObservableList<Widget>.of([]);

  @observable
  ObservableMap<String, String> friendsNameToUid =
      ObservableMap<String, String>.of({});

  @observable
  ObservableList<Widget> activityTiles = ObservableList<Widget>.of([]);

  @action
  Future<void> getUid() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    uid = Observable(instance.getString("uid") ?? "");
  }

  @action
  Future<void> getUserData() async {
    loadOperation = APIService.getUserData().asObservable();
  }

  @action
  void getData(UserModel user) {
    print(user.groups);
    if (loadOperation != null &&
        loadOperation.value != null &&
        loadOperation.value!.groups != null) {
      print(loadOperation.value!.groups!);
      groupOperation =
          APIService.getGroupData(loadOperation.value!.groups!).asObservable();
      print(groupOperation.error);
      print(groupOperation.value);
    }
    if (loadOperation != null &&
        loadOperation.value != null &&
        loadOperation.value!.friends != null) {
      friendOperation = APIService.getFriendsData(loadOperation.value!.friends!)
          .asObservable();
      print(friendOperation.error);
      print(friendOperation.value);
      friendsNameToUid = ObservableMap.of(friendOperation.value!);
      print(friendsNameToUid);
      getFriendsTiles();
    }
  }

  @action
  void getFriendsTiles() {
    List<Widget> a = [];
    if (loadOperation == null) getUserData();
    friendsNameToUid.forEach((key, value) {
      a.add(FriendsTile(friendName: value, friendid: key));
    });
    friendsTilesActivityList = ObservableList<Widget>.of(a);
  }

  @computed
  String get titleString {
    String text = "";
    if (loadOperation == null) getUserData();
    if (loadOperation != null &&
        loadOperation.value != null &&
        loadOperation.value!.totalSpendings != null) {
      if (loadOperation.value!.totalSpendings! > 0) {
        text = "Overall, you are owed " +
            loadOperation.value!.totalSpendings.toString();
      } else if (loadOperation == 0) {
        text = "You are all settled-up";
      } else
        text = "Overall, you owe " +
            (-loadOperation.value!.totalSpendings!).toString();
    }
    owedString = Observable<String>(text);
    return text;
  }

  String calculate(Map<String, Map<String, int>> map) {
    int sum = 0;
    if (uid == "")
      return "";
    else {
      Map<String, int>? m = map[uid];
      if (m != null) {
        m.forEach((key, value) {
          sum += value;
        });
      }
      if (sum > 0) {
        return "You are owed " + sum.toString();
      } else if (sum == 0) {
        return "You are settled up";
      } else
        return "You owe " + (-sum).toString();
    }
  }

  @computed
  List<Widget> get groupTiles {
    List<Widget> a = [];
    if (groupOperation == null)
      groupOperation =
          APIService.getGroupData(loadOperation.value!.groups!).asObservable();
    else {
      if (groupOperation.value != null) {
        groupOperation.value!.forEach((element) {
          a.add(GroupTile(
            title: element!.title!,
            text1: calculate(element!.memberOwes!),
            model: element,
          ));
          getActivityDataPerGroup(element.sId!);
        });
      }
    }
    groupTilesList = ObservableList.of(a);
    return a;
  }

  @action
  getActivityDataPerGroup(String groupId) async {
    List<ExpenseModel> expenses = await APIService.getGroupExpenses(groupId);
    List<Widget> a = [];
    expenses.forEach((element) {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element.date!);
      element.owe!.forEach((key, value) {
        a.add(ActivityTile(
          title: "You added ${element.title!}",
          text1: (element.owe![uid]! > 0)
              ? "You get back ${-element.owe![uid]!}"
              : "You owe ${element.owe![uid]!}",
          text2: parseDate.day.toString() +
              "/" +
              parseDate.month.toString() +
              " " +
              parseDate.hour.toString() +
              ":" +
              parseDate.minute.toString(),
          isDeleted: false,
        ));
      });
    });
    activityTiles.addAll(ObservableList.of(a));
  }

  Map<int, String> monthsMap = {
    1: 'January',
    2: 'February',
    3: 'March',
    4: 'April',
    5: 'May',
    6: 'June',
    7: 'July',
    8: 'August',
    9: 'September',
    10: 'October',
    11: 'November',
    12: 'December',
  };
}
