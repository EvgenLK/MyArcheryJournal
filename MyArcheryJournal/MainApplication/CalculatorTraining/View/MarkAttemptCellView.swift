//
//  MarkAttemptCellView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 18.08.2024.
//

import SwiftUI

struct MarkAttemptCellView: View {
    let cellDataAttempt: MarkAttemptCellModel
    let countMarkInCell: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text("\(cellDataAttempt.series)")
                    .font(OurFonts.fontSFProTextRegular17)
                    .foregroundStyle(PaletteApp.black)
                Text("\(cellDataAttempt.sumAllPoint)")
                    .font(OurFonts.fontSFProTextRegular14)
                    .foregroundStyle(PaletteApp.gray)
            }
            
            HStack(alignment: .center, spacing: 10) {
                ForEach(0..<min(countMarkInCell, cellDataAttempt.numberAttempts.count), id: \.self) { index in
                    let attempt = cellDataAttempt.numberAttempts[index]
                    ZStack {
                        Circle()
                            .fill(EnumColorMark.fromValue(attempt).color)
                            .frame(width: 36, height: 36)
                            .overlay(Circle().strokeBorder(attempt == "2" || attempt == "1" || attempt == "M" ? PaletteApp.gray : Color.clear))

                        Text("\(attempt)")
                            .font(OurFonts.fontSFProTextRegular17)
                            .foregroundColor(EnumColorMark.fromForegroundColor(attempt).color)
                    }
                }
                ForEach(0..<max(0, countMarkInCell - cellDataAttempt.numberAttempts.count), id: \.self) { _ in
                    ZStack {
                        Circle()
                            .strokeBorder(PaletteApp.gray)
                            .frame(width: 40, height: 40)
                        Text("-")
                            .font(OurFonts.fontSFProTextBold17)
                            .foregroundColor(EnumColorMark.fromForegroundColor("-").color)
                    }
                }
            }
            .padding(.leading, 10)
        }
    }
}
