// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Tracks the value and validation status of an individual form control.
class FormControl<T> extends AbstractControl<T> {
  final _onFocusChanged = ValueNotifier<bool>(false);
  T _defaultValue;
  T _value;

  /// Creates a new FormControl instance, optionally pass [defaultValue]
  /// and [validators]. You can set [touched] to true to force the validation
  /// messages to show up at the very first time the widget builds.
  ///
  /// You can also force the data type of this control by specifying it
  ///
  /// ### Example:
  /// ```dart
  /// final priceControl = FormControl<double>(defaultValue: 0.0);
  /// ```
  ///
  FormControl({
    T defaultValue,
    List<ValidatorFunction> validators,
    List<AsyncValidatorFunction> asyncValidators,
    bool touched = false,
  })  : _defaultValue = defaultValue,
        super(
          validators: validators,
          asyncValidators: asyncValidators,
          touched: touched,
        ) {
    this.value = _defaultValue;
  }

  /// Returns the current value of the control.
  @override
  T get value => this._value;

  /// Returns the default value of the control.
  T get defaultValue => _defaultValue;

  /// True if the control is marked as focused.
  bool get focused => _onFocusChanged.value;

  /// Sets the [newValue] as value for the form control.
  @override
  set value(T newValue) {
    this._value = newValue;
    this.validate();
    this.notifyValueChanged(this._value);
  }

  /// Disposes the control
  @override
  void dispose() {
    _onFocusChanged.dispose();

    super.dispose();
  }

  /// A [ChangeNotifier] that emits an event every time the focus status of
  /// the control changes.
  ChangeNotifier get onFocusChanged => _onFocusChanged;

  /// Resets the form control, marking it as untouched,
  /// and setting the [value] to [defaultValue].
  @override
  void reset() {
    this.touched = false;
    this.value = this.defaultValue;
  }

  /// Remove focus on a ReactiveFormField widget without the interaction
  /// of the user.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// final formControl = form.formControl('name');
  ///
  /// // UI text field lose focus
  /// formControl.unfocus();
  ///```
  ///
  void unfocus() {
    if (this.focused) {
      _onFocusChanged.value = false;
    }
  }

  /// Sets focus on a ReactiveFormField widget without the interaction
  /// of the user.
  ///
  /// ### Example:
  ///
  /// ```dart
  /// final formControl = form.formControl('name');
  ///
  /// // UI text field get focus and the device keyboard pop up
  /// formControl.focus();
  ///```
  ///
  void focus() {
    if (!this.focused) {
      _onFocusChanged.value = true;
    }
  }
}
