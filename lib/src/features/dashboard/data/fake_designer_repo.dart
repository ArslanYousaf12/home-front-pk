import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/constants/ktest_designer_list.dart';

import 'package:home_front_pk/src/features/dashboard/domain/designer.dart';

class FakeDesignerRepository {
  //private constructor so object can not be initiated outside
  // of this class
  // FakeDesignerRepository._();

  //Singleton to solve the issue of
  //Dependancy Injection Problem
  //Changed later
  // static FakeDesignerRepository instance = FakeDesignerRepository._();
  final List<DesignerIslamabad> _designerList = ktestDesigner;

  List<DesignerIslamabad> getConstructorList() {
    return _designerList;
  }

  //      Incase if we need Construcor bases of Id

  DesignerIslamabad? getDesigner(String id) {
    try {
      return _designerList.firstWhere((designer) => designer.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<DesignerIslamabad>> fetchDesignerList() {
    return Future.value(_designerList);
  }

  Stream<List<DesignerIslamabad>> watchDesignerList() {
    return Stream.value(_designerList);
  }

  // Getting constructor base on id

  Stream<DesignerIslamabad?> watchDesigner(String id) {
    return watchDesignerList().map((designerList) =>
        designerList.firstWhere((designer) => designer.id == id));
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
