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
    
    func formatToDDMM() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let formattedDateString = dateFormatter.string(from: self)
        return formattedDateString
    }
    
    func formatToMMYY() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.YY"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let formattedDateString = dateFormatter.string(from: self)
        return formattedDateString
    }
    
    var weekOfYear: Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.weekOfYear], from: self).weekOfYear ?? 111 // c 111 решить
    }
    
    var monthOfYear: Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.month], from: self).month ?? 111 // c 111 решить
    }
    
    func isInFirstHalfOfYear() -> Bool {
        let month = self.monthOfYear
        return month >= 1 && month <= 6 // Январь - Июнь
    }
    
    func isInSecondHalfOfYear() -> Bool {
        let month = self.monthOfYear
        return month >= 7 && month <= 12 // Июль - Декабрь
    }
    
    func getStartAndEndOfWeek() -> (start: Date, end: Date)? {
        let calendar = Calendar.current
        
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else {
            return nil
        }
        
        guard let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            return nil
        }
        
        return (start: startOfWeek, end: endOfWeek)
    }
}
