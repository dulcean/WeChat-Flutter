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

  /// File path: assets/lottie/bow.json
  String get bow => 'assets/lottie/bow.json';

  /// File path: assets/lottie/loading.json
  String get loading => 'assets/lottie/loading.json';

  /// File path: assets/lottie/logo_animation.json
  String get logoAnimation => 'assets/lottie/logo_animation.json';

  /// File path: assets/lottie/sphere.json
  String get sphere => 'assets/lottie/sphere.json';

  /// List of all assets
  List<String> get values => [bow, loading, logoAnimation, sphere];
}

class $AssetsVectorsGen {
  const $AssetsVectorsGen();

  /// Directory path: assets/vectors/navigator_icons
  $AssetsVectorsNavigatorIconsGen get navigatorIcons =>
      const $AssetsVectorsNavigatorIconsGen();
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

  /// File path: assets/images/icons/asset.jpg
  AssetGenImage get asset =>
      const AssetGenImage('assets/images/icons/asset.jpg');

  /// File path: assets/images/icons/ellipse.png
  AssetGenImage get ellipse =>
      const AssetGenImage('assets/images/icons/ellipse.png');

  /// File path: assets/images/icons/search_icon.png
  AssetGenImage get searchIcon =>
      const AssetGenImage('assets/images/icons/search_icon.png');

  /// File path: assets/images/icons/w_icon.png
  AssetGenImage get wIcon =>
      const AssetGenImage('assets/images/icons/w_icon.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [arrowIcon, asset, ellipse, searchIcon, wIcon];
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

class $AssetsVectorsNavigatorIconsGen {
  const $AssetsVectorsNavigatorIconsGen();

  /// File path: assets/vectors/navigator_icons/chats.svg
  String get chats => 'assets/vectors/navigator_icons/chats.svg';

  /// File path: assets/vectors/navigator_icons/friends.svg
  String get friends => 'assets/vectors/navigator_icons/friends.svg';

  /// File path: assets/vectors/navigator_icons/settings.svg
  String get settings => 'assets/vectors/navigator_icons/settings.svg';

  /// List of all assets
  List<String> get values => [chats, friends, settings];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLottieGen lottie = $AssetsLottieGen();
  static const $AssetsVectorsGen vectors = $AssetsVectorsGen();
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
