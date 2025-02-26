//
//  ListTrainingModelCell.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 03.07.2024.
//

import SwiftUI

struct TrainingSection {
    let monthYear: String
    var trainings: [ListTrainingModelCell]
}

struct ListTrainingModelCell: Identifiable {
    let id: UUID
    let imageTarget: Image
    let dateTraining: String
    let countShot: String
    let allShot: String
    let distance: String
    let nameTaget: String
    let avarageShot: String
}
