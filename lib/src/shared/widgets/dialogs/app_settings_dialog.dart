import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kuama_flutter/src/features/app_pages/use_cases/open_settings_app_page.dart';
import 'package:kuama_flutter/src/shared/feature_structure/use_case.dart';
import 'package:kuama_flutter/src/_utils/lg.dart';

class AskOpenAppSettingsPageDialog extends StatelessWidget {
  final Widget? title;
  final Widget? cancelLabel;
  final Widget? settingsLabel;

  const AskOpenAppSettingsPageDialog({
    Key? key,
    this.title,
    this.cancelLabel,
    this.settingsLabel,
  }) : super(key: key);

  void openSettingsPage() async {
    final res = await GetIt.I<OpenSettingsAppPage>().call(NoParams()).single;
    res.fold((failure) {
      lg.severe('The app settings page could not be opened', failure);
    }, (wasOpened) {
      if (!wasOpened) lg.severe('The app settings page could not be opened');
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title ?? Text('Open app settings'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: cancelLabel ?? Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: openSettingsPage,
          child: settingsLabel ?? Text('Settings'),
        ),
      ],
    );
  }
}
