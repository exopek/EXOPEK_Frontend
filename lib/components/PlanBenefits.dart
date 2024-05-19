import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:flutter/material.dart';

class PlanBenefits extends StatelessWidget {
  final List<String> benefits;
  const PlanBenefits({super.key, required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Das ist für dich drin',
            style: ThemeBase.of(context).headlineSmall,
          ),
        ),
        const SizedBox(height: 4.0),
        Column(
          children: benefits
              .map((benefit) => _benefitRow(context, benefit))
              .toList(),
        ),
      ],
    );
  }

  Widget _benefitRow(BuildContext context, String benefit) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          const SizedBox(width: 8.0),
          SizedBox(
            width: 20,
            height: 20,
            child: Icon(Icons.check_box_outlined,
                color: ThemeBase.of(context).success, size: 20),
          ),
          const SizedBox(width: 8.0),
          Expanded(child: Text(benefit, style: ThemeBase.of(context).bodySmall.copyWith(color: ThemeBase.of(context).secondaryText))),
        ],
      ),
    );
  }
}
