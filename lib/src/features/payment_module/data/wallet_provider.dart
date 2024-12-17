// wallet_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/payment_module/data/wallet_repo.dart';

final walletRepositoryProvider = Provider<WalletRepository>((ref) {
  return WalletRepository();
});

final walletBalanceProvider = StreamProvider.autoDispose<double>((ref) {
  final repository = ref.watch(walletRepositoryProvider);
  return repository.getWalletBalance();
});

final transactionHistoryProvider =
    StreamProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
  final repository = ref.watch(walletRepositoryProvider);
  return repository.getTransactionHistory();
});

// Provider to handle wallet operations
final walletOperationsProvider = Provider((ref) {
  final repository = ref.watch(walletRepositoryProvider);

  return WalletOperations(addMoney: (double amount) async {
    try {
      await repository.addMoneyToWallet(amount);
      return true;
    } catch (e) {
      return false;
    }
  }, deductMoney: (double amount) async {
    try {
      return await repository.deductFromWallet(amount);
    } catch (e) {
      return false;
    }
  }, initializeWallet: () async {
    try {
      await repository.initializeWallet();
      return true;
    } catch (e) {
      return false;
    }
  });
});

class WalletOperations {
  final Future<bool> Function(double amount) addMoney;
  final Future<bool> Function(double amount) deductMoney;
  final Future<bool> Function() initializeWallet;

  WalletOperations({
    required this.addMoney,
    required this.deductMoney,
    required this.initializeWallet,
  });
}
