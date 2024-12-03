//
//  SelectedElementModel.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 17.11.2024.
//

import Foundation

struct SelectedElementModel: Equatable {
    let cellID: UUID
    let index: Int
    let series: Int
    let selectMark: Int
    let tapElement: Bool
}
