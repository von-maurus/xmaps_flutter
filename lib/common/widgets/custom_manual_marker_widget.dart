import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/blocs.dart';
import 'package:xmaps_app/helpers/helpers.dart';

class CustomManualMarkerWidget extends StatelessWidget {
  const CustomManualMarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchDestinationBloc, SearchDestinationState>(
      builder: (context, state) {
        return state.displayManualMarker ? const _ManualMarkerBody() : const SizedBox.shrink();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchBloc = BlocProvider.of<SearchDestinationBloc>(context);
    final locBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(
            left: 20,
            top: 40,
            child: _BackBtn(),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(-10, -25),
              child: BounceInDown(from: 100, child: const Icon(Icons.location_on_rounded, size: 60)),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width - 120,
                color: Colors.black,
                elevation: 0,
                height: 50,
                shape: const StadiumBorder(),
                child: const Text(
                  "Confirm destination",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                ),
                onPressed: () async {
                  final start = locBloc.state.lastKnownLocation;
                  if (start == null) return;

                  final end = mapBloc.mapCenter;
                  if (end == null) return;

                  showLoadingMessage(context);
                  final destination = await searchBloc.getNewRoute(start, end);
                  await mapBloc.drawRouteDestination(destination);
                  searchBloc.add(const OnDeactivateManualMarkerEvent());
                  if (context.mounted) Navigator.of(context).pop();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BackBtn extends StatelessWidget {
  const _BackBtn();

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: Center(
          child: IconButton(
            icon: Icon(
              Platform.isAndroid ? Icons.arrow_back_rounded : Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              final searchBloc = BlocProvider.of<SearchDestinationBloc>(context);
              searchBloc.add(const OnDeactivateManualMarkerEvent());
            },
          ),
        ),
      ),
    );
  }
}
