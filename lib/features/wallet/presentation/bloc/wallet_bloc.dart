import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../domain/entities/wallet.dart';
import '../../domain/entities/wallet.dart' show WalletTransaction;
import '../../domain/usecases/get_wallet.dart';
import '../../domain/usecases/add_funds.dart';
import '../../domain/usecases/pay_with_wallet.dart';
import '../../domain/usecases/set_wallet_enabled.dart';
import '../../domain/repositories/wallet_repository.dart';

/// Events that can be dispatched to the [WalletBloc].
sealed class WalletEvent {
  const WalletEvent();
}

/// Load the wallet and its transactions from the repository.
class LoadWallet extends WalletEvent {
  const LoadWallet();
}

/// Refresh the wallet data.
class RefreshWallet extends WalletEvent {
  const RefreshWallet();
}

/// Add funds to the wallet.
class AddFundsEvent extends WalletEvent {
  const AddFundsEvent({required this.amount, required this.currency});
  final double amount;
  final String currency;
}

/// Attempt to pay for an order using the wallet.
class PayWithWalletEvent extends WalletEvent {
  const PayWithWalletEvent({
    required this.price,
    required this.currency,
    this.autoTopUpDifference = true,
    this.reference,
  });
  final double price;
  final String currency;
  final bool autoTopUpDifference;
  final String? reference;
}

/// Enable or disable the wallet.
class SetWalletEnabledEvent extends WalletEvent {
  const SetWalletEnabledEvent({required this.enabled});
  final bool enabled;
}

/// States emitted by the [WalletBloc].
sealed class WalletState {
  const WalletState();
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  const WalletLoading();
}

class WalletLoaded extends WalletState {
  const WalletLoaded({required this.wallet, required this.transactions});
  final Wallet wallet;
  final List<WalletTransaction> transactions;
}

class WalletError extends WalletState {
  const WalletError(this.error);
  final Object error;
}

/// A Bloc that manages a single user wallet. It orchestrates loading the
/// wallet, adding funds, paying for purchases and enabling/disabling the
/// wallet. It also fetches transaction history when loading or refreshing.
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc({
    required this.walletId,
    required GetWallet getWallet,
    required AddFunds addFunds,
    required PayWithWallet payWithWallet,
    required SetWalletEnabled setWalletEnabled,
    required WalletRepository repository,
  })  : _getWallet = getWallet,
        _addFunds = addFunds,
        _payWithWallet = payWithWallet,
        _setWalletEnabled = setWalletEnabled,
        _repo = repository,
        super(const WalletInitial()) {
    on<LoadWallet>(_onLoadWallet);
    on<RefreshWallet>(_onLoadWallet);
    on<AddFundsEvent>(_onAddFunds);
    on<PayWithWalletEvent>(_onPay);
    on<SetWalletEnabledEvent>(_onSetEnabled);
  }

  final String walletId;
  final GetWallet _getWallet;
  final AddFunds _addFunds;
  final PayWithWallet _payWithWallet;
  final SetWalletEnabled _setWalletEnabled;
  final WalletRepository _repo;

  Future<void> _onLoadWallet(WalletEvent event, Emitter<WalletState> emit) async {
    emit(const WalletLoading());
    try {
      final wallet = await _getWallet(walletId);
      final transactions = await _repo.listTransactions(walletId);
      emit(WalletLoaded(wallet: wallet, transactions: transactions));
    } catch (e) {
      emit(WalletError(e));
    }
  }

  Future<void> _onAddFunds(AddFundsEvent event, Emitter<WalletState> emit) async {
    emit(const WalletLoading());
    try {
      final wallet = await _addFunds(walletId, amount: event.amount, currency: event.currency);
      final transactions = await _repo.listTransactions(walletId);
      emit(WalletLoaded(wallet: wallet, transactions: transactions));
    } catch (e) {
      emit(WalletError(e));
    }
  }

  Future<void> _onPay(PayWithWalletEvent event, Emitter<WalletState> emit) async {
    emit(const WalletLoading());
    try {
      final result = await _payWithWallet(
        walletId,
        price: event.price,
        currency: event.currency,
        autoTopUpDifference: event.autoTopUpDifference,
        reference: event.reference,
      );
      final wallet = result.$1;
      final transactions = await _repo.listTransactions(walletId);
      emit(WalletLoaded(wallet: wallet, transactions: transactions));
    } catch (e) {
      emit(WalletError(e));
    }
  }

  Future<void> _onSetEnabled(SetWalletEnabledEvent event, Emitter<WalletState> emit) async {
    emit(const WalletLoading());
    try {
      final wallet = await _setWalletEnabled(walletId, enabled: event.enabled);
      final transactions = await _repo.listTransactions(walletId);
      emit(WalletLoaded(wallet: wallet, transactions: transactions));
    } catch (e) {
      emit(WalletError(e));
    }
  }
}