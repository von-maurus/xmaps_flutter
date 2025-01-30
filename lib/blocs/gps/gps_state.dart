part of 'gps_bloc.dart';

class GpsState extends Equatable {
  final bool isGPSEnable;
  final bool isGPSPermissionGranted;

  bool get hasAllPermissions => isGPSEnable && isGPSPermissionGranted;

  const GpsState({required this.isGPSEnable, required this.isGPSPermissionGranted});

  @override
  List<Object> get props => [isGPSEnable, isGPSPermissionGranted];

  @override
  String toString() {
    return "{ isGPSEnable: $isGPSEnable, isGPSPermissionGranted: $isGPSPermissionGranted }";
  }

  GpsState copyWith({bool? isGPSEnable, bool? isGPSPermissionGranted}) {
    return GpsState(
      isGPSEnable: isGPSEnable ?? this.isGPSEnable,
      isGPSPermissionGranted: isGPSPermissionGranted ?? this.isGPSPermissionGranted,
    );
  }
}
