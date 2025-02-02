import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/blocs.dart';

class ToggleUserRouteBtnWidget extends StatelessWidget {
  const ToggleUserRouteBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 28,
        child: IconButton(
          icon: const Icon(Icons.more_horiz_rounded),
          onPressed: () => mapBloc.add(OnToggleUserRoute()),
        ),
      ),
    );
  }
}
