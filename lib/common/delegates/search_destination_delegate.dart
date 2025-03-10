import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xmaps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchLocationResult> {
  final List<String> destinations;

  SearchDestinationDelegate({required this.destinations}) : super(searchFieldLabel: 'Buscar...');

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
    final results =
        destinations.where((destination) => destination.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            final result = SearchLocationResult(canceled: false, manual: true);
            close(context, result);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        destinations.where((destination) => destination.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestions[index],
            style: const TextStyle(color: Colors.black),
          ),
          leading: const Icon(Icons.location_on_outlined, color: Colors.black),
          onTap: () {
            final result = SearchLocationResult(canceled: false, manual: true);
            query = suggestions[index];
            showResults(context);
            close(context, result);
          },
        );
      },
    );
  }
}
