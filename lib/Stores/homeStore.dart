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
      return counter.value;
    }, (_) {
      getUserData();
    });
    reaction((_) {
      return loadOperation.value;
    }, (_) {
      getData(loadOperation.value!);
    });
    reaction((_) {
      return groupOperation.value;
    }, (_) {
      getMemberUIDToNameMapPerGroup();
    });
    autorun((p0) {
      getUserData();
      getUid();
      getMemberUIDToNameMapPerGroup();
    });
  }
  @observable
  Observable<String> uid = Observable("");

  @observable
  Observable<int> counter = Observable(0);

  @action
  void reset() {
    counter = Observable(counter.value + 1);
  }

  @observable
  int indexAddExpense = 0;

  @action
  void setIndex(int i) {
    indexAddExpense = i;
  }

  @observable
  ObservableFuture<UserModel?> loadOperation = ObservableFuture.value(null);

  @observable
  ObservableFuture<List<GroupModel?>> groupOperation =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<Map<String, String>> friendOperation =
      ObservableFuture.value({});

  @observable
  ObservableMap<String, Map<String, String>> GroupMemberName =
      ObservableMap.of({});

  @observable
  ObservableList<Widget> groupTilesList = ObservableList<Widget>.of([]);

  @observable
  ObservableList<Widget> groupTilesAddExpenseList =
      ObservableList<Widget>.of([]);

  @observable
  ObservableList<Widget> friendsTilesList = ObservableList<Widget>.of([]);

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
    if (loadOperation != null &&
        loadOperation.value != null &&
        loadOperation.value!.groups != null) {
      groupOperation =
          APIService.getGroupData(loadOperation.value!.groups!).asObservable();
      print(groupOperation.error);
    }
    if (loadOperation != null &&
        loadOperation.value != null &&
        loadOperation.value!.friends != null) {
      friendOperation =
          APIService.getFriendsData(loadOperation.value!.friends ?? [])
              .asObservable();
      friendsNameToUid = ObservableMap.of(friendOperation.value ?? {});
    }
  }

  @computed
  List<Widget> get friendsTiles {
    List<Widget> a = [];
    if (loadOperation == null) getUserData();
    if (friendOperation == null) {
      friendOperation =
          APIService.getFriendsData(loadOperation.value!.friends ?? [])
              .asObservable();
    } else {
      if (friendOperation.value != null) {
        friendsNameToUid = ObservableMap.of(friendOperation.value ?? {});
        friendOperation.value!.forEach((key, value) {
          a.add(FriendsTile(friendName: value, friendid: key));
        });
        friendsTilesList = ObservableList<Widget>.of(a);
      }
    }
    return a;
  }

  @computed
  List<Widget> get friendsTilesAddGroupPage {
    List<Widget> a = [];
    if (loadOperation == null) getUserData();
    if (friendOperation == null) {
      friendOperation =
          APIService.getFriendsData(loadOperation.value!.friends ?? [])
              .asObservable();
      friendsNameToUid = ObservableMap.of(friendOperation.value ?? {});
    } else {
      if (friendOperation.value != null) {
        friendOperation.value!.forEach((key, value) {
          a.add(FriendsTile(friendName: value, friendid: key));
        });
        friendsTilesList = ObservableList<Widget>.of(a);
      }
    }
    return a;
  }

  @computed
  String get titleString {
    String text = "";
    if (loadOperation == null) getUserData();
    if (loadOperation != null &&
        loadOperation.value != null &&
        loadOperation.value!.totalSpendings != null) {
      if (loadOperation.value!.totalSpendings! > 0) {
        text = "Total Spending for May:" +
            loadOperation.value!.totalSpendings.toString();
      } else if (loadOperation.value!.totalSpendings == 0) {
        text = "You are all settled-up";
      } else
        text = "Overall, you owe " +
            (-loadOperation.value!.totalSpendings!).toString();
    }
    return text;
  }

  String calculate(Map<String, dynamic> map) {
    num sum = 0;
    if (uid.value == "")
      return "";
    else {
      Map<String, num>? m = map[uid.value];
      if (m != null) {
        m.forEach((key, value) {
          sum += value;
        });
      }
      if (sum > 0) {
        return "You are owed " + (sum).toString();
      } else if (sum == 0) {
        return "You are settled up";
      } else
        return "You owe " + (-sum).toString();
    }
  }

  @computed
  List<Widget> get groupTiles {
    activityTiles = ObservableList<Widget>.of([]);
    List<Widget> a = [];
    if (groupOperation == null)
      groupOperation =
          APIService.getGroupData(loadOperation.value!.groups!).asObservable();
    else {
      if (groupOperation.value != null) {
        groupOperation.value!.forEach((element) {
          a.add(GroupTile(
            title: element!.title!,
            text1: calculate(element!.memberOwes ?? {}),
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
  getMemberUIDToNameMapPerGroup() async {
    Map<String, Map<String, String>> map = {};
    if (groupOperation.value != null && groupOperation.value!.isNotEmpty) {
      for (var element in groupOperation.value!) {
        Map<String, String> m =
            await APIService.getGroupMembersData(element!.members ?? []);
        map[element.sId!] = m;
      }
    }
    GroupMemberName = ObservableMap.of(map);
  }

  @action
  getActivityDataPerGroup(String groupId) async {
    List<ExpenseModel> expenses = await APIService.getGroupExpenses(groupId);
    List<Widget> a = [];
    if (expenses.isNotEmpty) {
      for (var element in expenses) {
        DateTime parseDate =
            new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element.date!);
        num x = element.owe?[uid.value] ?? 0;
        if (x < 0) {
          num amount = element.expense! + x;
          a.add(ActivityTile(
            title: "You added ${element.title!}",
            text1: "You get back ${amount}",
            text2: parseDate.day.toString() +
                "/" +
                parseDate.month.toString() +
                " " +
                parseDate.hour.toString() +
                ":" +
                parseDate.minute.toString(),
            isDeleted: false,
            color: Colors.green.shade400,
            text3: categories[element.category ?? 3]!,
          ));
        } else {
          a.add(ActivityTile(
            title:
                "${GroupMemberName.nonObservableInner[element.paidBy]} added ${element.title!}",
            text1: "You get back ${-x}",
            text2: parseDate.day.toString() +
                "/" +
                parseDate.month.toString() +
                " " +
                parseDate.hour.toString() +
                ":" +
                parseDate.minute.toString(),
            isDeleted: false,
            color: Colors.orange.shade400,
            text3: categories[element.category ?? 3]!,
          ));
        }
      }
      //   DateTime parseDate =
      //       new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element.date!);
      //   element.owe?.remove(element.paidBy);
      //   if (element.paidBy == uid.value) {
      //     element.owe?.forEach((key, value) {
      //       a.add(ActivityTile(
      //         title:
      //         "${GroupMemberName.nonObservableInner[element.paidBy]} added ${element.title!}",
      //         text1: "You get back ${value} from ${GroupMemberName.nonObservableInner[key]}",
      //         text2: parseDate.day.toString() +
      //             "/" +
      //             parseDate.month.toString() +
      //             " " +
      //             parseDate.hour.toString() +
      //             ":" +
      //             parseDate.minute.toString(),
      //         isDeleted: false,
      //         color: Colors.green.shade400,
      //       ));
      //     });
      //   }
      //   else{
      //     a.add(ActivityTile(
      //       title:
      //       "${this.GroupMemberName[element.paidBy]} added ${element.title!}",
      //       text1: "You borrowed ${element.owe?[uid.value]} from ${GroupMemberName[element.paidBy]}",
      //       text2: parseDate.day.toString() +
      //           "/" +
      //           parseDate.month.toString() +
      //           " " +
      //           parseDate.hour.toString() +
      //           ":" +
      //           parseDate.minute.toString(),
      //       isDeleted: false,
      //       color: Colors.orange.shade400,
      //     ));
      //   }
      // }
      if (a.isEmpty) a.add(Text("All Settled Group Expenses with Members"));
      activityTiles.addAll(ObservableList.of(a));
    }
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

  Map<int, String> categories = {
    0: "Trip",
    1: "Food",
    2: "Travel",
    3: "Other",
  };
}
