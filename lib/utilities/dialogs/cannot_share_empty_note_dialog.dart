import 'package:flutter/widgets.dart';
import 'package:notly/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Sharing',
    content: 'You can not share an empty note!',
    optionBuilder: () => {
      'OK': null,
    },
  );
}
