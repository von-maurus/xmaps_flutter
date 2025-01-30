import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/blocs.dart';
import 'package:xmaps_app/common/widgets/widgets.dart';
import 'package:xmaps_app/views/maps/map_widget.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapView> {
  late LocationBloc locationBloc;

  @override
  void initState() {
    locationBloc = BlocProvider.of<LocationBloc>(context);
    locationBloc.startTracking();
    super.initState();
  }

  @override
  void dispose() {
    locationBloc.stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CurrentLocationBtnWidget(),
        ],
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state.lastKnownLocation == null) {
            return const Center(child: Text("Waiting new location..."));
          }
          return Stack(
            children: [
              MapWidget(initialPosition: state.lastKnownLocation!),
              // ElevatedButton(onPressed: () {}, child: Text('BUTTON')),
              // ElevatedButton(onPressed: () {}, child: Text('BUTTON')),
              // ElevatedButton(onPressed: () {}, child: Text('BUTTON')),
              // ElevatedButton(onPressed: () {}, child: Text('BUTTON')),
            ],
          );
        },
      ),
    );
  }
}
