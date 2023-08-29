import 'package:flutter/material.dart';

@immutable
class ProjectSpacers extends SizedBox {
  const ProjectSpacers.spacer5({super.key}) : super(height: 5);
  const ProjectSpacers.spacer10({super.key}) : super(height: 10);
  const ProjectSpacers.spacer15({super.key}) : super(height: 15);
  const ProjectSpacers.spacer20({super.key}) : super(height: 20);
  const ProjectSpacers.spacer30({super.key}) : super(height: 30);
  const ProjectSpacers.spacer50({super.key}) : super(height: 50);
  const ProjectSpacers.spacer100({super.key}) : super(height: 100);
}
