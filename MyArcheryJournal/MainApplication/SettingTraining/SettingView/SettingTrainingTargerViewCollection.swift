//
//  SettingTrainingTargerViewCollection.swift
//  Archery Journal
//
//  Created by Evgenii on 23.02.2025.
//

import SwiftUI

struct SettingTrainingTargerViewCollection: View {
    let cards: [CartTarget]
    @Binding var selectedCard: Int?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(0..<cards.count/2 + cards.count % 2, id: \.self) { row in
                    HStack(spacing: 16) {
                        ForEach(0..<2, id: \.self) { column in
                            if row * 2 + column < cards.count {
                                SettingCardView(card: cards[row * 2 + column],
                                                 isSelected: self.selectedCard == row * 2 + column) {
                                    // Обновляем selectedCard
                                    self.selectedCard = (self.selectedCard == row * 2 + column) ? nil : row * 2 + column
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                .frame(width: 174)
                            }
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(PaletteApp.adaptiveBGSecondary)
        .navigationTitle(Tx.SettingTraining.target.localized())
    }
}
