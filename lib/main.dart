import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/blocs.dart';
import 'package:xmaps_app/views/loading_view.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GpsBloc()),
        BlocProvider(create: (context) => LocationBloc()),
        BlocProvider(create: (context) => MapBloc()),
      ],
      child: const XMapsApp(),
    ),
  );
}

class XMapsApp extends StatelessWidget {
  const XMapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'xMaps',
      home: Scaffold(
        appBar: AppBar(title: const Text('xMaps')),
        body: const LoadingView(),
      ),
    );
  }
}
