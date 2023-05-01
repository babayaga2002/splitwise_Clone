import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobx/mobx.dart';

part 'loginStore.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore();

  @observable
  ObservableMap<String, String> userData = ObservableMap<String,String>.of({});

  @action
  void saveToPreferences(SharedPreferences instance, String name, String? image) {
    Map<String,String>data={};
    data["auth"] = instance.getString("auth") ?? " ";
    data["name"] = name;
    data["image"]= image ?? "";
    instance.setString("name", name);
    instance.getString("image") ?? "";
    FirebaseFirestore.instance.collection('users').doc(userData["auth"]).set({
      'name': name,
      'image' : image ?? "",
    });
    userData=ObservableMap<String,String>.of(data);
  }

  @action
  void saveToUserData(SharedPreferences instance) {
    userData["auth"] = instance.getString("auth") ?? " ";
    userData["name"] = instance.getString("name") ?? " ";
    userData["image"] = instance.getString("image") ?? "";
  }

  @action
  void logOut(SharedPreferences instance){
    userData.clear();
    instance.clear();
  }

  @action
  void saveImagePathToPreferences(SharedPreferences instance,String path){
    userData["image"] = path;
    instance.setString("image", path);
    print(userData["image"]);
  }
}
