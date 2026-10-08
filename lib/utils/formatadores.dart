import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

String formatarCpf(String cpf) {
  return CpfInputFormatter()
      .formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: cpf))
      .text;
}
