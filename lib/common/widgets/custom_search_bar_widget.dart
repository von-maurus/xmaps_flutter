import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xmaps_app/blocs/blocs.dart';
import 'package:xmaps_app/common/delegates/delegates.dart';

class CustomSearchBarWidget extends StatelessWidget {
  const CustomSearchBarWidget({super.key});

  Future<void> onShowSearch(BuildContext context) async {
    final result = await showSearch(
      context: context,
      delegate: SearchDestinationDelegate(destinations: ["Cambiar a ubicación manual"]),
    );
    if (result != null && result.manual) {
      if (context.mounted) {
        final searchBloc = BlocProvider.of<SearchDestinationBloc>(context);
        searchBloc.add(const OnActivateManualMarkerEvent());
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchDestinationBloc, SearchDestinationState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const SizedBox.shrink()
            : FadeInDown(
                duration: const Duration(milliseconds: 200),
                child: SafeArea(
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: GestureDetector(
                      onTap: () => onShowSearch(context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              offset: Offset(0, 5),
                            )
                          ],
                        ),
                        child: const Text('¿Dónde quieres ir?', style: TextStyle(color: Colors.black87)),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
