import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveFormConsumerTestingWidget extends StatelessWidget {
  final FormGroup form;

  const ReactiveFormConsumerTestingWidget({
    Key key,
    @required this.form,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: this.form,
          child: ReactiveFormConsumer(
            builder: (context, form, child) {
              return RaisedButton(
                onPressed: form.valid ? () {} : null,
              );
            },
          ),
        ),
      ),
    );
  }
}
