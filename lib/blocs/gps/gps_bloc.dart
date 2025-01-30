import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  StreamSubscription? streamGpsSubscription;
  
  GpsBloc() : super(const GpsState(isGPSEnable: false, isGPSPermissionGranted: false)) {
    on<GpsAndPermissionEvent>((event, emit) {
      emit(state.copyWith(
        isGPSEnable: event.isGPSEnable,
        isGPSPermissionGranted: event.isGPSPermissionGranted,
      ));
    });
    _init();
  }

  Future _init() async {
    final isEnabled = await _checkGpsStatus();
    final isGranted = await _isPermissionGranted();
    add(GpsAndPermissionEvent(isGPSEnable: isEnabled, isGPSPermissionGranted: isGranted));
  }

  Future<bool> _checkGpsStatus() async {
    final isEnable = await Geolocator.isLocationServiceEnabled();
    Geolocator.getServiceStatusStream().listen((event) {
      print("GPS changed: isGPSEnable -> $event | isGPSPermissionGranted -> ${state.isGPSPermissionGranted}");
      add(GpsAndPermissionEvent(isGPSEnable: event.index == 1, isGPSPermissionGranted: state.isGPSPermissionGranted));
    });
    return isEnable;
  }

  Future<bool> _isPermissionGranted() async {
    final status = await Permission.location.status;
    return status == PermissionStatus.granted;
  }

  Future<void> askGpsAccess() async {
    final status = await Permission.location.request();
    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(isGPSEnable: state.isGPSEnable, isGPSPermissionGranted: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.limited:
      case PermissionStatus.restricted:
      case PermissionStatus.provisional:
        add(GpsAndPermissionEvent(isGPSEnable: state.isGPSEnable, isGPSPermissionGranted: false));
        openAppSettings();
        break;
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    streamGpsSubscription?.cancel();
    return super.close();
  }
}
