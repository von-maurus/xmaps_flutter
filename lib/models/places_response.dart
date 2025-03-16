import 'dart:convert';

class PlacesResponse {
  final String type;
  final List<Feature> features;
  final String attribution;

  PlacesResponse({
    required this.type,
    required this.features,
    required this.attribution,
  });

  factory PlacesResponse.fromJson(String str) => PlacesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PlacesResponse.fromMap(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        features: List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "features": List<dynamic>.from(features.map((x) => x.toMap())),
        "attribution": attribution,
      };
}

class Feature {
  final String type;
  final String id;
  final Geometry geometry;
  final Properties properties;
  final String text;
  final String placeName;
  final List<double> center;

  Feature({
    required this.type,
    required this.id,
    required this.geometry,
    required this.properties,
    required this.text,
    required this.placeName,
    required this.center,
  });

  factory Feature.fromJson(String str) => Feature.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
        type: json["type"],
        id: json["id"],
        geometry: Geometry.fromMap(json["geometry"]),
        properties: Properties.fromMap(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "id": id,
        "geometry": geometry.toMap(),
        "properties": properties.toMap(),
      };

  @override
  String toString() {
    return 'Feature(type: $type, id: $id, geometry: ${geometry.type}, properties: ${properties.fullAddress} | text: ${properties.name})';
  }
}

class Geometry {
  final String type;
  final List<double> coordinates;

  Geometry({
    required this.type,
    required this.coordinates,
  });

