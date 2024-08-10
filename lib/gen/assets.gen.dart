/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/help
  $AssetsImagesHelpGen get help => const $AssetsImagesHelpGen();

  /// Directory path: assets/images/icons
  $AssetsImagesIconsGen get icons => const $AssetsImagesIconsGen();

  /// Directory path: assets/images/splash
  $AssetsImagesSplashGen get splash => const $AssetsImagesSplashGen();
}

class $AssetsLottieGen {
  const $AssetsLottieGen();

  /// File path: assets/lottie/logo_animation.json
  String get logoAnimation => 'assets/lottie/logo_animation.json';

  /// List of all assets
  List<String> get values => [logoAnimation];
}

class $AssetsImagesHelpGen {
  const $AssetsImagesHelpGen();

  /// File path: assets/images/help/welcome_picture.png
  AssetGenImage get welcomePicture =>
      const AssetGenImage('assets/images/help/welcome_picture.png');

  /// List of all assets
  List<AssetGenImage> get values => [welcomePicture];
}

class $AssetsImagesIconsGen {
  const $AssetsImagesIconsGen();

  /// File path: assets/images/icons/arrow_icon.png
  AssetGenImage get arrowIcon =>
      const AssetGenImage('assets/images/icons/arrow_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [arrowIcon];
}

class $AssetsImagesSplashGen {
  const $AssetsImagesSplashGen();

  /// File path: assets/images/splash/background.png
  AssetGenImage get background =>
      const AssetGenImage('assets/images/splash/background.png');

  /// File path: assets/images/splash/icon _chat_.png
  AssetGenImage get iconChat =>
      const AssetGenImage('assets/images/splash/icon _chat_.png');

  /// List of all assets
  List<AssetGenImage> get values => [background, iconChat];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
