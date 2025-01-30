import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/gps/gps_bloc.dart';
import 'package:xmaps_app/common/widgets/loading_widget.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GpsBloc(),
        ),
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
        body: const LoadingWidget(),
      ),
    );
  }
}