  factory Geometry.fromJson(String str) => Geometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Properties {
  final String? mapboxId;
  final String? featureType;
  final String fullAddress;
  final String name;
  final String namePreferred;
  final Coordinates? coordinates;
  final List<double>? bbox;
  final Context? context;
  final String? placeFormatted;
  final String? accuracy;

  Properties({
    this.mapboxId,
    this.featureType,
    required this.fullAddress,
    required this.name,
    required this.namePreferred,
    this.coordinates,
    this.bbox,
    this.context,
    this.placeFormatted,
    this.accuracy,
  });

  factory Properties.fromJson(String str) => Properties.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Properties.fromMap(Map<String, dynamic> json) => Properties(
        mapboxId: json["mapbox_id"] ?? '',
        featureType: json["feature_type"] ?? '',
        fullAddress: json["full_address"] ?? '',
        name: json["name"] ?? '',
        namePreferred: json["name_preferred"] ?? '',
        coordinates: json["coordinates"] == null ? null : Coordinates.fromMap(json["coordinates"]),
        bbox: json["bbox"] == null ? null : List<double>.from(json["bbox"].map((x) => x?.toDouble())),
        context: json["context"] == null ? null : Context.fromMap(json["context"]),
        placeFormatted: json["place_formatted"] ?? '',
        accuracy: json["accuracy"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "feature_type": featureType,
        "full_address": fullAddress,
        "name": name,
        "name_preferred": namePreferred,
        "coordinates": coordinates?.toMap(),
        "bbox": bbox == null ? [] : List<dynamic>.from(bbox!.map((x) => x)),
        "context": context?.toMap(),
        "place_formatted": placeFormatted,
      };
}

class Context {
  final Country country;
  final Postcode? postcode;
  final District? locality;
  final District? place;
  final District? district;
  final Region? region;
  final District? neighborhood;

  Context({
    required this.country,
    this.postcode,
    this.locality,
    this.place,
    this.district,
    this.region,
    this.neighborhood,
  });

  factory Context.fromJson(String str) => Context.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Context.fromMap(Map<String, dynamic> json) => Context(
        country: Country.fromMap(json["country"]),
        postcode: json["postcode"] == null ? null : Postcode.fromMap(json["postcode"]),
        locality: json["locality"] == null ? null : District.fromMap(json["locality"]),
        place: json["place"] == null ? null : District.fromMap(json["place"]),
        district: json["district"] == null ? null : District.fromMap(json["district"]),
        region: json["region"] == null ? null : Region.fromMap(json["region"]),
        neighborhood: json["neighborhood"] == null ? null : District.fromMap(json["neighborhood"]),
      );

  Map<String, dynamic> toMap() => {
        "country": country.toMap(),
        "postcode": postcode?.toMap(),
        "locality": locality?.toMap(),
        "place": place?.toMap(),
        "district": district?.toMap(),
        "region": region?.toMap(),
        "neighborhood": neighborhood?.toMap(),
      };
}

class Country {
  final String mapboxId;
  final String name;
  final String countryCode;
  final String countryCodeAlpha3;
  final String wikidataId;
  final Translations translations;

  Country({
    required this.mapboxId,
    required this.name,
    required this.countryCode,
    required this.countryCodeAlpha3,
    required this.wikidataId,
    required this.translations,
  });

  factory Country.fromJson(String str) => Country.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Country.fromMap(Map<String, dynamic> json) => Country(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        countryCode: json["country_code"],
        countryCodeAlpha3: json["country_code_alpha_3"],
        wikidataId: json["wikidata_id"],
        translations: Translations.fromMap(json["translations"]),
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
        "country_code": countryCode,
        "country_code_alpha_3": countryCodeAlpha3,
        "wikidata_id": wikidataId,
        "translations": translations.toMap(),
      };
}

class Translations {
  final Es es;

  Translations({
    required this.es,
  });

  factory Translations.fromJson(String str) => Translations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Translations.fromMap(Map<String, dynamic> json) => Translations(
        es: Es.fromMap(json["es"]),
      );

  Map<String, dynamic> toMap() => {
        "es": es.toMap(),
      };
}

class Es {
  final Language language;
  final String name;

  Es({
    required this.language,
    required this.name,
  });

  factory Es.fromJson(String str) => Es.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Es.fromMap(Map<String, dynamic> json) => Es(
        language: languageValues.map[json["language"]] ?? Language.ES,
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "language": languageValues.reverse[language],
        "name": name,
      };
}

enum Language { EN, ES }

final languageValues = EnumValues({"en": Language.EN, "es": Language.ES});

class District {
  final String mapboxId;
  final String name;
  final String? wikidataId;
  final Translations translations;

  District({
    required this.mapboxId,
    required this.name,
    this.wikidataId,
    required this.translations,
  });

  factory District.fromJson(String str) => District.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory District.fromMap(Map<String, dynamic> json) => District(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"],
        translations: Translations.fromMap(json["translations"]),
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "translations": translations.toMap(),
      };
}

class Postcode {
  final String mapboxId;
  final String name;

  Postcode({
    required this.mapboxId,
    required this.name,
  });

  factory Postcode.fromJson(String str) => Postcode.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Postcode.fromMap(Map<String, dynamic> json) => Postcode(
        mapboxId: json["mapbox_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
      };
}

class Region {
  final String mapboxId;
  final String name;
  final String? wikidataId;
  final String? regionCode;
  final String? regionCodeFull;
  final Translations translations;

  Region({
    required this.mapboxId,
    required this.name,
    this.wikidataId,
    this.regionCode,
    this.regionCodeFull,
    required this.translations,
  });

  factory Region.fromJson(String str) => Region.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Region.fromMap(Map<String, dynamic> json) => Region(
        mapboxId: json["mapbox_id"],
        name: json["name"],
        wikidataId: json["wikidata_id"] ?? '',
        regionCode: json["region_code"] ?? '',
        regionCodeFull: json["region_code_full"] ?? '',
        translations: Translations.fromMap(json["translations"]),
      );

  Map<String, dynamic> toMap() => {
        "mapbox_id": mapboxId,
        "name": name,
        "wikidata_id": wikidataId,
        "region_code": regionCode,
        "region_code_full": regionCodeFull,
        "translations": translations.toMap(),
      };
}

class Coordinates {
  final double longitude;
  final double latitude;

  Coordinates({
    required this.longitude,
    required this.latitude,
  });

  factory Coordinates.fromJson(String str) => Coordinates.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Coordinates.fromMap(Map<String, dynamic> json) => Coordinates(
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
