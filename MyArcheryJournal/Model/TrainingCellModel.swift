//
//  TrainingCellModel.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 03.07.2024.
//

import SwiftUI

struct TrainingCellModel: Identifiable {
    let id = UUID()
    let imageTaghet: Image
    let dateTraining: String
    let countShot: String
    let allShot: String
    let distance: String
    let nameTaget: String
    let avarageShot: String
}
