

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'formBuilderPackage.dart';

class FillFormThree extends StatefulWidget {
  const FillFormThree({super.key});

  @override
  State<FillFormThree> createState() => _FillFormThreeState();
}



class _FillFormThreeState extends State<FillFormThree> {
  @override
  Widget build(BuildContext context) {
    return FormBuilderPackage(
      xmlFilePath: 'assets/xml_forms/form_three.xml', // Uveďte cestu k vášmu XML súboru
      formTitle: 'RPDD10R', // Nastavte názov formulára
    );
  }
}