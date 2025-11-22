// swiftlint:disable:this file_name
// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit.NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  import UIKit.UIFont
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
public enum MenuTaroFontFamily: Sendable {
  public enum SFPro: Sendable {
    public static let black = MenuTaroFontConvertible(name: "SFPro-Black", family: "SF Pro", path: "SF-Pro.ttf")
    public static let blackItalic = MenuTaroFontConvertible(name: "SFPro-BlackItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let bold = MenuTaroFontConvertible(name: "SFPro-Bold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let boldItalic = MenuTaroFontConvertible(name: "SFPro-BoldItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let compressedBlack = MenuTaroFontConvertible(name: "SFPro-CompressedBlack", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedBold = MenuTaroFontConvertible(name: "SFPro-CompressedBold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedHeavy = MenuTaroFontConvertible(name: "SFPro-CompressedHeavy", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedLight = MenuTaroFontConvertible(name: "SFPro-CompressedLight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedMedium = MenuTaroFontConvertible(name: "SFPro-CompressedMedium", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedRegular = MenuTaroFontConvertible(name: "SFPro-CompressedRegular", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedSemibold = MenuTaroFontConvertible(name: "SFPro-CompressedSemibold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedThin = MenuTaroFontConvertible(name: "SFPro-CompressedThin", family: "SF Pro", path: "SF-Pro.ttf")
    public static let compressedUltralight = MenuTaroFontConvertible(name: "SFPro-CompressedUltralight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedBlack = MenuTaroFontConvertible(name: "SFPro-CondensedBlack", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedBold = MenuTaroFontConvertible(name: "SFPro-CondensedBold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedHeavy = MenuTaroFontConvertible(name: "SFPro-CondensedHeavy", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedLight = MenuTaroFontConvertible(name: "SFPro-CondensedLight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedMedium = MenuTaroFontConvertible(name: "SFPro-CondensedMedium", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedRegular = MenuTaroFontConvertible(name: "SFPro-CondensedRegular", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedSemibold = MenuTaroFontConvertible(name: "SFPro-CondensedSemibold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedThin = MenuTaroFontConvertible(name: "SFPro-CondensedThin", family: "SF Pro", path: "SF-Pro.ttf")
    public static let condensedUltralight = MenuTaroFontConvertible(name: "SFPro-CondensedUltralight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedBlack = MenuTaroFontConvertible(name: "SFPro-ExpandedBlack", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedBold = MenuTaroFontConvertible(name: "SFPro-ExpandedBold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedHeavy = MenuTaroFontConvertible(name: "SFPro-ExpandedHeavy", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedLight = MenuTaroFontConvertible(name: "SFPro-ExpandedLight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedMedium = MenuTaroFontConvertible(name: "SFPro-ExpandedMedium", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedRegular = MenuTaroFontConvertible(name: "SFPro-ExpandedRegular", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedSemibold = MenuTaroFontConvertible(name: "SFPro-ExpandedSemibold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedThin = MenuTaroFontConvertible(name: "SFPro-ExpandedThin", family: "SF Pro", path: "SF-Pro.ttf")
    public static let expandedUltralight = MenuTaroFontConvertible(name: "SFPro-ExpandedUltralight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let heavy = MenuTaroFontConvertible(name: "SFPro-Heavy", family: "SF Pro", path: "SF-Pro.ttf")
    public static let heavyItalic = MenuTaroFontConvertible(name: "SFPro-HeavyItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let light = MenuTaroFontConvertible(name: "SFPro-Light", family: "SF Pro", path: "SF-Pro.ttf")
    public static let lightItalic = MenuTaroFontConvertible(name: "SFPro-LightItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let medium = MenuTaroFontConvertible(name: "SFPro-Medium", family: "SF Pro", path: "SF-Pro.ttf")
    public static let mediumItalic = MenuTaroFontConvertible(name: "SFPro-MediumItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let regular = MenuTaroFontConvertible(name: "SFPro-Regular", family: "SF Pro", path: "SF-Pro.ttf")
    public static let regularItalic = MenuTaroFontConvertible(name: "SFPro-RegularItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let semibold = MenuTaroFontConvertible(name: "SFPro-Semibold", family: "SF Pro", path: "SF-Pro.ttf")
    public static let semiboldItalic = MenuTaroFontConvertible(name: "SFPro-SemiboldItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let thin = MenuTaroFontConvertible(name: "SFPro-Thin", family: "SF Pro", path: "SF-Pro.ttf")
    public static let thinItalic = MenuTaroFontConvertible(name: "SFPro-ThinItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let ultralight = MenuTaroFontConvertible(name: "SFPro-Ultralight", family: "SF Pro", path: "SF-Pro.ttf")
    public static let ultralightItalic = MenuTaroFontConvertible(name: "SFPro-UltralightItalic", family: "SF Pro", path: "SF-Pro-Italic.ttf")
    public static let all: [MenuTaroFontConvertible] = [black, blackItalic, bold, boldItalic, compressedBlack, compressedBold, compressedHeavy, compressedLight, compressedMedium, compressedRegular, compressedSemibold, compressedThin, compressedUltralight, condensedBlack, condensedBold, condensedHeavy, condensedLight, condensedMedium, condensedRegular, condensedSemibold, condensedThin, condensedUltralight, expandedBlack, expandedBold, expandedHeavy, expandedLight, expandedMedium, expandedRegular, expandedSemibold, expandedThin, expandedUltralight, heavy, heavyItalic, light, lightItalic, medium, mediumItalic, regular, regularItalic, semibold, semiboldItalic, thin, thinItalic, ultralight, ultralightItalic]
  }
  public static let allCustomFonts: [MenuTaroFontConvertible] = [SFPro.all].flatMap { $0 }
  public static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

public struct MenuTaroFontConvertible: Sendable {
  public let name: String
  public let family: String
  public let path: String

  #if os(macOS)
  public typealias Font = NSFont
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Font = UIFont
  #endif

  public func font(size: CGFloat) -> Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    return font
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  public func swiftUIFont(size: CGFloat) -> SwiftUI.Font {
    guard let font = Font(font: self, size: size) else {
      fatalError("Unable to initialize font '\(name)' (\(family))")
    }
    #if os(macOS)
    return SwiftUI.Font.custom(font.fontName, size: font.pointSize)
    #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    return SwiftUI.Font(font)
    #endif
  }
  #endif

  public func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    // swiftlint:disable:next implicit_return
    return Bundle.module.url(forResource: path, withExtension: nil)
  }
}

public extension MenuTaroFontConvertible.Font {
  convenience init?(font: MenuTaroFontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(macOS)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}
// swiftformat:enable all
// swiftlint:enable all
