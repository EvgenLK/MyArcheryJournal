//
//  EnumLanguage.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 17.10.2024.
//

import Foundation

enum EnumLanguage: String, CaseIterable {
    case english = "en"
    case russian = "ru"
    
    var displayName: String {
        switch self {
        case .english: return "English"
        case .russian: return "Русский"
            
        }
    }
}
