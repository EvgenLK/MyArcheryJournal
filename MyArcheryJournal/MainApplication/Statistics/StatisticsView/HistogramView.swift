//
//  HistogramModel.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 08.12.2024.
//

import SwiftUI
import Charts

struct HistogramModel: View {
    let dataStatistics: [StatisticsModelXY]
    @EnvironmentObject var languageManager: LanguageManager

    var body: some View {
        VStack {
            Text(Tx.StatisticsView.numberHits.localized())
                .font(OurFonts.fontSFProTextRegular12)
                .foregroundColor(PaletteApp.adaptiveLabelPrimary)
            
            HStack(alignment: .bottom, spacing: 5) {
                Chart(dataStatistics, id: \.x ) { datastat in
                    BarMark(
                        x: .value("data", datastat.x),
                        y: .value("data", datastat.y)
                    )
                }
                .foregroundStyle(PaletteApp.adaptiveBlue)
            }
            .padding()
        }
    }
}
