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
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
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

  /// `Populars`
  String get popular {
    return Intl.message(
      'Populars',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Audios books`
  String get audio_books {
    return Intl.message(
      'Audios books',
      name: 'audio_books',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get Error {
    return Intl.message(
      'Error',
      name: 'Error',
      desc: '',
      args: [],
    );
  }

  /// `User with this Info `
  String get details_error {
    return Intl.message(
      'User with this Info ',
      name: 'details_error',
      desc: '',
      args: [],
    );
  }

  /// `There is no user with this profile`
  String get bookishopuser {
    return Intl.message(
      'There is no user with this profile',
      name: 'bookishopuser',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in the values`
  String get please_fill_parameters {
    return Intl.message(
      'Please fill in the values',
      name: 'please_fill_parameters',
      desc: '',
      args: [],
    );
  }

  /// `userName`
  String get userName {
    return Intl.message(
      'userName',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter`
  String get enter {
    return Intl.message(
      'Enter',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `user`
  String get userRole {
    return Intl.message(
      'user',
      name: 'userRole',
      desc: '',
      args: [],
    );
  }

  /// `Persion`
  String get persion {
    return Intl.message(
      'Persion',
      name: 'persion',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Dana`
  String get name_font_dana {
    return Intl.message(
      'Dana',
      name: 'name_font_dana',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get Exit {
    return Intl.message(
      'Exit',
      name: 'Exit',
      desc: '',
      args: [],
    );
  }

  /// `There is no case`
  String get not_exit_cases {
    return Intl.message(
      'There is no case',
      name: 'not_exit_cases',
      desc: '',
      args: [],
    );
  }

  /// `Filter by category`
  String get filter_by_category {
    return Intl.message(
      'Filter by category',
      name: 'filter_by_category',
      desc: '',
      args: [],
    );
  }

  /// `Filter by crice`
  String get filter_price {
    return Intl.message(
      'Filter by crice',
      name: 'filter_price',
      desc: '',
      args: [],
    );
  }

  /// `Apply filter`
  String get set_filter {
    return Intl.message(
      'Apply filter',
      name: 'set_filter',
      desc: '',
      args: [],
    );
  }

  /// `Toman`
  String get toman {
    return Intl.message(
      'Toman',
      name: 'toman',
      desc: '',
      args: [],
    );
  }

  /// `Story`
  String get category_stoy {
    return Intl.message(
      'Story',
      name: 'category_stoy',
      desc: '',
      args: [],
    );
  }

  /// `Noval`
  String get novel {
    return Intl.message(
      'Noval',
      name: 'novel',
      desc: '',
      args: [],
    );
  }

  /// `philosophy`
  String get philosophy {
    return Intl.message(
      'philosophy',
      name: 'philosophy',
      desc: '',
      args: [],
    );
  }

  /// `epic`
  String get epic {
    return Intl.message(
      'epic',
      name: 'epic',
      desc: '',
      args: [],
    );
  }

  /// `Book name`
  String get book_name {
    return Intl.message(
      'Book name',
      name: 'book_name',
      desc: '',
      args: [],
    );
  }

  /// `Edit Book`
  String get edit_product {
    return Intl.message(
      'Edit Book',
      name: 'edit_product',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get price {
    return Intl.message(
      'price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Author Name`
  String get author_name {
    return Intl.message(
      'Author Name',
      name: 'author_name',
      desc: '',
      args: [],
    );
  }

  /// `Translator name`
  String get translator_name {
    return Intl.message(
      'Translator name',
      name: 'translator_name',
      desc: '',
      args: [],
    );
  }

  /// `number of pages`
  String get count_pages {
    return Intl.message(
      'number of pages',
      name: 'count_pages',
      desc: '',
      args: [],
    );
  }

  /// `Publisher`
  String get publisher {
    return Intl.message(
      'Publisher',
      name: 'publisher',
      desc: '',
      args: [],
    );
  }

  /// `Summery of book`
  String get summery_of_book {
    return Intl.message(
      'Summery of book',
      name: 'summery_of_book',
      desc: '',
      args: [],
    );
  }

  /// `First Tag`
  String get firstTag {
    return Intl.message(
      'First Tag',
      name: 'firstTag',
      desc: '',
      args: [],
    );
  }

  /// `Second Tag`
  String get second_tag {
    return Intl.message(
      'Second Tag',
      name: 'second_tag',
      desc: '',
      args: [],
    );
  }

  /// `Third Tag`
  String get third_tag {
    return Intl.message(
      'Third Tag',
      name: 'third_tag',
      desc: '',
      args: [],
    );
  }

  /// `Forth Tag`
  String get forth_tag {
    return Intl.message(
      'Forth Tag',
      name: 'forth_tag',
      desc: '',
      args: [],
    );
  }

  /// `Record`
  String get record {
    return Intl.message(
      'Record',
      name: 'record',
      desc: '',
      args: [],
    );
  }

  /// `Cart Shop`
  String get cart_shop {
    return Intl.message(
      'Cart Shop',
      name: 'cart_shop',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue1 {
    return Intl.message(
      'Continue',
      name: 'continue1',
      desc: '',
      args: [],
    );
  }

  /// `Success Purchase`
  String get success_purchase {
    return Intl.message(
      'Success Purchase',
      name: 'success_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Report Purchase`
  String get report_purchase {
    return Intl.message(
      'Report Purchase',
      name: 'report_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Score`
  String get score {
    return Intl.message(
      'Score',
      name: 'score',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Management`
  String get managment {
    return Intl.message(
      'Management',
      name: 'managment',
      desc: '',
      args: [],
    );
  }

  /// `Add product`
  String get add_product {
    return Intl.message(
      'Add product',
      name: 'add_product',
      desc: '',
      args: [],
    );
  }

  /// `The desired book was added to the cart`
  String get book_add_cart_shop {
    return Intl.message(
      'The desired book was added to the cart',
      name: 'book_add_cart_shop',
      desc: '',
      args: [],
    );
  }

  /// `The book was added to the favorites list`
  String get book_add_to_favortie {
    return Intl.message(
      'The book was added to the favorites list',
      name: 'book_add_to_favortie',
      desc: '',
      args: [],
    );
  }

  /// `it is registered`
  String get record_done {
    return Intl.message(
      'it is registered',
      name: 'record_done',
      desc: '',
      args: [],
    );
  }

  /// `There is a problem`
  String get has_problem {
    return Intl.message(
      'There is a problem',
      name: 'has_problem',
      desc: '',
      args: [],
    );
  }

  /// `The product was successfully registered`
  String get record_product {
    return Intl.message(
      'The product was successfully registered',
      name: 'record_product',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations!!`
  String get congratulation {
    return Intl.message(
      'Congratulations!!',
      name: 'congratulation',
      desc: '',
      args: [],
    );
  }

  /// `The product was successfully edited`
  String get success_edit {
    return Intl.message(
      'The product was successfully edited',
      name: 'success_edit',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet`
  String get check_network {
    return Intl.message(
      'Please check your internet',
      name: 'check_network',
      desc: '',
      args: [],
    );
  }

  /// `The number of your goods is zero`
  String get count_of_cart_shops_zero {
    return Intl.message(
      'The number of your goods is zero',
      name: 'count_of_cart_shops_zero',
      desc: '',
      args: [],
    );
  }

  /// `Psychology`
  String get psychology {
    return Intl.message(
      'Psychology',
      name: 'psychology',
      desc: '',
      args: [],
    );
  }

  /// `موارد به طور کامل پر نشده اند`
  String get not_filled {
    return Intl.message(
      'موارد به طور کامل پر نشده اند',
      name: 'not_filled',
      desc: '',
      args: [],
    );
  }

  /// `در وارد کردن اطلاعات مشکلی پیش آمده است`
  String get has_problem_wher_enter_the_info {
    return Intl.message(
      'در وارد کردن اطلاعات مشکلی پیش آمده است',
      name: 'has_problem_wher_enter_the_info',
      desc: '',
      args: [],
    );
  }

  /// `این مقدار نباید خالی باشد`
  String get should_not_empty {
    return Intl.message(
      'این مقدار نباید خالی باشد',
      name: 'should_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `قیمت باید از 5000 بیشتر و از 100000 کم تر باشد`
  String get price_100000until_5000 {
    return Intl.message(
      'قیمت باید از 5000 بیشتر و از 100000 کم تر باشد',
      name: 'price_100000until_5000',
      desc: '',
      args: [],
    );
  }

  /// `نام نویسنده نمیتواند خالی باشد`
  String get authername_not_empty {
    return Intl.message(
      'نام نویسنده نمیتواند خالی باشد',
      name: 'authername_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `امتیاز نباید خالی باشد`
  String get score_not_empty {
    return Intl.message(
      'امتیاز نباید خالی باشد',
      name: 'score_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `امتیاز باید بین 1 تا 5 باشد`
  String get score_betwwen_1_5 {
    return Intl.message(
      'امتیاز باید بین 1 تا 5 باشد',
      name: 'score_betwwen_1_5',
      desc: '',
      args: [],
    );
  }

  /// `نام کتاب نباید خالی باشد`
  String get bookname_not_empty {
    return Intl.message(
      'نام کتاب نباید خالی باشد',
      name: 'bookname_not_empty',
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
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
