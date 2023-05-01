// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  late final _$userDataAtom =
      Atom(name: '_LoginStore.userData', context: context);

  @override
  ObservableMap<String, String> get userData {
    _$userDataAtom.reportRead();
    return super.userData;
  }

  @override
  set userData(ObservableMap<String, String> value) {
    _$userDataAtom.reportWrite(value, super.userData, () {
      super.userData = value;
    });
  }

  late final _$_LoginStoreActionController =
      ActionController(name: '_LoginStore', context: context);

  @override
  void saveToPreferences(
      SharedPreferences instance, String name, String? image) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.saveToPreferences');
    try {
      return super.saveToPreferences(instance, name, image);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveToUserData(SharedPreferences instance) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.saveToUserData');
    try {
      return super.saveToUserData(instance);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void logOut(SharedPreferences instance) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.logOut');
    try {
      return super.logOut(instance);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveImagePathToPreferences(SharedPreferences instance, String path) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.saveImagePathToPreferences');
    try {
      return super.saveImagePathToPreferences(instance, path);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userData: ${userData}
    ''';
  }
}
