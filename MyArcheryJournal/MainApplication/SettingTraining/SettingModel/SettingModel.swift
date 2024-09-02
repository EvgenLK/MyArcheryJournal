//
//  TrainingModel.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 11.07.2024.
//

import SwiftUI

struct TrainingModel {
    let id: UUID?
    let typeTraining: Int
    let imageTarget: String
    let dateTraining: Date
    let nameTaget: String
    let distance: Int
    var training: [TrainingSeriesModel]?
}

struct TrainingSeriesModel {
    let series: Int
    var dataShot: [PointModel]
}

struct PointModel {
    let point: Int
    let arrowNumber: Int
}
