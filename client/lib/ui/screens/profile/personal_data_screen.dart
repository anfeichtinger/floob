import 'package:flutter/material.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:floob/ui/widgets/header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:floob/config/style.dart';

class PersonalDataScreen extends ConsumerStatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  PersonalDataScreenState createState() => PersonalDataScreenState();
}

class PersonalDataScreenState extends ConsumerState<PersonalDataScreen> {
  Color? _selectedColor;
  final List<Color> _colors = <Color>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.pink,
    Colors.brown,
    Colors.grey,
    Colors.black,
    Colors.white,
    Colors.cyan,
    Colors.lime,
    Colors.teal,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
        fontFamily: 'Nunito', fontSize: 16, fontWeight: FontWeight.bold);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const AppBarGone(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                const Header(
                    text: 'profile_personal_data', hasBackAction: true),
                Center(
                  child: Image.asset(
                    'assets/img/logo-full-512x512.png',
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                ),
                const SizedBox(height: 64),
                TextField(
                  decoration: InputDecoration(
                    labelText: tr('profile_email'),
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Style.radiusSm.x),
                    ),
                  ),
                  style: textStyle,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<Color>(
                  decoration: InputDecoration(
                    labelText: tr('profile_fav_color'),
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Style.radiusSm.x),
                    ),
                  ),
                  value: _selectedColor,
                  items: _colors.map((Color color) {
                    return DropdownMenuItem<Color>(
                      value: color,
                      child: Container(
                        width: 24,
                        height: 24,
                        color: color,
                      ),
                    );
                  }).toList(),
                  onChanged: (Color? newValue) {
                    setState(() {
                      _selectedColor = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                // TODO: Save action
              },
              style: ButtonStyle(
                minimumSize: WidgetStateProperty.all<Size>(
                  const Size(double.infinity, 54),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Style.radiusSm.x),
                  ),
                ),
              ),
              child: Text(
                tr('profile_save'),
                style: textStyle.copyWith(
                  fontSize: textStyle.fontSize! + 2,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
