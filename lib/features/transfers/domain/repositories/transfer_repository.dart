import 'package:fintech_app/features/transfers/domain/models/transfer_model.dart';

abstract class TransferRepository {
  Future<bool> transfer(TransferModel data);
}
