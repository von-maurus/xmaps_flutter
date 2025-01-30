import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/gps/gps_bloc.dart';
import 'package:xmaps_app/views/views.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return state.hasAllPermissions ? const MapView() : const GpsAccessView();
        },
      ),
    );
  }
}
