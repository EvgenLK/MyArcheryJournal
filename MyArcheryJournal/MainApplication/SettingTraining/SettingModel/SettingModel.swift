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
    var training: [PointModel]?
}
struct PointModel: Hashable {
    let point: Int
    
//    static func == (lhs: PointModel, rhs: PointModel) -> Bool {
//        return lhs.point == rhs.point
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(point)
//    }
}
