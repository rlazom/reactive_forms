import 'package:flutter/material.dart';
import 'package:reactive_forms/widgets/reactive_form_field.dart';

/// A reactive widget that wraps a [DropdownButton].
class ReactiveDropdownField<T> extends ReactiveFormField<T> {
  /// Creates a [DropdownButton] widget wrapped in an [InputDecorator].
  ///
  /// The [DropdownButton] [items] parameters must not be null.
  ReactiveDropdownField({
    Key key,
    @required String formControlName,
    @required List<DropdownMenuItem<T>> items,
    Map<String, String> validationMessages,
    DropdownButtonBuilder selectedItemBuilder,
    Widget hint,
    VoidCallback onTap,
    this.decoration = const InputDecoration(),
    Widget disabledHint,
    int elevation = 8,
    TextStyle style,
    Widget icon,
    Color iconDisabledColor,
    Color iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    double itemHeight,
  })  : assert(
          items != null && items.isNotEmpty,
          'Items must not be empty',
        ),
        assert(decoration != null),
        assert(elevation != null),
        assert(iconSize != null),
        assert(isDense != null),
        assert(isExpanded != null),
        assert(itemHeight == null || itemHeight > 0),
        super(
          formControlName: formControlName,
          validationMessages: validationMessages ?? const {},
          builder: (ReactiveFormFieldState field) {
            final state = field as _ReactiveDropdownFieldState<T>;
            final InputDecoration effectiveDecoration =
                decoration.applyDefaults(
              Theme.of(state.context).inputDecorationTheme,
            );
            return InputDecorator(
              decoration:
                  effectiveDecoration.copyWith(errorText: state.errorText),
              isEmpty: state.value == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: state.value,
                  items: items,
                  selectedItemBuilder: selectedItemBuilder,
                  hint: hint,
                  onChanged: state.didChange,
                  onTap: onTap,
                  disabledHint: disabledHint,
                  elevation: elevation,
                  style: style,
                  icon: icon,
                  iconDisabledColor: iconDisabledColor,
                  iconEnabledColor: iconEnabledColor,
                  iconSize: iconSize,
                  isDense: isDense,
                  isExpanded: isExpanded,
                  itemHeight: itemHeight,
                ),
              ),
            );
          },
        );

  /// The decoration to show around the dropdown button form field.
  ///
  /// By default, draws a horizontal line under the dropdown button field but can be
  /// configured to show an icon, label, hint text, and error text.
  ///
  /// Specify null to remove the decoration entirely (including the
  /// extra padding introduced by the decoration to save space for the labels).
  final InputDecoration decoration;

  @override
  ReactiveFormFieldState<T> createState() => _ReactiveDropdownFieldState<T>();
}

class _ReactiveDropdownFieldState<T> extends ReactiveFormFieldState<T> {}