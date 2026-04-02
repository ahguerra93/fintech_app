import 'package:fintech_app/features/transfers/domain/models/transfer_model.dart';

abstract class TransferDataSource {
  Future<bool> transfer(TransferModel data);
}

class TransferDataSourceImpl implements TransferDataSource {
  @override
  Future<bool> transfer(TransferModel data) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // Dummy logic: always succeed
    return true;
  }
}
