import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/gps/gps_bloc.dart';

class GpsAccessWidget extends StatelessWidget {
  const GpsAccessWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<GpsBloc, GpsState>(
          builder: (context, state) {
            return state.isGPSEnable ? const AccessBtn() : const EnableGPSWidget();
          },
        ),
        // child: AccessBtn(),
      ),
    );
  }
}

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

class EnableGPSWidget extends StatelessWidget {
  const EnableGPSWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Must enable GPS access',
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
    );
  }
}
