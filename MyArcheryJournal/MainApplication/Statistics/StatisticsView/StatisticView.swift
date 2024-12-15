//
//  StatisticView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 03.07.2024.
//

import SwiftUI
import Charts

struct StatisticView: View {
    @EnvironmentObject var archeryService: ArcheryService
    @ObservedObject var staticticsController: StatisticTrainingController
    @State private var selectedPeriod: EnumStatisticsPeriod = .week
    private var trainingStatistics: [TrainingModel]
    @State private var pickerId = UUID()

    
    init(archeryService: ArcheryService) {
        self.trainingStatistics = archeryService.trainingData
        self.staticticsController = StatisticTrainingController(archeryServise: archeryService)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Picker("", selection: $selectedPeriod) {
                        ForEach(EnumStatisticsPeriod.allCases, id: \.self) { period in
                            Text(period.localized)
                                .tag(period)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .onChange(of: selectedPeriod) { newPeriod in
                        withAnimation {
                            staticticsController.typePeriod = newPeriod
                            staticticsController.fetchStatistics()
                        }
                    }
                    .id(pickerId)

                    HistogramModel(dataStatistics: staticticsController.histogramStatictics)
                        .animation(.easeInOut(duration: 0.5), value: staticticsController.histogramStatictics)
                        
                    LineGraphView(dataStatistics: staticticsController.lineStatictics)
                        .animation(.easeInOut(duration: 0.5), value: staticticsController.lineStatictics)
                    Spacer()
                }
            }
            .navigationTitle(Tx.StatisticsView.statisticsText.localized())
            .background(PaletteApp.adaptiveBGSecondary)
        }
        .onAppear {
            selectedPeriod = staticticsController.typePeriod
            staticticsController.fetchStatistics()
            pickerId = UUID()
        }
    }
}
