import 'dart:collection';

extension MapExtensions on Map<dynamic, dynamic> {
  Map<dynamic, dynamic> get reverse {
    return LinkedHashMap.fromEntries(entries.toList().reversed);
  }

  void removeNull() {
    removeWhere((key, value) => key == null || value == null);
  }

  /// Reads a [key] value of [bool] type from [Map].
  ///
  /// If value/map is NULL or not [bool] type return default value [defaultBool]
  ///
  bool? getBool(String key) {
    if (this.containsKey(key)) if (this[key] is bool) return this[key] ?? null;
    print("Map.getBool[$key] has incorrect data : $this");
    return null;
  }

  /// Reads a [key] value of [int] type from [Map].
  ///
  /// If value/map  is NULL or not [int] type return default value [defaultInt]
  ///
  int? getInt(String key) {
    if (this.containsKey(key)) return this[key].castToInt;
    print("Map.getInt[$key] has incorrect data : $this");
    return null;
  }

  /// Reads a [key] value of [double] type from [Map].
  ///
  /// If value/map  is NULL or not [double] type return default value [defaultDouble]
  ///
  double? getDouble(String key) {
    if (this.containsKey(key)) return this[key].castToDouble;
    print("Map.getDouble[$key] has incorrect data : $this");
    return null;
  }

  /// Reads a [key] value of [String] type from [Map].
  ///
  /// If value/map  is NULL or not [String] type return default value [defaultString]
  ///.
  String? getString(String key) {
    if (this.containsKey(key)) if (this[key] is String) return this[key];
    print("Map.getString[$key] has incorrect data : $this");
    return null;
  }

  /// Reads a [key] value of [List] type from [Map].
  ///
  /// If value/map  is NULL or not [List] type return default value [defaultString]
  ///
  List<T> getList<T>(String key) {
    if (this.containsKey(key)) if (this[key] is List<T>) return this[key] ?? <T>[];
    print("Map.getString[$key] has incorrect data : $this");

    return <T>[];
  }
}