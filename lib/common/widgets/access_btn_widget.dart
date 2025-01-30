import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/gps/gps_bloc.dart';

class AccessBtn extends StatelessWidget {
  const AccessBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("GPS access its necessary"),
        MaterialButton(
          splashColor: Colors.transparent,
          color: Colors.black,
          shape: const StadiumBorder(),
          child: const Text(
            "Grant Access",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            context.read<GpsBloc>().askGpsAccess();
          },
        )
      ],
    );
  }
}
