import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchLocationResult {
  final bool canceled;
  final bool manual;
  final LatLng? position;
  final String? name;
  final String? description;
  SearchLocationResult({
    required this.canceled,
    this.manual = false,
    this.position,
    this.name,
    this.description,
  });

  @override
  String toString() {
    return 'SearchLocationResult(canceled: $canceled, manual: $manual)';
  }
}
