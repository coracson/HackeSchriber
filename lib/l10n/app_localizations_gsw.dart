// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swiss German Alemannic Alsatian (`gsw`).
class AppLocalizationsGsw extends AppLocalizations {
  AppLocalizationsGsw([String locale = 'gsw']) : super(locale);

  @override
  String get appTitle => 'Hacke Schriber';

  @override
  String get addMemberPageTitle => 'Spieler';

  @override
  String get memberNameLabel => 'Spieler name';

  @override
  String get addAnotherMemberButton => 'Nüa Spieler';

  @override
  String get startGameButton => 'Start z spüu';

  @override
  String get pleaseAddMemberError => 'Tu mau mindestens 1 spieler hinzuefüege.';

  @override
  String get duplicateMemberError => 'Zwü pajasse mitem gliche name giht nid.';

  @override
  String get dealerMistakeTitle => 'Straf';

  @override
  String get dealerMistakeQuestion => 'Wöla pajass het d straf gmacht??';

  @override
  String get cancelButton => 'Doch nid';

  @override
  String get confirmButton => 'Jaja genau';

  @override
  String get backButton => 'Zrug';

  @override
  String get continueButton => 'Witer';

  @override
  String get payInTitle => 'Nahzahle';

  @override
  String get payInQuestion => 'Jeda muss nazahle?';

  @override
  String get addRoundButton => 'Hacke';

  @override
  String get quitGameTitle => 'I ma nümme';

  @override
  String get quitGameQuestion =>
      'Büsch sicher dass du zrug wosch u z spüu isch glöscht?';

  @override
  String get gameTableTitle => 'Spüublatt';

  @override
  String get headerPot => 'Pot';

  @override
  String get whoHackedQuestion => 'Wär hackt?';

  @override
  String get whoJoinedQuestion => 'Wär chunt mid?';

  @override
  String get whoFellQuestion => 'Wär isch kiht?';

  @override
  String get summaryTitle => 'Zämefassig';

  @override
  String get somethingIsWrong => 'Epis giht nid uf';

  @override
  String hackedLabel(Object name) {
    return 'Ghackt: $name';
  }

  @override
  String joinedLabel(Object names) {
    return 'Mitcho: $names';
  }

  @override
  String fellLabel(Object names) {
    return 'Kiht: $names';
  }
}
