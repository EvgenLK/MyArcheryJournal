//
//  LanguageManager.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 17.10.2024.
//

import SwiftUI
import Combine

final class LanguageManager: ObservableObject {
    @Published var selectedLanguage: EnumLanguage {
        didSet {
            UserDefaults.standard.set(selectedLanguage.rawValue, forKey: "selectedLanguage")
            Bundle.setLanguage(selectedLanguage.rawValue)
        }
    }

    init() {
        let savedLang = UserDefaults.standard.string(forKey: "selectedLanguage") ?? EnumLanguage.english.rawValue
        self.selectedLanguage = EnumLanguage(rawValue: savedLang) ?? EnumLanguage.english
        Bundle.setLanguage(selectedLanguage.rawValue)
    }
}

extension Bundle {
    private static var bundle: Bundle?

    final class func setLanguage(_ language: String) {
        if let path = Bundle.main.path(forResource: language, ofType: "lproj") {
            bundle = Bundle(path: path)
        } else {
            let defaultLanguage = "en"
            if let defaultPath = Bundle.main.path(forResource: defaultLanguage, ofType: "lproj") {
                bundle = Bundle(path: defaultPath)
            } else {
                bundle = nil
            }
        }
    }

    final class func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return bundle?.localizedString(forKey: key, value: value, table: tableName) ?? key
    }
}
