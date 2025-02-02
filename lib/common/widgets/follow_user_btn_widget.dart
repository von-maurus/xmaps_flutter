import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/blocs.dart';

class FollowUserBtnWidget extends StatelessWidget {
  const FollowUserBtnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 28,
        child: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            return IconButton(
              icon: Icon(state.followUser ? Icons.directions_run_rounded : Icons.hail_rounded),
              onPressed: () {
                final mapBloc = BlocProvider.of<MapBloc>(context);
                mapBloc.add(const OnStartFollowingUser());
              },
            );
          },
        ),
      ),
    );
  }
}
