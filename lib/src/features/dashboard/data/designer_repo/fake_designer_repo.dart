// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:home_front_pk/src/constants/ktest_designer_list.dart';
import 'package:home_front_pk/src/features/dashboard/domain/designer.dart';
import 'package:home_front_pk/src/utils/delay.dart';

class FakeDesignerRepository {
  FakeDesignerRepository({
    this.addDelay = true,
  });
  bool addDelay;
  //private constructor so object can not be initiated outside
  // of this class
  // FakeDesignerRepository._();

  //Singleton to solve the issue of
  //Dependancy Injection Problem
  //Changed later
  // static FakeDesignerRepository instance = FakeDesignerRepository._();
  final List<DesignerIslamabad> _designerList = ktestDesigner;

  List<DesignerIslamabad> getDesignerList() {
    return _designerList;
  }

  //      Incase if we need Construcor bases of Id

  DesignerIslamabad? getDesigner(String id) {
    return _getDesigner(_designerList, id);
  }

  Future<List<DesignerIslamabad>> fetchDesignerList() async {
    await delay(true);
    return Future.value(_designerList);
  }

  Stream<List<DesignerIslamabad>> watchDesignerList() async* {
    await delay(true);
    yield _designerList;
  }

  // Getting constructor base on id

  Stream<DesignerIslamabad?> watchDesigner(String id) {
    return watchDesignerList()
        .map((designerList) => _getDesigner(designerList, id));
  }

  static DesignerIslamabad? _getDesigner(
      List<DesignerIslamabad> designers, String id) {
    try {
      return designers.firstWhere((designer) => designer.id == id);
    } catch (e) {
      return null;
    }
  }
}

final designerRepositoryProvider = Provider<FakeDesignerRepository>((ref) {
  return FakeDesignerRepository();
});

final designersListFutureProvider =
    FutureProvider.autoDispose<List<DesignerIslamabad>>((ref) {
  final designerRepository = ref.watch(designerRepositoryProvider);

  return designerRepository.fetchDesignerList();
});

final designersListStreamProvider =
    StreamProvider.autoDispose<List<DesignerIslamabad>>((ref) {
  final designerRepository = ref.watch(designerRepositoryProvider);
  return designerRepository.watchDesignerList();
});

final designerProvider =
    StreamProvider.autoDispose.family<DesignerIslamabad?, String>((ref, id) {
  final designerRepository = ref.watch(designerRepositoryProvider);
  return designerRepository.watchDesigner(id);
});
