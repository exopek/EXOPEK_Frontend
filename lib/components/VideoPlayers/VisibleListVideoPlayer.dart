import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:provider/provider.dart';

const kDefaultAspectRatio = 9 / 16;

enum VideoType { file, network, asset }

Set<VideoPlayerController> _videoPlayers =
    Set(); // Jedes Element müsste noch einen Key bekommen um zu prüfen ob es benutzt werden kann oder weggeworden wird, beziehungsweise initialisiert werden muss

Map<String, VideoPlayerController> _videoPlayersMap = Map();

class VisibleListVideoPlayer extends StatefulWidget {
  const VisibleListVideoPlayer({
    required this.path,
    required this.videoKey,
    this.videoType = VideoType.network,
    this.width,
    this.height,
    this.aspectRatio,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.allowFullScreen = true,
    this.allowPlaybackSpeedMenu = false,
    this.lazyLoad = false,
    this.pauseOnNavigate = true,
    this.mute = true,
    this.onPauseVideo,
    this.isPageView = false,
    this.isVisibile
  });

  final String path;
  final VideoType videoType;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final bool allowFullScreen;
  final bool allowPlaybackSpeedMenu;
  final bool lazyLoad;
  final bool pauseOnNavigate;
  final bool mute;
  final String videoKey;
  final bool isPageView;
  final void Function(ChewieController)? onPauseVideo;
  final Function(bool)? isVisibile;

  @override
  State<StatefulWidget> createState() => _VisibleListVideoPlayerState();
}

class _VisibleListVideoPlayerState extends State<VisibleListVideoPlayer>
    with RouteAware {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _loggedError = false;
  bool _subscribedRoute = false;
  late BaseCacheManager _cacheManager;

  final RouteObserver<ModalRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  void initState() {
    super.initState();
    _cacheManager = DefaultCacheManager();
    bool _isPlaying = false;
    initializePlayer();
  }

  @override
  void dispose() {
    if (_subscribedRoute) {
      routeObserver.unsubscribe(this);
    }
    _videoPlayers.remove(_videoPlayerController);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(VisibleListVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _videoPlayers.remove(_videoPlayerController);
      _videoPlayerController?.dispose();
      _chewieController?.dispose();
      initializePlayer();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.pauseOnNavigate && ModalRoute.of(context) is PageRoute) {
      _subscribedRoute = true;
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    }
  }

  @override
  void didPushNext() {
    if (widget.pauseOnNavigate) {
      _videoPlayerController?.pause();
    }
  }

  double get width => widget.width == null || widget.width! >= double.infinity
      ? MediaQuery.of(context).size.width
      : widget.width!;

  double get height =>
      widget.height == null || widget.height! >= double.infinity
          ? width / aspectRatio
          : widget.height!;

  double get aspectRatio =>
      _chewieController?.videoPlayerController.value.aspectRatio ??
      kDefaultAspectRatio;

  Future initializePlayer() async {
    var fileInfo = await _cacheManager.getFileFromCache(widget.path);

    if (fileInfo == null) {
      unawaited(_cacheManager.downloadFile(widget.path));
      _videoPlayerController = widget.videoType == VideoType.network
          ? VideoPlayerController.network(widget.path)
          : widget.videoType == VideoType.asset
              ? VideoPlayerController.asset(widget.path)
              : VideoPlayerController.file(File(widget.path));
    } else {
      print('[Play Video form Cache]');
      _videoPlayerController = VideoPlayerController.file(fileInfo.file);
    }

    if (kIsWeb && widget.autoPlay) {
      // Browsers generally don't allow autoplay unless it's muted.
      // Ideally this should be configurable, but for now we just automatically
      // mute on web.
      // See https://pub.dev/packages/video_player_web#autoplay
      _videoPlayerController!.setVolume(0);
    }
    if (!widget.lazyLoad) {
      await _videoPlayerController?.initialize();
    }

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: true,
      showControls: false,
      allowFullScreen: widget.allowFullScreen,
      allowPlaybackSpeedChanging: widget.allowPlaybackSpeedMenu,
      allowMuting: true,
    );

    _videoPlayers.add(_videoPlayerController!);
    _videoPlayerController!.addListener(() {
      if (_videoPlayerController!.value.hasError && !_loggedError) {
        print(
            'Error playing video: ${_videoPlayerController!.value.errorDescription}');
        _loggedError = true;
      }
      
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayers.forEach((otherPlayer) {
          if (otherPlayer != _videoPlayerController &&
              otherPlayer.value.isPlaying) {
            if (this.mounted) {
              setState(() {
                otherPlayer.pause();
              });
            }
          }
        });
      }
    });

    if (this.mounted) {
      setState(() {});
    }
  }

  void activateVideoPlayer() {
    if (_videoPlayersMap[widget.videoKey] != null && widget.autoPlay) {
      _videoPlayersMap[widget.videoKey]!.play();
    } else if (_videoPlayersMap[widget.videoKey] != null && !widget.autoPlay) {
      _videoPlayersMap[widget.videoKey]!.pause();
    }
  }

  @override
  Widget build(BuildContext context) => _chewieController != null &&
                      _chewieController!
                          .videoPlayerController.value.isInitialized
                  ? VisibilityDetector(
                      key: Key(widget.videoKey),
                      onVisibilityChanged: (info) {
                        if (info.visibleFraction >= 0.4) {
                          _chewieController?.play();
                          //widget.isVisibile!(true);
                        } else {
                          //widget.isVisibile!(false);
                          if (_chewieController != null &&
                              widget.isPageView == true) {
                                _chewieController?.play();
                              }
                          if (_chewieController != null &&
                              widget.isPageView == false) {
                            _chewieController?.pause();
                              }
                        }
                      },
                      child: Chewie(
                        controller: _chewieController!,
                      ),
                    )
                  : (_chewieController != null &&
                          !_chewieController!
                              .videoPlayerController.value.isInitialized)
                      ? Container()
                      : Container();
            
          
       
}
