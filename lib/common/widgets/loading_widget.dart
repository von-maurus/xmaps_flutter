import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/gps/gps_bloc.dart';
import 'package:xmaps_app/views/maps/gps_access_widget.dart';
import 'package:xmaps_app/views/maps/map_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.hasAllPermissions ? const MapWidget() : const GpsAccessWidget();
        },
      ),
    );
  }
}
