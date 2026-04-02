import 'package:fintech_app/features/transfers/domain/models/transfer_model.dart';
import 'package:fintech_app/features/transfers/domain/repositories/transfer_repository.dart';

class TransferUseCase {
  final TransferRepository repository;
  TransferUseCase({required this.repository});

  Future<bool> call(TransferModel data) async {
    return await repository.transfer(data);
  }
}
