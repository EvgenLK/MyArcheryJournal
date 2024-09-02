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
    let idTraining: UUID?
    var trainingSetting: [TrainingModel]
    @State private var test: [MarkAttemptCellModel]
    let numberButton: [String]
    
    
    init(archeryService: ArcheryService, idTraining: UUID) {
        self.idTraining = idTraining
//        let training = archeryService.feathTrainingId(by: idTraining)
        self.trainingSetting = archeryService.trainingData
        self.numberButton = EnumListingButton.fromValueTarget(trainingSetting.last?.imageTarget ?? "").setButton
        self.oneTraining = CalculatorController(archeryServise: archeryService)
        self.test = [
            MarkAttemptCellModel(series: "1", sumAllPoint: 6, numberAttempts: ["2", "5"]),
            MarkAttemptCellModel(series: "2", sumAllPoint: 4, numberAttempts: ["2", "1", "M", "2"]),
            MarkAttemptCellModel(series: "2", sumAllPoint: 4, numberAttempts: ["2", "1", "M", "2"]),
            MarkAttemptCellModel(series: "2", sumAllPoint: 4, numberAttempts: ["2", "1", "M", "2"])
        ]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(test) { item in
                        MarkAttemptCellView(cellDataAttempt: item,
                                            countMarkInCell: (trainingSetting.last?.distance == 12 ||
                                                              trainingSetting.last?.distance == 18 ?
                                                              EnumMarkCount.fromValue(trainingSetting.last?.distance ?? 0).markCount :
                                                                EnumMarkCount.fromValue(trainingSetting.last?.distance ?? 0).markCount))
                    }
                }
            }
            Spacer().frame(height: 0)
            VStack(alignment: .leading) {
                ForEach(0..<numberButton.count, id: \.self) { index in
                    if index % 4 == 0 {
                        HStack {
                            ForEach(index..<min(index + 4, numberButton.count), id: \.self) { innerIndex in
                                Button(action: {
                                    let newAttempt = MarkAttemptCellModel(series: "\(test.count + 1)", sumAllPoint: Int(numberButton[innerIndex]) ?? 0, numberAttempts: [numberButton[innerIndex]])
                                    test.append(newAttempt)
                                    print("Нажата кнопка \(numberButton[innerIndex])")
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
    }
}
