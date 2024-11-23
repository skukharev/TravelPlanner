// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Применить
  internal static let applySegmentParamsButtonTitle = L10n.tr("Localizable", "ApplySegmentParamsButtonTitle", fallback: "Применить")
  /// Информация о перевозчике
  internal static let carrierNavigationTitle = L10n.tr("Localizable", "CarrierNavigationTitle", fallback: "Информация о перевозчике")
  /// Localizable.strings
  ///   TravelPlanner
  /// 
  ///   Created by Сергей Кухарев on 05.11.2024.
  internal static let copyrightText = L10n.tr("Localizable", "CopyrightText", fallback: "Приложение использует API «Яндекс.Расписания»")
  /// День 12:00 - 18:00
  internal static let departureTimeAfternoon = L10n.tr("Localizable", "DepartureTimeAfternoon", fallback: "День 12:00 - 18:00")
  /// Вечер 18:00 - 00:00
  internal static let departureTimeEvening = L10n.tr("Localizable", "DepartureTimeEvening", fallback: "Вечер 18:00 - 00:00")
  /// Утро 06:00 - 12:00
  internal static let departureTimeMorning = L10n.tr("Localizable", "DepartureTimeMorning", fallback: "Утро 06:00 - 12:00")
  /// Ночь 00:00 - 06:00
  internal static let departureTimeNight = L10n.tr("Localizable", "DepartureTimeNight", fallback: "Ночь 00:00 - 06:00")
  /// E-mail
  internal static let emailCarrierPropertyName = L10n.tr("Localizable", "EmailCarrierPropertyName", fallback: "E-mail")
  /// Нет интернета
  internal static let errorNoInternet = L10n.tr("Localizable", "ErrorNoInternet", fallback: "Нет интернета")
  /// Ошибка сервера
  internal static let errorServerError = L10n.tr("Localizable", "ErrorServerError", fallback: "Ошибка сервера")
  /// Найти
  internal static let findSegmentsButtonTitle = L10n.tr("Localizable", "FindSegmentsButtonTitle", fallback: "Найти")
  /// Откуда
  internal static let fromStationPrompt = L10n.tr("Localizable", "FromStationPrompt", fallback: "Откуда")
  /// Нет
  internal static let hideTransfersRadioButtonTitle = L10n.tr("Localizable", "HideTransfersRadioButtonTitle", fallback: "Нет")
  /// Телефон
  internal static let phoneCarrierPropertyName = L10n.tr("Localizable", "PhoneCarrierPropertyName", fallback: "Телефон")
  /// Город не найден
  internal static let searchCityNotFound = L10n.tr("Localizable", "SearchCityNotFound", fallback: "Город не найден")
  /// Введите запрос
  internal static let searchCityPlaceholder = L10n.tr("Localizable", "SearchCityPlaceholder", fallback: "Введите запрос")
  /// Станция не найдена
  internal static let searchStationsNotFound = L10n.tr("Localizable", "SearchStationsNotFound", fallback: "Станция не найдена")
  /// Введите запрос
  internal static let searchStationsPlaceholder = L10n.tr("Localizable", "SearchStationsPlaceholder", fallback: "Введите запрос")
  /// Уточнить время
  internal static let segmentParametersButtonTitle = L10n.tr("Localizable", "SegmentParametersButtonTitle", fallback: "Уточнить время")
  /// Показывать варианты с пересадками
  internal static let segmentParamsShowTransfersTitle = L10n.tr("Localizable", "SegmentParamsShowTransfersTitle", fallback: "Показывать варианты с пересадками")
  /// Время отправления
  internal static let segmentParamsTimeTitle = L10n.tr("Localizable", "SegmentParamsTimeTitle", fallback: "Время отправления")
  /// Вариантов нет
  internal static let segmentsNotFound = L10n.tr("Localizable", "SegmentsNotFound", fallback: "Вариантов нет")
  /// Выбор города
  internal static let selectionCityTitle = L10n.tr("Localizable", "SelectionCityTitle", fallback: "Выбор города")
  /// Выбор cтанции
  internal static let selectionStationTitle = L10n.tr("Localizable", "SelectionStationTitle", fallback: "Выбор cтанции")
  /// Тёмная тема
  internal static let settingsViewDarkModeLabel = L10n.tr("Localizable", "SettingsViewDarkModeLabel", fallback: "Тёмная тема")
  /// Пользовательское соглашение
  internal static let settingsViewUserAgreementLabel = L10n.tr("Localizable", "SettingsViewUserAgreementLabel", fallback: "Пользовательское соглашение")
  /// Да
  internal static let showTransfersRadioButtonTitle = L10n.tr("Localizable", "ShowTransfersRadioButtonTitle", fallback: "Да")
  /// Куда
  internal static let toStationPrompt = L10n.tr("Localizable", "ToStationPrompt", fallback: "Куда")
  /// С пересадкой в г.
  internal static let transferPrefixText = L10n.tr("Localizable", "TransferPrefixText", fallback: "С пересадкой в г.")
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
