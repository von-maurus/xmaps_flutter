import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/blocs.dart';
import 'package:xmaps_app/views/loading_view.dart';
import 'package:xmaps_app/services/services.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        // IMPORTANT: Order matters!, the first bloc to create on the array doesn't know anything about other BLOCS.
        // So, order them properly.
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
        BlocProvider(create: (context) => SearchDestinationBloc(trafficService: TrafficService())),
      ],
      child: const XMapsApp(),
    ),
  );
}

class XMapsApp extends StatelessWidget {
  const XMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xMaps',
      home: Scaffold(
        body: LoadingView(),
      ),
    );
  }
}
