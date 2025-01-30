import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/gps/gps_bloc.dart';
import 'package:xmaps_app/common/widgets/widgets.dart';

class GpsAccessView extends StatelessWidget {
  const GpsAccessView({super.key});
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
