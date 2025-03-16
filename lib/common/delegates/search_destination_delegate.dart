import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:xmaps_app/blocs/blocs.dart';
import 'package:xmaps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchLocationResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar...');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Platform.isAndroid ? const Icon(Icons.arrow_back) : const Icon(Icons.arrow_back_ios),
      onPressed: () {
        final result = SearchLocationResult(canceled: true);
        close(context, result);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchDestinationBloc>(context);
    final proximity = BlocProvider.of<LocationBloc>(context).state.lastKnownLocation;
    searchBloc.getPlacesByQuery(proximity!, query);
    return BlocBuilder<SearchDestinationBloc, SearchDestinationState>(
      builder: (context, state) {
        final places = state.places;
        return ListView.separated(
          itemCount: places.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final place = places[index];
            return ListTile(
              title: Text(
                place.text,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
              subtitle: Text(
                place.placeName,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
              leading: const Icon(
                Icons.place_outlined,
                color: Colors.black,
              ),
              onTap: () {
                final res = SearchLocationResult(
                  canceled: false,
                  manual: false,
                  position: LatLng(place.geometry.coordinates[1], place.geometry.coordinates[0]),
                  name: place.text,
                  description: place.placeName,
                );
                searchBloc.add(OnAddToHistoryEvent(place: place));
                close(context, res);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = BlocProvider.of<SearchDestinationBloc>(context).state.history;
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.black),
          title: const Text('Put location manually', style: TextStyle(color: Colors.black)),
          onTap: () {
            final result = SearchLocationResult(canceled: false, manual: true);
            close(context, result);
          },
        ),
        ...suggestions.map(
          (place) => ListTile(
            title: Text(place.text),
            subtitle: Text(place.placeName),
            leading: const Icon(Icons.history, color: Colors.black),
            onTap: () {
              final result = SearchLocationResult(
                canceled: false,
                manual: false,
                position: LatLng(place.geometry.coordinates[1], place.geometry.coordinates[0]),
                name: place.text,
                description: place.placeName,
              );
              close(context, result);
            },
          ),
        )
      ],
    );
  }
}
