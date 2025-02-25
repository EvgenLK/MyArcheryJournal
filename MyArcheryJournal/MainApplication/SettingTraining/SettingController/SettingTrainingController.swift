//
//  SettingTrainingController.swift
//  Archery Journal
//
//  Created by Evgenii on 23.02.2025.
//

import SwiftUI

final class SettingTrainingController {
    
    func addCardTarget() -> [CartTarget] {
        var cardTargets: [CartTarget] = []
        for card in EnumTarget.allCases {
            if card == .notSelected { continue }
            cardTargets.append(CartTarget(image: card.caseName(), title: card.rawValue))
        }
        return cardTargets
    }
}
