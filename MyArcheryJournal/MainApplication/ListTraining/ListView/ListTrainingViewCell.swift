//
//  ListTrainingViewCell.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 04.07.2024.
//

import SwiftUI

struct ListTrainingViewCell: View {
    @EnvironmentObject var languageManager: LanguageManager
    let cellDataTrainig: ListTrainingModelCell
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                cellDataTrainig.imageTarget
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("\(cellDataTrainig.nameTaget) \(Tx.DataInCell.milimetr.localized())")
                    .font(OurFonts.fontSFProTextRegular12)
                    .foregroundStyle(PaletteApp.adaptiveLabelSecondary)
            }
            
            VStack(alignment: .leading) {
                Text("\(cellDataTrainig.dateTraining)")
                    .font(OurFonts.fontSFProTextRegular17)
                    .foregroundStyle(PaletteApp.adaptiveLabelPrimary)
                
                Text("\(Tx.DataInCell.distance.localized()): \(cellDataTrainig.distance)")
                    .font(OurFonts.fontSFProTextRegular14)
                    .foregroundStyle(PaletteApp.adaptiveLabelSecondary)
                    .padding(.top, 2)
            }
            Spacer()
            
            VStack(alignment: .center) {
                HStack(spacing: 0) {
                    Text("\(cellDataTrainig.countShot)/")
                        .font(OurFonts.fontSFProTextBold17)
                        .foregroundStyle(PaletteApp.adaptiveLabelPrimary)
                    Text("\(cellDataTrainig.allShot)")
                        .font(OurFonts.fontSFProTextBold17)
                        .foregroundStyle(PaletteApp.adaptiveLabelSecondary)
                }
                Text("\(Tx.DataInCell.average.localized()): \(cellDataTrainig.avarageShot)")
                    .font(OurFonts.fontSFProTextRegular12)
                    .foregroundStyle(PaletteApp.adaptiveLabelSecondary)
                    .padding(.top, 4)
            }
            ListImages.Other.markchevron_right
                .foregroundStyle(PaletteApp.adaptiveLabelTertiary)
        }
    }
}
