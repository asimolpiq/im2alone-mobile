import 'package:flutter/material.dart';

class ProjectPaddings extends EdgeInsets {
  const ProjectPaddings.horiztontal10() : super.symmetric(horizontal: 10);
  const ProjectPaddings.horiztontal16() : super.symmetric(horizontal: 16);
  const ProjectPaddings.all8() : super.all(8);
  const ProjectPaddings.all16() : super.all(16);
  const ProjectPaddings.all20() : super.all(20);
  const ProjectPaddings.marginBottom20() : super.only(bottom: 20);
}
