import 'package:flutter/material.dart';

class ProjectRadius extends BorderRadius {
  const ProjectRadius.onlyTop30() : super.only(topLeft: const Radius.circular(30), topRight: const Radius.circular(30));
  const ProjectRadius.appbarRadius()
      : super.only(bottomLeft: const Radius.circular(15), bottomRight: const Radius.circular(15));
  ProjectRadius.circular15() : super.circular(15);
  ProjectRadius.circular30() : super.circular(30);
  ProjectRadius.circular50() : super.circular(50);
}
