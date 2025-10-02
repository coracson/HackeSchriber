// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Hacke Schriber';

  @override
  String get addMemberPageTitle => 'Add Member';

  @override
  String get memberNameLabel => 'Member name';

  @override
  String get addAnotherMemberButton => 'Add another member';

  @override
  String get startGameButton => 'Start game';

  @override
  String get pleaseAddMemberError => 'Please add at least one member.';

  @override
  String get duplicateMemberError => 'Duplicate member names are not allowed.';

  @override
  String get dealerMistakeTitle => 'Dealer mistake';

  @override
  String get dealerMistakeQuestion => 'Who made the mistake?';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get backButton => 'Back';

  @override
  String get continueButton => 'Continue';

  @override
  String get payInTitle => 'Pay in';

  @override
  String get payInQuestion => 'Everyone has to pay in?';

  @override
  String get addRoundButton => 'Add round';

  @override
  String get quitGameTitle => 'Quit Game';

  @override
  String get quitGameQuestion =>
      'Are you sure you want to quit and delete the game?';

  @override
  String get gameTableTitle => 'Game Table';

  @override
  String get headerPot => 'Pot';

  @override
  String get whoHackedQuestion => 'Who hacked?';

  @override
  String get whoJoinedQuestion => 'Who joined?';

  @override
  String get whoFellQuestion => 'Who fell?';

  @override
  String get summaryTitle => 'Summary';

  @override
  String get somethingIsWrong => 'Something is wrong';

  @override
  String hackedLabel(Object name) {
    return 'Hacked: $name';
  }

  @override
  String joinedLabel(Object names) {
    return 'Joined: $names';
  }

  @override
  String fellLabel(Object names) {
    return 'Fell: $names';
  }
}
