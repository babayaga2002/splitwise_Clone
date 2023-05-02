// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on _LoginStore, Store {
  late final _$nameAtom = Atom(name: '_LoginStore.name', context: context);

  @override
  Observable<String> get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(Observable<String> value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: '_LoginStore.phoneNumber', context: context);

  @override
  Observable<String> get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(Observable<String> value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$authAtom = Atom(name: '_LoginStore.auth', context: context);

  @override
  Observable<String> get auth {
    _$authAtom.reportRead();
    return super.auth;
  }

  @override
  set auth(Observable<String> value) {
    _$authAtom.reportWrite(value, super.auth, () {
      super.auth = value;
    });
  }

  late final _$imageAtom = Atom(name: '_LoginStore.image', context: context);

  @override
  Observable<String> get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(Observable<String> value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$uidAtom = Atom(name: '_LoginStore.uid', context: context);

  @override
  Observable<String> get uid {
    _$uidAtom.reportRead();
    return super.uid;
  }

  @override
  set uid(Observable<String> value) {
    _$uidAtom.reportWrite(value, super.uid, () {
      super.uid = value;
    });
  }

  late final _$getUserDataAsyncAction =
      AsyncAction('_LoginStore.getUserData', context: context);

  @override
  Future<void> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  late final _$logoutAsyncAction =
      AsyncAction('_LoginStore.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
name: ${name},
phoneNumber: ${phoneNumber},
auth: ${auth},
image: ${image},
uid: ${uid}
    ''';
  }
}
