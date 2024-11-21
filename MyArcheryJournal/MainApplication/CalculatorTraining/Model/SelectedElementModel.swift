//
//  SelectedElementModel.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 17.11.2024.
//

import Foundation

struct SelectedElementModel: Equatable {
    var cellID: UUID
    var index: Int
    var series: Int
    var selectMark: Int
    var tapElement: Bool
}
