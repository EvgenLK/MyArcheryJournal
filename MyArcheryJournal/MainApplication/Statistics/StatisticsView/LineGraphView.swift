//
//  LineGraphView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 11.12.2024.
//

import SwiftUI
import Charts

struct LineGraphView: View {
    let dataStatistics: [StatisticsModelXY]
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        VStack {
            Text(Tx.StatisticsView.averageHits.localized())
                .font(OurFonts.fontSFProTextRegular12)
                .foregroundColor(PaletteApp.adaptiveLabelPrimary)
            
            Chart(dataStatistics, id: \.x) { datastat in
                LineMark(
                    x: .value("X-axis", datastat.x),
                    y: .value("Y-axis", datastat.y)
                )
                .foregroundStyle(.blue)
                
                PointMark(
                    x: .value("X-axis", datastat.x),
                    y: .value("Y-axis", datastat.y)
                )
                .foregroundStyle(PaletteApp.adaptiveBlue)
            }
            .padding()
        }
    }
}
