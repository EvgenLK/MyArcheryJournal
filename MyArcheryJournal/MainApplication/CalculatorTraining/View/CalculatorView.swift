//
//  CalculatorView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 14.08.2024.
//

import SwiftUI

struct CalculatorView: View {
    @EnvironmentObject var archeryService: ArcheryService
    @ObservedObject var oneTraining: CalculatorController
    let idTraining: UUID
    var trainingSetting: [TrainingModel]
    let numberButton: [String]
    let markSeries: Int

    init(archeryService: ArcheryService, idTraining: UUID) {
        self.idTraining = idTraining 
        self.trainingSetting = archeryService.trainingData
        self.oneTraining = CalculatorController(archeryServise: archeryService)
        self.numberButton = EnumListingButton.fromValueTarget(trainingSetting.last?.imageTarget ?? "").setButton
        self.markSeries = trainingSetting.last?.distance == 12 ||
                           trainingSetting.last?.distance == 18 ?
                           EnumMarkCount.fromValue(trainingSetting.last?.distance ?? 0).markCount :
                           EnumMarkCount.fromValue(trainingSetting.last?.distance ?? 0).markCount
    }

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(oneTraining.oneTrainingData) { item in
                        MarkAttemptCellView(cellDataAttempt: item, countMarkInCell: markSeries)
                    }
                }
            }
            Spacer().frame(height: 0)
            VStack(alignment: .leading) {
                ForEach(0..<numberButton.count, id: \.self) { index in
                    // Создание кнопок в группах по 4
                    if index % 4 == 0 {
                        HStack {
                            ForEach(index..<min(index + 4, numberButton.count), id: \.self) { innerIndex in
                                Button(action: {
                                    // Создаем новую попытку
                                    let newScore = EnumListingMark.fromValue(numberButton[innerIndex]).setMark
                                    // Сохраняем попытку в архивах
                                    archeryService.saveOneTraining(by: idTraining, newScore)
                                    oneTraining.fetchOneTraining(idTraining, markSeries)
                                    
                                }) {
                                    Text("\(numberButton[innerIndex])")
                                        .font(OurFonts.fontSFProTextRegular17)
                                        .frame(width: 83, height: 60)
                                        .background(EnumColorMark.fromValue("\(numberButton[innerIndex])").color)
                                        .foregroundColor(EnumColorMark.fromForegroundColor("\(numberButton[innerIndex])").color)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(PaletteApp.systemGray)
        }
        .navigationBarTitle("Калькулятор", displayMode: .inline)
        .onDisappear {
            // Обновляем данные при исчезновении калькулятора
            archeryService.updateAllTrainingData()
        }
    }
}
