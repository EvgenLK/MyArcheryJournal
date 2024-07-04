//
//  TrainingCellView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 04.07.2024.
//

import SwiftUI

struct TrainingCellView: View {
    var cellDataTrainig: TrainingCellModel
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                cellDataTrainig.imageTaghet
                    .resizable()
                    .frame(width: 50, height: 50)
                Text(cellDataTrainig.nameTaget)
                    .font(OurFonts.fontSFProTextRegular12)
                    .foregroundStyle(PaletteApp.gray)
            }
            VStack(alignment: .leading) {
                Text("\(cellDataTrainig.dateTraining)")
                    .font(OurFonts.fontSFProTextRegular17)
                    .foregroundStyle(PaletteApp.black)
                
                Text("Дистанция: \(cellDataTrainig.distance)")
                    .font(OurFonts.fontSFProTextRegular14)
                    .foregroundStyle(PaletteApp.gray)
                    .padding(.top, 2)
            }
            Spacer()
            VStack(alignment: .center) {
                HStack(spacing: 0) {
                    Text("\(cellDataTrainig.countShot)")
                        .font(OurFonts.fontSFProTextBold17)
                        .foregroundStyle(PaletteApp.black)
                    Text("/\(cellDataTrainig.allShot)")
                        .font(OurFonts.fontSFProTextBold17)
                        .foregroundStyle(PaletteApp.gray)
                }
                Text("Сред.: \(cellDataTrainig.avarageShot)")
                    .font(OurFonts.fontSFProTextRegular12)
                    .foregroundStyle(PaletteApp.gray)
                    .padding(.top, 4)
                
            }
        }
    }
}