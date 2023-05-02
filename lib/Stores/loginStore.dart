import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobx/mobx.dart';

part 'loginStore.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    autorun((p0) {
      getUserData();
    });
  }

  @observable
  Observable<String> name = Observable("");

  @observable
  Observable<String> phoneNumber = Observable("");

  @observable
  Observable<String> auth = Observable("");

  @observable
  Observable<String> image = Observable("");

  @observable
  Observable<String> uid = Observable("");

  @action
  Future<void> getUserData() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    auth = Observable(instance.getString("auth") ?? "");
    name = Observable(instance.getString("name") ?? "");
    uid = Observable(instance.getString("uid") ?? "");
    image = Observable(instance.getString("image") ?? "");
    phoneNumber = Observable(instance.getString("phone") ?? "");
  }

  Future<void> saveToServer() async {
    FirebaseFirestore.instance.collection('users').doc(uid.value).set({
      'name': name.value,
      'image': image.value,
      'phone' : phoneNumber.value,
    });
  }

  Future<void> saveNameToPrefernces(String userName) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setString("name", userName);
    name = Observable<String>(userName);
    saveToServer();
  }

  Future<void> saveImageToPrefernces(String img) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setString("image", img);
    image = Observable(img);
    saveToServer();
  }

  Future<void> savePhoneToPrefernces(String phone) async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    instance.setString("phone", phone);
    phoneNumber = Observable<String>(phone);
    saveToServer();
  }

  @action
  Future<void> logout() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    name = Observable("");
    auth = Observable("");
    image = Observable("");
    phoneNumber = Observable("");
    instance.clear();
  }
}
