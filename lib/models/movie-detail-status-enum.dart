enum MovieDetailStatus {
  Rumored,
  Planned,
  InProduction,
  PostProduction,
  Released,
  Canceled,
  Unknown
}

MovieDetailStatus movieDetailStatusFromString(String value) {
  return _mapEnumStr[value] ?? MovieDetailStatus.Unknown;
}

extension MovieDetailStatusConvert on MovieDetailStatus {
  String get stringRep {
    return _mapEnumStr.map((key, value) =>
        MapEntry(value, key))[this] ?? 'Unkown';
  }
}

const _mapEnumStr = {
  'Rumored': MovieDetailStatus.Rumored,
  'Planned': MovieDetailStatus.Planned,
  'In Production': MovieDetailStatus.InProduction,
  'Post Production': MovieDetailStatus.PostProduction,
  'Released': MovieDetailStatus.Released,
  'Canceled': MovieDetailStatus.Canceled,
};