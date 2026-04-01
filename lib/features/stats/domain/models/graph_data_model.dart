class GraphDataModel {
  final List<double> values;
  final List<String> labels;

  const GraphDataModel({required this.values, required this.labels});

  GraphDataModel copyWith({List<double>? values, List<String>? labels}) {
    return GraphDataModel(values: values ?? this.values, labels: labels ?? this.labels);
  }
}
