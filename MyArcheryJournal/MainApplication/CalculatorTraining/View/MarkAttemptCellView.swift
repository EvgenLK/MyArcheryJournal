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
    @State private var tapElementBool: Bool = false
    @Binding var selectedElementIndex: SelectedElementModel?
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text("\(cellDataAttempt.series)")
                    .font(OurFonts.fontSFProTextRegular17)
                    .foregroundStyle(PaletteApp.adaptiveLabelPrimary)
                Text("\(cellDataAttempt.sumAllPoint)")
                    .font(OurFonts.fontSFProTextRegular14)
                    .foregroundStyle(PaletteApp.adaptiveLabelSecondary)
            }
            
            HStack(alignment: .center, spacing: 10) {
                ForEach(0..<min(countMarkInCell, cellDataAttempt.numberAttempts.count), id: \.self) { index in
                    let attempt = cellDataAttempt.numberAttempts[index]
                    ZStack {
                        if attempt != EnumValueException.valueDash.rawValue {
                            Circle()
                            .fill(EnumColorMark.fromValue(attempt).color) // Изменение цвета выбранного элемента
                            .frame(width: 36, height: 36)
                            .overlay(Circle().strokeBorder(attempt == EnumValueException.valueTwo.rawValue ||
                                                           attempt == EnumValueException.valueOne.rawValue ||
                                                           attempt == EnumValueException.valueM.rawValue ? PaletteApp.adaptiveLabelSecondary : Color.clear))
                            .onTapGesture {
                                selectedElementIndex = nil
                                tapElementBool.toggle()
                                selectedElementIndex = SelectedElementModel(cellID: cellDataAttempt.id,
                                                                            index: index,
                                                                            series: Int(cellDataAttempt.series) ?? 0,
                                                                            selectMark: EnumListingMark.fromValue(attempt).setMark,
                                                                            tapElement: tapElementBool
                                )
                            }
                            
                            Text("\(attempt)")
                                .font(OurFonts.fontSFProTextRegular17)
                                .foregroundColor(EnumColorMark.fromForegroundColor(attempt).color)
                        } else {
                                Circle()
                                    .strokeBorder(PaletteApp.adaptiveLabelTertiary)
                                    .frame(width: 36, height: 36)
                                Text(EnumValueException.valueDash.rawValue)
                                    .font(OurFonts.fontSFProTextBold17)
                                    .foregroundColor(PaletteApp.adaptiveLabelTertiary)
                        }
                    }
                }
                
                ForEach(0..<max(0, countMarkInCell - cellDataAttempt.numberAttempts.count), id: \.self) { _ in
                    ZStack {
                        Circle()
                            .strokeBorder(PaletteApp.adaptiveLabelTertiary)
                            .frame(width: 36, height: 36)
                        Text(EnumValueException.valueDash.rawValue)
                            .font(OurFonts.fontSFProTextBold17)
                            .foregroundColor(PaletteApp.adaptiveLabelTertiary)
                    }
                }
            }
            .padding(.leading, 10)
        }
    }
}
