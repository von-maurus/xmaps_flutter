import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xmaps_app/blocs/blocs.dart';

class MapWidget extends StatelessWidget {
  final LatLng initialPosition;

  const MapWidget({super.key, required this.initialPosition});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: GoogleMap(
            style: mapBloc.mapStyle,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 19.5,
              bearing: -10,
              tilt: 100,
            ),
            onMapCreated: (controller) => mapBloc.add(OnMapInitialized(controller)),
            // TODO: polylines
            // TODO: map movement
            // TODO: markers
          ),
        );
      },
    );
  }
}
