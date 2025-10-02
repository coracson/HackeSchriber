import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_gsw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
    Locale('de', 'CH'),
    Locale('gsw'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Hacke Schriber'**
  String get appTitle;

  /// No description provided for @addMemberPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get addMemberPageTitle;

  /// No description provided for @memberNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Member name'**
  String get memberNameLabel;

  /// No description provided for @addAnotherMemberButton.
  ///
  /// In en, this message translates to:
  /// **'Add another member'**
  String get addAnotherMemberButton;

  /// No description provided for @startGameButton.
  ///
  /// In en, this message translates to:
  /// **'Start game'**
  String get startGameButton;

  /// No description provided for @pleaseAddMemberError.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one member.'**
  String get pleaseAddMemberError;

  /// No description provided for @duplicateMemberError.
  ///
  /// In en, this message translates to:
  /// **'Duplicate member names are not allowed.'**
  String get duplicateMemberError;

  /// No description provided for @dealerMistakeTitle.
  ///
  /// In en, this message translates to:
  /// **'Dealer mistake'**
  String get dealerMistakeTitle;

  /// No description provided for @dealerMistakeQuestion.
  ///
  /// In en, this message translates to:
  /// **'Who made the mistake?'**
  String get dealerMistakeQuestion;

  /// No description provided for @cancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @payInTitle.
  ///
  /// In en, this message translates to:
  /// **'Pay in'**
  String get payInTitle;

  /// No description provided for @payInQuestion.
  ///
  /// In en, this message translates to:
  /// **'Everyone has to pay in?'**
  String get payInQuestion;

  /// No description provided for @addRoundButton.
  ///
  /// In en, this message translates to:
  /// **'Add round'**
  String get addRoundButton;

  /// No description provided for @quitGameTitle.
  ///
  /// In en, this message translates to:
  /// **'Quit Game'**
  String get quitGameTitle;

  /// No description provided for @quitGameQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to quit and delete the game?'**
  String get quitGameQuestion;

  /// No description provided for @gameTableTitle.
  ///
  /// In en, this message translates to:
  /// **'Game Table'**
  String get gameTableTitle;

  /// No description provided for @headerPot.
  ///
  /// In en, this message translates to:
  /// **'Pot'**
  String get headerPot;

  /// No description provided for @whoHackedQuestion.
  ///
  /// In en, this message translates to:
  /// **'Who hacked?'**
  String get whoHackedQuestion;

  /// No description provided for @whoJoinedQuestion.
  ///
  /// In en, this message translates to:
  /// **'Who joined?'**
  String get whoJoinedQuestion;

  /// No description provided for @whoFellQuestion.
  ///
  /// In en, this message translates to:
  /// **'Who fell?'**
  String get whoFellQuestion;

  /// No description provided for @summaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summaryTitle;

  /// No description provided for @somethingIsWrong.
  ///
  /// In en, this message translates to:
  /// **'Something is wrong'**
  String get somethingIsWrong;

  /// Label for showing who hacked
  ///
  /// In en, this message translates to:
  /// **'Hacked: {name}'**
  String hackedLabel(Object name);

  /// Label showing the list of players who joined
  ///
  /// In en, this message translates to:
  /// **'Joined: {names}'**
  String joinedLabel(Object names);

  /// Label showing the list of players who fell
  ///
  /// In en, this message translates to:
  /// **'Fell: {names}'**
  String fellLabel(Object names);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en', 'gsw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'gsw':
      return AppLocalizationsGsw();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
