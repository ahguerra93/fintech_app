import 'package:fintech_app/features/transfers/data/datasources/transfer_datasource.dart';
import 'package:fintech_app/features/transfers/domain/models/transfer_model.dart';
import 'package:fintech_app/features/transfers/domain/repositories/transfer_repository.dart';

class TransferRepositoryImpl implements TransferRepository {
  final TransferDataSource dataSource;
  TransferRepositoryImpl({required this.dataSource});

  @override
  Future<bool> transfer(TransferModel data) async {
    return await dataSource.transfer(data);
  }
}
