class SearchLocationResult {
  final bool canceled;
  final bool manual;

  SearchLocationResult({
    required this.canceled,
    this.manual = false,
  });

  // TODO: Nombre, descripcion, posicion,

  @override
  String toString() {
    return 'SearchLocationResult(canceled: $canceled, manual: $manual)';
  }
}
