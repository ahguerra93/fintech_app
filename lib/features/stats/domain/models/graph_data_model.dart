import 'package:fintech_app/features/stats/domain/models/graph_data_item.dart';

class GraphDataModel {
  final List<GraphDataItem> items;

  const GraphDataModel({required this.items});

  GraphDataModel copyWith({List<GraphDataItem>? items}) {
    return GraphDataModel(items: items ?? this.items);
  }
}
