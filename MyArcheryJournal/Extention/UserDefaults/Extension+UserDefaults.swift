//
//  Extension+UserDefaults.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 22.10.2024.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let isDarkModeEnabled = "isDarkModeEnabled"
        static let selectedLanguage = "selectedLanguage"
    }
    
    var isDarkModeEnabled: Bool {
        get { bool(forKey: Keys.isDarkModeEnabled) }
        set { set(newValue, forKey: Keys.isDarkModeEnabled) }
    }

    var selectedLanguage: EnumLanguage {
        get {
            if let value = string(forKey: Keys.selectedLanguage), let language = EnumLanguage(rawValue: value) {
                return language
            } else {
                return .english // Замените на ваш язык по умолчанию
            }
        }
        set {
            set(newValue.rawValue, forKey: Keys.selectedLanguage)
        }
    }
}
