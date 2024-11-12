// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Localizable.strings
  ///   TravelPlanner
  /// 
  ///   Created by Сергей Кухарев on 05.11.2024.
  internal static let copyrightText = L10n.tr("Localizable", "CopyrightText", fallback: "Приложение использует API «Яндекс.Расписания»")
  /// Откуда
  internal static let fromStationPrompt = L10n.tr("Localizable", "FromStationPrompt", fallback: "Откуда")
  /// Город не найден
  internal static let searchCityNotFound = L10n.tr("Localizable", "SearchCityNotFound", fallback: "Город не найден")
  /// Введите запрос
  internal static let searchCityPlaceholder = L10n.tr("Localizable", "SearchCityPlaceholder", fallback: "Введите запрос")
  /// Станция не найдена
  internal static let searchStationsNotFound = L10n.tr("Localizable", "SearchStationsNotFound", fallback: "Станция не найдена")
  /// Введите запрос
  internal static let searchStationsPlaceholder = L10n.tr("Localizable", "SearchStationsPlaceholder", fallback: "Введите запрос")
  /// Выбор города
  internal static let selectionCityTitle = L10n.tr("Localizable", "SelectionCityTitle", fallback: "Выбор города")
  /// Выбор cтанции
  internal static let selectionStationTitle = L10n.tr("Localizable", "SelectionStationTitle", fallback: "Выбор cтанции")
  /// Тёмная тема
  internal static let settingsViewDarkModeLabel = L10n.tr("Localizable", "SettingsViewDarkModeLabel", fallback: "Тёмная тема")
  /// Пользовательское соглашение
  internal static let settingsViewUserAgreementLabel = L10n.tr("Localizable", "SettingsViewUserAgreementLabel", fallback: "Пользовательское соглашение")
  /// Куда
  internal static let toStationPrompt = L10n.tr("Localizable", "ToStationPrompt", fallback: "Куда")
  /// Версия
  internal static let yandexAPIVersion = L10n.tr("Localizable", "YandexAPIVersion", fallback: "Версия")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

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
