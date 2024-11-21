// wallet_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get current user wallet
  Stream<double> getWalletBalance() {
    return _firestore
        .collection('wallets')
        .doc(_auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) => (snapshot.data()?['balance'] ?? 0.0).toDouble());
  }

  // Add money to wallet
  Future<void> addMoneyToWallet(double amount) async {
    try {
      final walletRef =
          _firestore.collection('wallets').doc(_auth.currentUser?.uid);

      // First check if wallet document exists
      final walletDoc = await walletRef.get();

      if (!walletDoc.exists) {
        // If wallet doesn't exist, create it with initial amount
        await walletRef.set({
          'balance': amount,
          'lastUpdated': Timestamp.now(),
          'userId': _auth.currentUser?.uid,
        });
      } else {
        // If wallet exists, update the balance
        await walletRef.update({
          'balance': FieldValue.increment(amount),
          'lastUpdated': Timestamp.now(),
        });
      }

      // Add transaction history
      await _firestore.collection('transactions').add({
        'userId': _auth.currentUser?.uid,
        'type': 'deposit',
        'amount': amount,
        'timestamp': Timestamp.now(),
        'status': 'completed',
        'description': 'Money added to wallet'
      });
    } catch (e) {
      throw Exception('Failed to add money to wallet: $e');
    }
  }

  // Deduct money from wallet
  Future<bool> deductFromWallet(double amount) async {
    try {
      final walletRef =
          _firestore.collection('wallets').doc(_auth.currentUser?.uid);

      // Get current balance
      final walletDoc = await walletRef.get();
      if (!walletDoc.exists) {
        return false;
      }

      final currentBalance = (walletDoc.data()?['balance'] ?? 0.0).toDouble();

      if (currentBalance >= amount) {
        await walletRef.update({
          'balance': FieldValue.increment(-amount),
          'lastUpdated': Timestamp.now(),
        });

        // Add transaction record
        await _firestore.collection('transactions').add({
          'userId': _auth.currentUser?.uid,
          'type': 'withdrawal',
          'amount': amount,
          'timestamp': Timestamp.now(),
          'status': 'completed',
          'description': 'Payment deducted'
        });

        return true;
      }

      return false;
    } catch (e) {
      throw Exception('Failed to deduct from wallet: $e');
    }
  }

  // Get transaction history
  Stream<List<Map<String, dynamic>>> getTransactionHistory() {
    return _firestore
        .collection('transactions')
        .where('userId', isEqualTo: _auth.currentUser?.uid)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {
                  ...doc.data(),
                  'id': doc.id,
                })
            .toList());
  }

  // Initialize wallet for new user
  Future<void> initializeWallet() async {
    try {
      final walletRef =
          _firestore.collection('wallets').doc(_auth.currentUser?.uid);
      final walletDoc = await walletRef.get();

      if (!walletDoc.exists) {
        await walletRef.set({
          'balance': 0.0,
          'lastUpdated': Timestamp.now(),
          'userId': _auth.currentUser?.uid,
          'createdAt': Timestamp.now(),
        });
      }
    } catch (e) {
      throw Exception('Failed to initialize wallet: $e');
    }
  }
}
