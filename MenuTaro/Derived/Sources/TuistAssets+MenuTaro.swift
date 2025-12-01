// swiftlint:disable:this file_name
// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist



#if os(macOS)
#if hasFeature(InternalImportsByDefault)
public import AppKit
#else
import AppKit
#endif
#else
#if hasFeature(InternalImportsByDefault)
public import UIKit
#else
import UIKit
#endif
#endif

#if canImport(SwiftUI)
#if hasFeature(InternalImportsByDefault)
public import SwiftUI
#else
import SwiftUI
#endif
#endif

// MARK: - Asset Catalogs

public enum MenuTaroAsset: Sendable {
  public enum Assets {
  public static let accentColor = MenuTaroColors(name: "AccentColor")
    public static let cardBackTaro = MenuTaroImages(name: "card_back_taro")
    public static let cardHome = MenuTaroImages(name: "card_home")
    public static let cardback = MenuTaroImages(name: "cardback")
    public static let cardfront = MenuTaroImages(name: "cardfront")
    public static let transparentCard = MenuTaroImages(name: "transparentCard")
    public static let catCookieSnack = MenuTaroImages(name: "cat_cookie_snack")
    public static let catHome = MenuTaroImages(name: "cat_home")
    public static let chicken = MenuTaroImages(name: "chicken")
    public static let croissant = MenuTaroImages(name: "croissant")
    public static let iceCream = MenuTaroImages(name: "iceCream")
    public static let tiramisu = MenuTaroImages(name: "tiramisu")
    public static let backgroundColor = MenuTaroColors(name: "backgroundColor")
    public static let buttonDark = MenuTaroColors(name: "buttonDark")
    public static let buttonGrey = MenuTaroColors(name: "buttonGrey")
    public static let buttonOrange = MenuTaroColors(name: "buttonOrange")
    public static let glassGrayBase = MenuTaroColors(name: "glassGrayBase")
    public static let glassShadowBlack10 = MenuTaroColors(name: "glassShadowBlack10")
    public static let glassTextDark = MenuTaroColors(name: "glassTextDark")
    public static let primaryRed = MenuTaroColors(name: "primaryRed")
    public static let secondaryRed = MenuTaroColors(name: "secondaryRed")
    public static let tertiaryRedLight = MenuTaroColors(name: "tertiaryRedLight")
    public static let snackRank1 = MenuTaroColors(name: "snackRank1")
    public static let snackRank2 = MenuTaroColors(name: "snackRank2")
    public static let snackRank3 = MenuTaroColors(name: "snackRank3")
    public static let cookieBrokenHome = MenuTaroImages(name: "cookie_broken_home")
    public static let cookieBrokenSnack = MenuTaroImages(name: "cookie_broken_snack")
    public static let cookieSnack = MenuTaroImages(name: "cookie_snack")
    public static let bibimbap = MenuTaroImages(name: "Bibimbap")
    public static let bibimnoodle = MenuTaroImages(name: "Bibimnoodle")
    public static let boSSAM = MenuTaroImages(name: "BoSSAM")
    public static let boneSoup = MenuTaroImages(name: "BoneSoup")
    public static let bulgogiPizza = MenuTaroImages(name: "BulgogiPizza")
    public static let buncha = MenuTaroImages(name: "Buncha")
    public static let burrito = MenuTaroImages(name: "Burrito")
    public static let chickenMayo = MenuTaroImages(name: "ChickenMayo")
    public static let combinationPizza = MenuTaroImages(name: "CombinationPizza")
    public static let coolmyeon = MenuTaroImages(name: "Coolmyeon")
    public static let creamPasta = MenuTaroImages(name: "CreamPasta")
    public static let creamRisotto = MenuTaroImages(name: "CreamRisotto")
    public static let curryNann = MenuTaroImages(name: "Curry&Nann")
    public static let dakGalbi = MenuTaroImages(name: "DakGalbi")
    public static let dakKal = MenuTaroImages(name: "DakKal")
    public static let dakgangjeong = MenuTaroImages(name: "Dakgangjeong")
    public static let donkatsu = MenuTaroImages(name: "Donkatsu")
    public static let galbiJJim = MenuTaroImages(name: "GalbiJJim")
    public static let gobchang = MenuTaroImages(name: "Gobchang")
    public static let gorgonzolaPizza = MenuTaroImages(name: "GorgonzolaPizza")
    public static let guobaorou = MenuTaroImages(name: "Guobaorou")
    public static let guwoonChicken = MenuTaroImages(name: "GuwoonChicken")
    public static let gyudong = MenuTaroImages(name: "Gyudong")
    public static let hamburger = MenuTaroImages(name: "Hamburger")
    public static let hangjeongsal = MenuTaroImages(name: "Hangjeongsal")
    public static let hoedeopbap = MenuTaroImages(name: "Hoedeopbap")
    public static let jJimDak = MenuTaroImages(name: "JJimDak")
    public static let jeyook = MenuTaroImages(name: "Jeyook")
    public static let jjajangmyeon = MenuTaroImages(name: "Jjajangmyeon")
    public static let jjamppong = MenuTaroImages(name: "Jjamppong")
    public static let jjolmyeon = MenuTaroImages(name: "Jjolmyeon")
    public static let jokBal = MenuTaroImages(name: "JokBal")
    public static let jook = MenuTaroImages(name: "Jook")
    public static let katsu = MenuTaroImages(name: "Katsu")
    public static let katsuDong = MenuTaroImages(name: "KatsuDong")
    public static let kimchiJJim = MenuTaroImages(name: "KimchiJJim")
    public static let kimjji = MenuTaroImages(name: "Kimjji")
    public static let makguksu = MenuTaroImages(name: "Makguksu")
    public static let malaxiangguo = MenuTaroImages(name: "Malaxiangguo")
    public static let maratang = MenuTaroImages(name: "Maratang")
    public static let oilPasta = MenuTaroImages(name: "OilPasta")
    public static let partyNoodle = MenuTaroImages(name: "PartyNoodle")
    public static let peperoniPizza = MenuTaroImages(name: "PeperoniPizza")
    public static let pilaf = MenuTaroImages(name: "Pilaf")
    public static let poke = MenuTaroImages(name: "Poke")
    public static let porkSoup = MenuTaroImages(name: "PorkSoup")
    public static let potatoPizza = MenuTaroImages(name: "PotatoPizza")
    public static let rBap = MenuTaroImages(name: "RBap")
    public static let rabokki = MenuTaroImages(name: "Rabokki")
    public static let ramen = MenuTaroImages(name: "Ramen")
    public static let ricenoodles = MenuTaroImages(name: "Ricenoodles")
    public static let rosePasta = MenuTaroImages(name: "RosePasta")
    public static let roseRisotto = MenuTaroImages(name: "RoseRisotto")
    public static let sakeDon = MenuTaroImages(name: "SakeDon")
    public static let salad = MenuTaroImages(name: "Salad")
    public static let samgyeop = MenuTaroImages(name: "Samgyeop")
    public static let samgyetang = MenuTaroImages(name: "Samgyetang")
    public static let sandwich = MenuTaroImages(name: "Sandwich")
    public static let seasoningChicken = MenuTaroImages(name: "SeasoningChicken")
    public static let shirimpPizza = MenuTaroImages(name: "ShirimpPizza")
    public static let soba = MenuTaroImages(name: "Soba")
    public static let sootBul = MenuTaroImages(name: "SootBul")
    public static let soyBeanSoup = MenuTaroImages(name: "SoyBeanSoup")
    public static let soyChicken = MenuTaroImages(name: "SoyChicken")
    public static let steakDupbap = MenuTaroImages(name: "SteakDupbap")
    public static let sundaiSoup = MenuTaroImages(name: "SundaiSoup")
    public static let sushi = MenuTaroImages(name: "Sushi")
    public static let sweeyPotato = MenuTaroImages(name: "SweeyPotato")
    public static let taco = MenuTaroImages(name: "Taco")
    public static let tangsuyuk = MenuTaroImages(name: "Tangsuyuk")
    public static let tomatoSpaghetti = MenuTaroImages(name: "TomatoSpaghetti")
    public static let tongdak = MenuTaroImages(name: "Tongdak")
    public static let tteokbokki = MenuTaroImages(name: "Tteokbokki")
    public static let yangnyeomChicken = MenuTaroImages(name: "YangnyeomChicken")
    public static let yogurt = MenuTaroImages(name: "Yogurt")
    public static let yukgaejang = MenuTaroImages(name: "Yukgaejang")
    public static let kimbap = MenuTaroImages(name: "kimbap")
    public static let foodCategoryChinese = MenuTaroImages(name: "FoodCategory_Chinese")
    public static let foodCategoryJapanese = MenuTaroImages(name: "FoodCategory_Japanese")
    public static let foodCategoryKorean = MenuTaroImages(name: "FoodCategory_Korean")
    public static let foodCategoryWestern = MenuTaroImages(name: "FoodCategory_Western")
    public static let foodCategoryTotalMenu = MenuTaroImages(name: "FoodCategory_totalMenu")
    public static let lampTaro = MenuTaroImages(name: "lamp_taro")
    public static let brownie = MenuTaroImages(name: "Brownie")
    public static let cake = MenuTaroImages(name: "Cake")
    public static let churro = MenuTaroImages(name: "Churro")
    public static let croffle = MenuTaroImages(name: "Croffle")
    public static let doughnut = MenuTaroImages(name: "Doughnut")
    public static let financier = MenuTaroImages(name: "Financier")
    public static let hotdog = MenuTaroImages(name: "Hotdog")
    public static let hotteok = MenuTaroImages(name: "Hotteok")
    public static let icecream = MenuTaroImages(name: "Icecream")
    public static let pudding = MenuTaroImages(name: "Pudding")
    public static let saltBread = MenuTaroImages(name: "SaltBread")
    public static let shavedice = MenuTaroImages(name: "Shavedice")
    public static let swissroll = MenuTaroImages(name: "Swissroll")
    public static let takoyaki = MenuTaroImages(name: "Takoyaki")
    public static let waffle = MenuTaroImages(name: "Waffle")
    public static let xtoast = MenuTaroImages(name: "Xtoast")
    public static let yakgwa = MenuTaroImages(name: "Yakgwa")
    public static let yoghurtIcecream = MenuTaroImages(name: "YoghurtIcecream")
    public static let kkwabaegi = MenuTaroImages(name: "kkwabaegi")
    public static let testBookmark = MenuTaroImages(name: "TestBookmark")
    public static let ice = MenuTaroImages(name: "ice")
  }
  public enum PreviewAssets {
  }
}

// MARK: - Implementation Details

public final class MenuTaroColors: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public var color: Color {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIColor: SwiftUI.Color {
      return SwiftUI.Color(asset: self)
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension MenuTaroColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: MenuTaroColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: MenuTaroColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct MenuTaroImages: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: MenuTaroImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: MenuTaroImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: MenuTaroImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftformat:enable all
// swiftlint:enable all
