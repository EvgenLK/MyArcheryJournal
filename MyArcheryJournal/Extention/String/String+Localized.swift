//
//  String+Localized.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 17.10.2024.
//

import Foundation

extension String {
    func localized() -> String {
        return Bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
