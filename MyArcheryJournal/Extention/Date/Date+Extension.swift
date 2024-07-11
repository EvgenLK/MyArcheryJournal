//
//  Date+Extension.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 11.07.2024.
//

import SwiftUI

extension Date {
    func formatDate(_ dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let formattedDateString = dateFormatter.string(from: self)
        return formattedDateString
    }
}
