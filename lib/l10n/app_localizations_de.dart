// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Hacke Schriber';

  @override
  String get addMemberPageTitle => 'Mitglied hinzufügen';

  @override
  String get memberNameLabel => 'Mitgliedsname';

  @override
  String get addAnotherMemberButton => 'Ein weiteres Mitglied hinzufügen';

  @override
  String get startGameButton => 'Spiel starten';

  @override
  String get pleaseAddMemberError =>
      'Bitte füge mindestens ein Mitglied hinzu.';

  @override
  String get duplicateMemberError =>
      'Doppelte Mitgliedsnamen sind nicht erlaubt.';

  @override
  String get dealerMistakeTitle => 'Dealer-Fehler';

  @override
  String get dealerMistakeQuestion => 'Wer hat den Fehler gemacht?';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get confirmButton => 'Bestätigen';

  @override
  String get backButton => 'Zurück';

  @override
  String get continueButton => 'Weiter';

  @override
  String get payInTitle => 'Einzahlen';

  @override
  String get payInQuestion => 'Müssen alle einzahlen?';

  @override
  String get addRoundButton => 'Runde hinzufügen';

  @override
  String get quitGameTitle => 'Spiel beenden';

  @override
  String get quitGameQuestion =>
      'Bist du sicher, dass du das Spiel beenden und löschen willst?';

  @override
  String get gameTableTitle => 'Spieltabelle';

  @override
  String get headerPot => 'Pot';

  @override
  String get whoHackedQuestion => 'Wer hat gehackt?';

  @override
  String get whoJoinedQuestion => 'Wer ist beigetreten?';

  @override
  String get whoFellQuestion => 'Wer ist gefallen?';

  @override
  String get summaryTitle => 'Zusammenfassung';

  @override
  String get somethingIsWrong => 'Etwas stimmt nicht';

  @override
  String hackedLabel(Object name) {
    return 'Gehackt: $name';
  }

  @override
  String joinedLabel(Object names) {
    return 'Beigetreten: $names';
  }

  @override
  String fellLabel(Object names) {
    return 'Gefallen: $names';
  }
}
