//
//  EnumArcheryError.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 21.11.2024.
//

import Foundation

enum ArcheryError: Error {
    case fetchError(String)
    case saveError(String)
}
