// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal enum Colors {
    internal static let activeTabItemColor = ColorAsset(name: "ActiveTabItemColor")
    internal static let appBlack = ColorAsset(name: "AppBlack")
    internal static let blackUniversal = ColorAsset(name: "BlackUniversal")
    internal static let blueUniversal = ColorAsset(name: "BlueUniversal")
    internal static let grayUniversal = ColorAsset(name: "GrayUniversal")
    internal static let launchScreenBackgroundColor = ColorAsset(name: "LaunchScreenBackgroundColor")
    internal static let lightGrayUniversal = ColorAsset(name: "LightGrayUniversal")
    internal static let redUniversal = ColorAsset(name: "RedUniversal")
  }
  internal enum Images {
    internal static let changeStationButton = ImageAsset(name: "ChangeStationButton")
    internal static let checkboxOff = ImageAsset(name: "CheckboxOff")
    internal static let checkboxOn = ImageAsset(name: "CheckboxOn")
    internal static let closeButton = ImageAsset(name: "CloseButton")
    internal static let noInternetError = ImageAsset(name: "NoInternetError")
    internal static let radiobuttonOff = ImageAsset(name: "RadiobuttonOff")
    internal static let radiobuttonOn = ImageAsset(name: "RadiobuttonOn")
    internal static let redMarker = ImageAsset(name: "RedMarker")
    internal static let scheduleTabItem = ImageAsset(name: "ScheduleTabItem")
    internal static let serverError = ImageAsset(name: "ServerError")
    internal static let settingsTabItem = ImageAsset(name: "SettingsTabItem")
    internal static let splashView = ImageAsset(name: "SplashView")
    internal enum Stories {
      internal static let story1Detail1 = ImageAsset(name: "Story1Detail1")
      internal static let story1Detail2 = ImageAsset(name: "Story1Detail2")
      internal static let story1Preview = ImageAsset(name: "Story1Preview")
      internal static let story2Detail1 = ImageAsset(name: "Story2Detail1")
      internal static let story2Detail2 = ImageAsset(name: "Story2Detail2")
      internal static let story2Preview = ImageAsset(name: "Story2Preview")
      internal static let story3Detail1 = ImageAsset(name: "Story3Detail1")
      internal static let story3Detail2 = ImageAsset(name: "Story3Detail2")
      internal static let story3Preview = ImageAsset(name: "Story3Preview")
      internal static let story4Detail1 = ImageAsset(name: "Story4Detail1")
      internal static let story4Detail2 = ImageAsset(name: "Story4Detail2")
      internal static let story4Preview = ImageAsset(name: "Story4Preview")
      internal static let story5Detail1 = ImageAsset(name: "Story5Detail1")
      internal static let story5Detail2 = ImageAsset(name: "Story5Detail2")
      internal static let story5Preview = ImageAsset(name: "Story5Preview")
      internal static let story6Detail1 = ImageAsset(name: "Story6Detail1")
      internal static let story6Detail2 = ImageAsset(name: "Story6Detail2")
      internal static let story6Preview = ImageAsset(name: "Story6Preview")
      internal static let story7Detail1 = ImageAsset(name: "Story7Detail1")
      internal static let story7Detail2 = ImageAsset(name: "Story7Detail2")
      internal static let story7Preview = ImageAsset(name: "Story7Preview")
      internal static let story8Detail1 = ImageAsset(name: "Story8Detail1")
      internal static let story8Detail2 = ImageAsset(name: "Story8Detail2")
      internal static let story8Preview = ImageAsset(name: "Story8Preview")
      internal static let story9Detail1 = ImageAsset(name: "Story9Detail1")
      internal static let story9Detail2 = ImageAsset(name: "Story9Detail2")
      internal static let story9Preview = ImageAsset(name: "Story9Preview")
    }
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
