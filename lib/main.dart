import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart'; // <- generated

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('gsw'); // default locale

  void _changeLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hacke Schriber',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      locale: _locale, // use the current locale
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('de'), // German
        Locale('gsw'), // Swiss German

      ],
      home: AddMemberPage(
        currentLocale: _locale,
        onLocaleChange: _changeLocale,
      ),
    );
  }
}

class AddMemberPage extends StatefulWidget {
  final void Function(Locale) onLocaleChange;
  final Locale currentLocale;
  
  const AddMemberPage({
    super.key,
    required this.onLocaleChange,
    required this.currentLocale,
  });

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
  final List<TextEditingController> _controllers = [TextEditingController()];

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addMemberField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _startGame() {
    final memberNames = _controllers
        .map((controller) => controller.text.trim())
        .where((name) => name.isNotEmpty)
        .toList();

    final duplicates = memberNames.toSet().length != memberNames.length;

    if (memberNames.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseAddMemberError)),
      );
      return;
    }
    if (duplicates) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.duplicateMemberError),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(memberNames: memberNames),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(AppLocalizations.of(context)!.addMemberPageTitle),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      actions: [
        // Language dropdown
        DropdownButtonHideUnderline(
          child: DropdownButton<Locale>(
            value: widget.currentLocale,
            icon: const Icon(Icons.language, color: Colors.white),
            items: const [
              DropdownMenuItem(
                value: Locale('gsw'),
                child: Text('CH'),
              ),  
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('EN'),
              ),
              DropdownMenuItem(
                value: Locale('de'),
                child: Text('DE'),
              ), 
            ],
            onChanged: (locale) {
              if (locale != null) {
                widget.onLocaleChange(locale); // notify parent to update locale
              }
            },
          ),
        ),
        const SizedBox(width: 12), // spacing from edge
      ],
    ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(
            context,
          ).viewInsets.bottom, // adjusts for keyboard
        ),
        child: Column(
          children: [
            ..._controllers.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: entry.value,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.memberNameLabel,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: 'Delete member',
                      onPressed: _controllers.length > 1
                          ? () {
                              setState(() {
                                entry.value.dispose();
                                _controllers.removeAt(entry.key);
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _addMemberField,
                    icon: const Icon(Icons.add),
                    label: Text(AppLocalizations.of(context)!.addAnotherMemberButton),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _startGame,
              child: Text(AppLocalizations.of(context)!.startGameButton),
            ),
          ],
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  final List<String> memberNames;

  const GamePage({super.key, required this.memberNames});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  // Each member has a list of values (history)
  late Map<String, List<double>> memberValues;
  late List<int> potValues;

  @override
  void initState() {
    super.initState();
    // Initialize all member values to -1
    memberValues = {
      for (var name in widget.memberNames) name: [-1],
    };
    // Pot value so that sum is 0
    potValues = [widget.memberNames.length];
  }

  void _addRound(
    List<String> memberNames,
    String? hacker,
    Set<String> joiners,
    Set<String> fell,
  ) {
    // Hacker wins, he gets 2/3 of the pot, joiners share 1/3
    // Hacker loses, he pays double the pot, joiners share the pot
    // Loser pays pot, Hacker pays double pot
    Map<String, double> newValues = {};
    var currentPot = potValues.last;
    double hackerPot = potValues.last.toDouble();
    double joinerPot = potValues.last.toDouble();

    List<String> winners = {hacker!, ...joiners}.difference(fell).toList();
    List<String> stayed = {...memberNames}
        .difference(joiners) // difference with joiners (Set<String>)
        .difference({hacker}) // wrap hacker in a Set
        .toList();

    if ({...winners, ...stayed, ...fell}.length != memberNames.length) {
      throw Exception("Some members are neither winners nor stayed nor fell");
    }

    var nbWinners = winners.length;
    if (nbWinners == 0) {
      throw Exception("At least one winner required");
    }
    if (nbWinners > 4) {
      throw Exception("Too many winners");
    }

    if (fell.contains(hacker)) {
      hackerPot = -(2 * hackerPot);
      joinerPot = (joinerPot / winners.length);
    } else {
      if (winners.length == 1) {
        hackerPot = hackerPot;
      } else {
        hackerPot = (hackerPot / 3 * 2);
        joinerPot = (joinerPot - hackerPot) / (winners.length - 1);
      }
    }

    for (var name in memberNames) {
      double last = memberValues[name]!.last;
      if (name == hacker) {
        newValues[name] = last + hackerPot;
      } else if (winners.contains(name)) {
        newValues[name] = last + joinerPot;
      } else if (fell.contains(name)) {
        newValues[name] = last - currentPot;
      } else {
        newValues[name] = last;
      }
    }

    // Calculate new pot value
    int pot = -newValues.values.reduce((a, b) => a + b).round().toInt();
    if (pot < memberNames.length) {
      for (var name in memberNames) {
        newValues[name] = newValues[name]! - 1;
      }
      pot = -newValues.values.reduce((a, b) => a + b).toInt();
    }
    if (pot < 0) {
      throw Exception("Pot can't be negative");
    }

    setState(() {
      for (var name in memberNames) {
        memberValues[name]!.add(newValues[name]!);
      }
      potValues.add(pot);
    });
  }

  void _showDealerMistakeDialog() {
    String? selectedMember;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.dealerMistakeTitle),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)!.dealerMistakeQuestion),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: widget.memberNames.map((name) {
                      final selected = selectedMember == name;
                      return ChoiceChip(
                        label: Text(name),
                        selected: selected,
                        selectedColor: Colors.red[200],
                        onSelected: (_) =>
                            setState(() => selectedMember = name),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: selectedMember == null
                      ? null
                      : () {
                          this.setState(() {
                            for (var name in widget.memberNames) {
                              if (name != selectedMember) {
                                memberValues[name]!.add(
                                  memberValues[name]!.last,
                                );
                              } else {
                                memberValues[name]!.add(
                                  memberValues[name]!.last - 1,
                                );
                              }
                            }
                            potValues.add(potValues.last + 1);
                          });
                          Navigator.of(context).pop();
                        },
                  child: Text(AppLocalizations.of(context)!.confirmButton),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showPayInDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.payInTitle),
          content: Text(AppLocalizations.of(context)!.payInQuestion),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(AppLocalizations.of(context)!.cancelButton),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  for (var name in widget.memberNames) {
                    memberValues[name]!.add(memberValues[name]!.last - 1);
                  }
                  potValues.add(potValues.last + widget.memberNames.length);
                });
                Navigator.of(context).pop();
              },
              child: Text(AppLocalizations.of(context)!.confirmButton),
            ),
          ],
        );
      },
    );
  }

  void _showAddRoundDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AddRoundDialog(
          memberNames: widget.memberNames,
          onConfirm: (hacker, joiners, fell) {
            _addRound(widget.memberNames, hacker, joiners, fell);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final columns = [...widget.memberNames, 'Pot'];
    final numRows = memberValues[widget.memberNames[0]]!.length;

    return PopScope(
      canPop: false, // prevent auto-pop, we handle it
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          // Show confirmation dialog
          final shouldQuit = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.quitGameTitle),
              content: Text(AppLocalizations.of(context)!.quitGameQuestion),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(AppLocalizations.of(context)!.cancelButton),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(AppLocalizations.of(context)!.confirmButton),
                ),
              ],
            ),
          );

          // If user pressed confirm, pop manually
          if (shouldQuit == true && mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.gameTableTitle),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    for (var name in columns)
                      Expanded(
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Scrollable rows
              Expanded(
                child: ListView.builder(
                  itemCount: numRows,
                  itemBuilder: (context, rowIndex) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey[300]!),
                        ),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          for (var name in widget.memberNames)
                            Expanded(
                              child: Text(
                                memberValues[name]![rowIndex].toStringAsFixed(
                                  2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              potValues[rowIndex].toString(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _showAddRoundDialog,
                child: Text(AppLocalizations.of(context)!.addRoundButton),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _showDealerMistakeDialog,
                      child: Text(AppLocalizations.of(context)!.dealerMistakeTitle),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _showPayInDialog,
                      child: Text(AppLocalizations.of(context)!.payInTitle),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Update AddRoundDialog to accept onConfirm callback
class AddRoundDialog extends StatefulWidget {
  final List<String> memberNames;
  final void Function(String? hacker, Set<String> joiners, Set<String> fell)?
  onConfirm;
  const AddRoundDialog({super.key, required this.memberNames, this.onConfirm});

  @override
  State<AddRoundDialog> createState() => _AddRoundDialogState();
}

class _AddRoundDialogState extends State<AddRoundDialog> {
  int step = 0;
  String? hacker;
  Set<String> joiners = {};
  Set<String> fell = {};

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (step == 0) {
      // Who hacked?
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.whoHackedQuestion, 
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: widget.memberNames.map((name) {
              final selected = hacker == name;
              return ChoiceChip(
                label: Text(name),
                selected: selected,
                selectedColor: Colors.red[200],
                onSelected: (_) => setState(() => hacker = name),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.cancelButton),
              ),
              ElevatedButton(
                onPressed: hacker == null
                    ? null
                    : () => setState(() => step = 1),
                child: Text(AppLocalizations.of(context)!.continueButton),
              ),
            ],
          ),
        ],
      );
    } else if (step == 1) {
      // Who joined?
      final options = widget.memberNames.where((n) => n != hacker).toList();
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.whoJoinedQuestion, 
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: options.map((name) {
              final selected = joiners.contains(name);
              return FilterChip(
                label: Text(name),
                selected: selected,
                selectedColor: Colors.green[200],
                onSelected: (sel) {
                  setState(() {
                    if (sel) {
                      joiners.add(name);
                    } else {
                      joiners.remove(name);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => step = 0),
                child: Text(AppLocalizations.of(context)!.backButton),
              ),
              ElevatedButton(
                onPressed: () => setState(() => step = 2),
                child: Text(AppLocalizations.of(context)!.continueButton),
              ),
            ],
          ),
        ],
      );
    } else if (step == 2) {
      // Who fell?
      final options = [if (hacker != null) hacker!, ...joiners];
      content = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(AppLocalizations.of(context)!.whoFellQuestion, 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: options.map((name) {
              final selected = fell.contains(name);
              return FilterChip(
                label: Text(name),
                selected: selected,
                selectedColor: Colors.blue[200],
                onSelected: (sel) {
                  setState(() {
                    if (sel) {
                      fell.add(name);
                    } else {
                      fell.remove(name);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => step = 1),
                child: Text(AppLocalizations.of(context)!.backButton),
              ),
              ElevatedButton(
                onPressed: () => setState(() => step = 3),
                child: Text(AppLocalizations.of(context)!.continueButton),
              ),
            ],
          ),
        ],
      );
    } else {
      // Summary
      final winners = {hacker!, ...joiners}.difference(fell);
      int effectiveWinners = winners.length;
      if (winners.contains(hacker)) {
        effectiveWinners++; // Hacker counts double
      }
      final isValid = winners.isNotEmpty && effectiveWinners <= 4;

      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.summaryTitle, 
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Text(AppLocalizations.of(context)!.hackedLabel(hacker ?? "")),
          Text(AppLocalizations.of(context)!.joinedLabel(joiners.join(", "))),
          Text(AppLocalizations.of(context)!.fellLabel(fell.join(", "))),

          const SizedBox(height: 12),
          if (!isValid)
          Text(AppLocalizations.of(context)!.somethingIsWrong,
          style: TextStyle(color: Colors.red, fontSize: 14)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => step = 2),
                child: Text(AppLocalizations.of(context)!.backButton),
              ),
              ElevatedButton(
                onPressed: isValid
                    ? () {
                        if (widget.onConfirm != null) {
                          widget.onConfirm!(hacker, joiners, fell);
                        }
                        Navigator.of(context).pop();
                      }
                    : null, // disable confirm if invalid
                child: Text(AppLocalizations.of(context)!.confirmButton),
              ),
            ],
          ),
        ],
      );
    }

    return AlertDialog(content: content);
  }
}
