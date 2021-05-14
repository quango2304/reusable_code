import 'package:coffee_shop/models/mission_state_enum.dart';
import 'package:coffee_shop/models/mission_type_enum.dart';
import 'package:easy_localization/easy_localization.dart' as ez;
import 'package:flutter/material.dart';

import 'regex_extensions.dart';

extension StringNullableExtensions on String? {
  bool get isNullOrEmpty {
    if (this == null) return true;
    if (this!.isEmpty) return true;
    return false;
  }
}

extension StringExtensions on String {
  String get reverse {
    if (this.length < 2) {
      return this;
    }
    final characters = Characters(this);
    return characters.toList().reversed.join();
  }

  List<String> get toList {
    return Characters(this).toList();
  }

  //'hi i am Leo i'm so handsome'.splitWithDelimiter('Leo')
  // will return ['hi i am ','Leo',' i'm so handsome']
  List<String> splitWithDelimiter(String delimiter) =>
      RegExp(delimiter).allMatchesWithSep(this);

  //'012345678'.truncateWithEllipsis(5)
  // will return '01234...'
  String truncateWithEllipsis(int cutoff) {
    return (length <= cutoff) ? this : '${substring(0, cutoff)}...';
  }

  String get capitalize {
    return (this.isNotEmpty)
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : this;
  }

  // 'sad'.withCounter(5)
  // will return sad(5)
  String withCounter(int number) {
    return isNotEmpty ? '$this($number)' : this;
  }

  double toDouble([double defaultValue = 0.0]) {
    return double.tryParse(replaceAll(RegExp(r'[^0-9\.]'), '')) ?? defaultValue;
  }

  int? get toInt {
    return int.tryParse(this);
  }
}

extension StringTranslateExtension on String {
  String tran({
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) =>
      ez.tr(this, args: args, namedArgs: namedArgs, gender: gender);

  /// {@macro plural}
  String plural(
    num value, {
    List<String>? args,
    ez.NumberFormat? format,
  }) =>
      ez.plural(this, value, args: args, format: format);
}

extension MissionTypeFromString on String {
  MissionType get toMissionType {
    switch (this) {
      case "sentFeedback":
        return MissionType.sentFeedback;
      case "loggedIn":
        return MissionType.loggedIn;
      case "likedShop":
        return MissionType.likeOurShop;
      case "updateAccount":
        return MissionType.updateAccount;
      case "scanQrCode":
        return MissionType.scanQrCode;
      case "playAMusic":
        return MissionType.playAMusic;
      case "addAddress":
        return MissionType.addAddress;
      case "favouriteAShop":
        return MissionType.favouriteAShop;
      default:
        return MissionType.likeOurShop;
    }
  }
}

extension StateFromString on String {
  MissionState get toStateType {
    switch (this) {
      case "done":
        return MissionState.done;
      case "notDone":
        return MissionState.notDone;
      default:
        return MissionState.notDone;
    }
  }
}