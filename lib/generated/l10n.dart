// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `booki shop`
  String get app_name {
    return Intl.message(
      'booki shop',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `assets/images/1.jpg`
  String get assetsimages1jpg {
    return Intl.message(
      'assets/images/1.jpg',
      name: 'assetsimages1jpg',
      desc: '',
      args: [],
    );
  }

  /// `assets/images/2.jpg`
  String get assetsimages2jpg {
    return Intl.message(
      'assets/images/2.jpg',
      name: 'assetsimages2jpg',
      desc: '',
      args: [],
    );
  }

  /// `assets/images/3.jpg`
  String get assetsimages3jpg {
    return Intl.message(
      'assets/images/3.jpg',
      name: 'assetsimages3jpg',
      desc: '',
      args: [],
    );
  }

  /// `The most famous books`
  String get the_most_famous_books {
    return Intl.message(
      'The most famous books',
      name: 'the_most_famous_books',
      desc: '',
      args: [],
    );
  }

  /// `more`
  String get more {
    return Intl.message(
      'more',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `the best`
  String get the_best {
    return Intl.message(
      'the best',
      name: 'the_best',
      desc: '',
      args: [],
    );
  }

  /// `details`
  String get details {
    return Intl.message(
      'details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `     add to favorite list      `
  String get add_to_favorite {
    return Intl.message(
      '     add to favorite list      ',
      name: 'add_to_favorite',
      desc: '',
      args: [],
    );
  }

  /// `book introduction `
  String get book_introduction {
    return Intl.message(
      'book introduction ',
      name: 'book_introduction',
      desc: '',
      args: [],
    );
  }

  /// `ابلهی رادیدم سمین و خلعتی ثمین در بر. (گلستان ).\n|| مقابل غث در سخن به معنی کلام استوار و متعین. (اقرب الموارد) : و میفرستاد سوی بلخ و غث و سمین بازمی نمود. (تاریخ بیهقی چ ادیب ص 250). چون صدق با کذب و غث با سمین و صواب با خطا امتزاج و اختلاط پذیرد تمیز عسر شود. (تاریخ بیهقی ص 16).\nگرچه در تألیف این ابیات نیست\nبی سمین غثی و بی غثی کروت.`
  String get sd {
    return Intl.message(
      'ابلهی رادیدم سمین و خلعتی ثمین در بر. (گلستان ).\n|| مقابل غث در سخن به معنی کلام استوار و متعین. (اقرب الموارد) : و میفرستاد سوی بلخ و غث و سمین بازمی نمود. (تاریخ بیهقی چ ادیب ص 250). چون صدق با کذب و غث با سمین و صواب با خطا امتزاج و اختلاط پذیرد تمیز عسر شود. (تاریخ بیهقی ص 16).\nگرچه در تألیف این ابیات نیست\nبی سمین غثی و بی غثی کروت.',
      name: 'sd',
      desc: '',
      args: [],
    );
  }

  /// `favorite`
  String get favorite {
    return Intl.message(
      'favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get profile {
    return Intl.message(
      'profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `معروف ترین ها`
  String get popular {
    return Intl.message(
      'معروف ترین ها',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `کتاب های صوتی`
  String get audio_books {
    return Intl.message(
      'کتاب های صوتی',
      name: 'audio_books',
      desc: '',
      args: [],
    );
  }

  /// `خطا`
  String get Error {
    return Intl.message(
      'خطا',
      name: 'Error',
      desc: '',
      args: [],
    );
  }

  /// `کاربری با این مشخصات وجود ندارد`
  String get details_error {
    return Intl.message(
      'کاربری با این مشخصات وجود ندارد',
      name: 'details_error',
      desc: '',
      args: [],
    );
  }

  /// `bookishop_user`
  String get bookishopuser {
    return Intl.message(
      'bookishop_user',
      name: 'bookishopuser',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fa'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}