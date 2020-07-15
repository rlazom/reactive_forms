// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:reactive_forms/reactive_forms.dart';

class RequiredValidator extends Validator {
  @override
  Map<String, dynamic> validate(AbstractControl control) {
    final error = {ValidationMessage.required: true};

    if (control.value == null) {
      return error;
    } else if (control.value is String) {
      return control.value.trim().isEmpty ? error : null;
    }

    return null;
  }
}