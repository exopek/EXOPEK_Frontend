import 'package:exopek_workout_app/components/HashTagPill.dart';
import 'package:exopek_workout_app/components/Shared/GenericAppBar.dart';
import 'package:exopek_workout_app/theme/ThemeBase.dart';
import 'package:exopek_workout_app/utils/AppVideoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../dependencyInjection/plansProvider/PlansProvider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HighlightsPlansPage extends ConsumerStatefulWidget {
  const HighlightsPlansPage({super.key});

  @override
  ConsumerState<HighlightsPlansPage> createState() => _HighlightsPlansPageState();
}

class _HighlightsPlansPageState extends ConsumerState<HighlightsPlansPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(asyncPlansPageControllerProvider);
    return result.when(
      data: (result) {
        
        return Scaffold(
          backgroundColor: ThemeBase.of(context).primaryBackground,
          extendBodyBehindAppBar: true,
          appBar: GenericAppBar.build(context, AppLocalizations.of(context).planHighlightsPageTitle),
          body: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: result.plans.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        width: MediaQuery.sizeOf(context).width,
                        child: ClipRRect(
                              child: AppVideoPlayer(
                                path: result.plans[index].videoUrl!,
                                videoType: VideoType.network,
                                looping: true,
                                showControls: false,
                                autoPlay: true,
                              ),
                            ),
                      ),
                    ),
                    
                    Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: 180,
                  decoration: ShapeDecoration(
                    color: Color(0xFF262424).withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          result.plans[index].name,
                          textAlign: TextAlign.left,
                          style: ThemeBase.of(context).headlineSmall.copyWith(
                            color: ThemeBase.of(context).primaryText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0),
                        child: Text(
                          result.plans[index].description ?? '',
                          textAlign: TextAlign.left,
                          style: ThemeBase.of(context).bodySmall.copyWith(
                            color: ThemeBase.of(context).primaryText,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 12.0, bottom: 8.0, right: 8.0),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (var hashtag
                                in (result.plans[index].hashtagsList as List<String>).take(3))
                              IntrinsicWidth(
                                  child: HashTagPill(
                                text: hashtag,
                                color: ThemeBase.of(context).secondaryBackground,
                              ))
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
                  ],
                );
              },
              ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator(
        color: ThemeBase.of(context).primaryText,
        strokeWidth: 0.5,
      )),
      error: (error, stackTrace) => Center(
        child: Text(error.toString()),
      ),
    );
  }
}
