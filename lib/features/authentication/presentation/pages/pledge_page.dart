import 'package:flutter/material.dart';
import 'package:rideme_driver/core/extensions/context_extensions.dart';
import 'package:rideme_driver/core/size/sizes.dart';
import 'package:rideme_driver/core/spacing/whitspacing.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';
import 'package:rideme_driver/core/widgets/buttons/generic_button_widget.dart';
import 'package:rideme_driver/features/authentication/domain/entity/pledge_entity.dart';

class PledgePage extends StatefulWidget {
  const PledgePage({super.key});

  @override
  State<PledgePage> createState() => _PledgePageState();
}

class _PledgePageState extends State<PledgePage> {
  @override
  Widget build(BuildContext context) {
    List<PledgeEntity> pledges = [
      PledgeEntity(
        label: context.appLocalizations.ensureSafety,
        pledges: [
          context.appLocalizations.ensureSafety1,
          context.appLocalizations.ensureSafety2,
        ],
      ),
      PledgeEntity(
        label: context.appLocalizations.showRespect,
        pledges: [
          context.appLocalizations.showRespect1,
          context.appLocalizations.showRespect2,
        ],
      ),
      PledgeEntity(
        label: context.appLocalizations.maintainProfessionalism,
        pledges: [
          context.appLocalizations.maintainProfessionalism1,
          context.appLocalizations.maintainProfessionalism2,
        ],
      ),
      PledgeEntity(
        label: context.appLocalizations.communicateClearly,
        pledges: [
          context.appLocalizations.communicateClearly1,
          context.appLocalizations.communicateClearly2,
        ],
      ),
      PledgeEntity(
        label: context.appLocalizations.demonstrateIntegrity,
        pledges: [
          context.appLocalizations.demonstrateIntegrity1,
          context.appLocalizations.demonstrateIntegrity2,
        ],
      ),
      PledgeEntity(
        label: context.appLocalizations.seekImprovement,
        pledges: [
          context.appLocalizations.seekImprovement1,
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.height(context, 0.02)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.appLocalizations.pledgeOfGoodBehaviour,
                style: context.textTheme.headlineSmall?.copyWith(
                  color: AppColors.rideMeBlackNormalActive,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              Space.height(context, 0.02),
              Text(
                context.appLocalizations.pledgeIntro,
                style: context.textTheme.displayMedium
                    ?.copyWith(color: AppColors.rideMeGreyDarker),
              ),
              Space.height(context, 0.02),
              ...List.generate(
                pledges.length,
                (index) => _PledgeTile(
                  index: index + 1,
                  pledgeEntity: pledges[index],
                ),
              ),
              Text(
                context.appLocalizations.pledgeOutro,
                style: context.textTheme.displayMedium
                    ?.copyWith(color: AppColors.rideMeGreyDarker),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: AppColors.rideMeBackgroundLight,
        width: double.infinity,
        padding: EdgeInsets.all(Sizes.height(context, 0.02)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GenericButton(
              onTap: () {},
              label: context.appLocalizations.iAccept,
              isActive: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _PledgeTile extends StatelessWidget {
  final int index;
  final PledgeEntity pledgeEntity;
  const _PledgeTile({
    required this.index,
    required this.pledgeEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Sizes.height(context, 0.01)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$index.',
            style: context.textTheme.displayLarge?.copyWith(
                color: AppColors.rideMeBlackDark, fontWeight: FontWeight.w500),
          ),
          Space.width(context, 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${pledgeEntity.label}:',
                style: context.textTheme.displayLarge?.copyWith(
                    color: AppColors.rideMeBlackDark,
                    fontWeight: FontWeight.w500),
              ),
              ...List.generate(
                pledgeEntity.pledges.length,
                (index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '•',
                      style: context.textTheme.displayMedium?.copyWith(
                          color: AppColors.rideMeBlackDark,
                          fontWeight: FontWeight.w500),
                    ),
                    Space.width(context, 0.01),
                    SizedBox(
                      width: Sizes.width(context, 0.7),
                      child: Text(
                        pledgeEntity.pledges[index],
                        style: context.textTheme.displayMedium
                            ?.copyWith(color: AppColors.rideMeGreyDarker),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
