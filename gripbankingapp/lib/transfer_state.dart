part of 'transfer_cubit.dart';

@immutable

abstract class TransferState {}

class TransferInitial extends TransferState {}
class TransferError extends TransferState{}