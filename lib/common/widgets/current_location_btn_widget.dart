import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/blocs.dart';
import 'package:xmaps_app/common/widgets/widgets.dart';

class CurrentLocationBtnWidget extends StatelessWidget {
  const CurrentLocationBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 28,
        child: IconButton(
          onPressed: () {
            final userLocation = locationBloc.state.lastKnownLocation;
            if (userLocation != null) {
              mapBloc.moveCamera(userLocation);
              return;
            }
            final snackBar = CustomSnackbar(content: 'Activate location...');
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
          icon: const Icon(Icons.my_location_outlined),
        ),
      ),
    );
  }
}
