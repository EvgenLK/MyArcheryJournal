//
//  EnumLanguage.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 17.10.2024.
//

enum EnumLanguage: String, CaseIterable {
    case english = "en"
    case russian = "ru"
    
    var displayName: String {
        switch self {
        case .english: return Tx.LanguageApp.english
        case .russian: return Tx.LanguageApp.russia
            
        }
    }
}
