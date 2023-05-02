// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homeStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  Computed<List<Widget>>? _$friendsTilesComputed;

  @override
  List<Widget> get friendsTiles => (_$friendsTilesComputed ??=
          Computed<List<Widget>>(() => super.friendsTiles,
              name: '_HomeStore.friendsTiles'))
      .value;
  Computed<List<Widget>>? _$friendsTilesAddGroupPageComputed;

  @override
  List<Widget> get friendsTilesAddGroupPage =>
      (_$friendsTilesAddGroupPageComputed ??= Computed<List<Widget>>(
              () => super.friendsTilesAddGroupPage,
              name: '_HomeStore.friendsTilesAddGroupPage'))
          .value;
  Computed<String>? _$titleStringComputed;

  @override
  String get titleString =>
      (_$titleStringComputed ??= Computed<String>(() => super.titleString,
              name: '_HomeStore.titleString'))
          .value;
  Computed<List<Widget>>? _$groupTilesComputed;

  @override
  List<Widget> get groupTiles =>
      (_$groupTilesComputed ??= Computed<List<Widget>>(() => super.groupTiles,
              name: '_HomeStore.groupTiles'))
          .value;

  late final _$uidAtom = Atom(name: '_HomeStore.uid', context: context);

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

  late final _$indexAddExpenseAtom =
      Atom(name: '_HomeStore.indexAddExpense', context: context);

  @override
  int get indexAddExpense {
    _$indexAddExpenseAtom.reportRead();
    return super.indexAddExpense;
  }

  @override
  set indexAddExpense(int value) {
    _$indexAddExpenseAtom.reportWrite(value, super.indexAddExpense, () {
      super.indexAddExpense = value;
    });
  }

  late final _$loadOperationAtom =
      Atom(name: '_HomeStore.loadOperation', context: context);

  @override
  ObservableFuture<UserModel?> get loadOperation {
    _$loadOperationAtom.reportRead();
    return super.loadOperation;
  }

  @override
  set loadOperation(ObservableFuture<UserModel?> value) {
    _$loadOperationAtom.reportWrite(value, super.loadOperation, () {
      super.loadOperation = value;
    });
  }

  late final _$groupOperationAtom =
      Atom(name: '_HomeStore.groupOperation', context: context);

  @override
  ObservableFuture<List<GroupModel?>> get groupOperation {
    _$groupOperationAtom.reportRead();
    return super.groupOperation;
  }

  @override
  set groupOperation(ObservableFuture<List<GroupModel?>> value) {
    _$groupOperationAtom.reportWrite(value, super.groupOperation, () {
      super.groupOperation = value;
    });
  }

  late final _$friendOperationAtom =
      Atom(name: '_HomeStore.friendOperation', context: context);

  @override
  ObservableFuture<Map<String, String>> get friendOperation {
    _$friendOperationAtom.reportRead();
    return super.friendOperation;
  }

  @override
  set friendOperation(ObservableFuture<Map<String, String>> value) {
    _$friendOperationAtom.reportWrite(value, super.friendOperation, () {
      super.friendOperation = value;
    });
  }

  late final _$GroupMemberNameAtom =
      Atom(name: '_HomeStore.GroupMemberName', context: context);

  @override
  ObservableMap<String, Map<String, String>> get GroupMemberName {
    _$GroupMemberNameAtom.reportRead();
    return super.GroupMemberName;
  }

  @override
  set GroupMemberName(ObservableMap<String, Map<String, String>> value) {
    _$GroupMemberNameAtom.reportWrite(value, super.GroupMemberName, () {
      super.GroupMemberName = value;
    });
  }

  late final _$groupTilesListAtom =
      Atom(name: '_HomeStore.groupTilesList', context: context);

  @override
  ObservableList<Widget> get groupTilesList {
    _$groupTilesListAtom.reportRead();
    return super.groupTilesList;
  }

  @override
  set groupTilesList(ObservableList<Widget> value) {
    _$groupTilesListAtom.reportWrite(value, super.groupTilesList, () {
      super.groupTilesList = value;
    });
  }

  late final _$groupTilesAddExpenseListAtom =
      Atom(name: '_HomeStore.groupTilesAddExpenseList', context: context);

  @override
  ObservableList<Widget> get groupTilesAddExpenseList {
    _$groupTilesAddExpenseListAtom.reportRead();
    return super.groupTilesAddExpenseList;
  }

  @override
  set groupTilesAddExpenseList(ObservableList<Widget> value) {
    _$groupTilesAddExpenseListAtom
        .reportWrite(value, super.groupTilesAddExpenseList, () {
      super.groupTilesAddExpenseList = value;
    });
  }

  late final _$friendsTilesListAtom =
      Atom(name: '_HomeStore.friendsTilesList', context: context);

  @override
  ObservableList<Widget> get friendsTilesList {
    _$friendsTilesListAtom.reportRead();
    return super.friendsTilesList;
  }

  @override
  set friendsTilesList(ObservableList<Widget> value) {
    _$friendsTilesListAtom.reportWrite(value, super.friendsTilesList, () {
      super.friendsTilesList = value;
    });
  }

  late final _$friendsNameToUidAtom =
      Atom(name: '_HomeStore.friendsNameToUid', context: context);

  @override
  ObservableMap<String, String> get friendsNameToUid {
    _$friendsNameToUidAtom.reportRead();
    return super.friendsNameToUid;
  }

  @override
  set friendsNameToUid(ObservableMap<String, String> value) {
    _$friendsNameToUidAtom.reportWrite(value, super.friendsNameToUid, () {
      super.friendsNameToUid = value;
    });
  }

  late final _$activityTilesAtom =
      Atom(name: '_HomeStore.activityTiles', context: context);

  @override
  ObservableList<Widget> get activityTiles {
    _$activityTilesAtom.reportRead();
    return super.activityTiles;
  }

  @override
  set activityTiles(ObservableList<Widget> value) {
    _$activityTilesAtom.reportWrite(value, super.activityTiles, () {
      super.activityTiles = value;
    });
  }

  late final _$getUidAsyncAction =
      AsyncAction('_HomeStore.getUid', context: context);

  @override
  Future<void> getUid() {
    return _$getUidAsyncAction.run(() => super.getUid());
  }

  late final _$getUserDataAsyncAction =
      AsyncAction('_HomeStore.getUserData', context: context);

  @override
  Future<void> getUserData() {
    return _$getUserDataAsyncAction.run(() => super.getUserData());
  }

  late final _$getMemberUIDToNameMapPerGroupAsyncAction =
      AsyncAction('_HomeStore.getMemberUIDToNameMapPerGroup', context: context);

  @override
  Future getMemberUIDToNameMapPerGroup() {
    return _$getMemberUIDToNameMapPerGroupAsyncAction
        .run(() => super.getMemberUIDToNameMapPerGroup());
  }

  late final _$getActivityDataPerGroupAsyncAction =
      AsyncAction('_HomeStore.getActivityDataPerGroup', context: context);

  @override
  Future getActivityDataPerGroup(String groupId) {
    return _$getActivityDataPerGroupAsyncAction
        .run(() => super.getActivityDataPerGroup(groupId));
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  void setIndex(int i) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.setIndex');
    try {
      return super.setIndex(i);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getData(UserModel user) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.getData');
    try {
      return super.getData(user);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
uid: ${uid},
indexAddExpense: ${indexAddExpense},
loadOperation: ${loadOperation},
groupOperation: ${groupOperation},
friendOperation: ${friendOperation},
GroupMemberName: ${GroupMemberName},
groupTilesList: ${groupTilesList},
groupTilesAddExpenseList: ${groupTilesAddExpenseList},
friendsTilesList: ${friendsTilesList},
friendsNameToUid: ${friendsNameToUid},
activityTiles: ${activityTiles},
friendsTiles: ${friendsTiles},
friendsTilesAddGroupPage: ${friendsTilesAddGroupPage},
titleString: ${titleString},
groupTiles: ${groupTiles}
    ''';
  }
}
