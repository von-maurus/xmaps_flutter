import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xmaps_app/blocs/blocs.dart';

class MapWidget extends StatelessWidget {
  final Set<Polyline> polylines;
  final Set<Marker> markers;
  final LatLng initialPosition;

  const MapWidget({super.key, required this.initialPosition, required this.polylines, required this.markers});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          child: Listener(
            onPointerMove: (_) => mapBloc.add(const OnStopFollowingUser()),
            child: GoogleMap(
              key: key,
              mapToolbarEnabled: false,
              buildingsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              compassEnabled: false,
              mapType: MapType.satellite,
              polylines: polylines,
              markers: markers,
              style: mapBloc.mapStyle,
              onCameraMove: (position) => mapBloc.mapCenter = position.target,
              onMapCreated: (controller) => mapBloc.add(OnMapInitialized(controller)),
              initialCameraPosition: CameraPosition(
                target: initialPosition,
                zoom: 15,
                bearing: -10,
                tilt: 90,
              ),
            ),
          ),
        );
      },
    );
  }
}
