//
//  CalculatorView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 14.08.2024.
//

import SwiftUI

struct CalculatorView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var archeryService: ArcheryService
    @ObservedObject var oneTraining: CalculatorController
    @State private var showAlert = false
    private let idTraining: UUID
    private var trainingSetting: [TrainingModel]
    private let numberButton: [String]
    private let attemptSeries: Int
    private let countSeriesInTarget: Int
    private let typeTraining: Int
    
    init(archeryService: ArcheryService, idTraining: UUID) {
        self.idTraining = idTraining
        self.trainingSetting = archeryService.trainingData
        self.oneTraining = CalculatorController(archeryServise: archeryService)
        self.typeTraining = trainingSetting.last?.typeTraining ?? 0
        self.numberButton = EnumListingButton.fromValueTarget(trainingSetting.last?.imageTarget ?? "").setButton
        self.countSeriesInTarget = EnumCountSeriesInTarget.fromValueSeries(trainingSetting.last?.imageTarget ?? "").setCount
        self.attemptSeries = EnumMarkCount.fromValue(trainingSetting.last?.distance ?? 0).markCount
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    List {
                        if trainingSetting.last?.typeTraining == 1 {
                            // Перебираем каждую секцию и её тренировки для отображения
                            ForEach(oneTraining.oneTrainingData, id: \.id) { section in
                                Section(header: SectionCellMarkView(roundCellAttempt: section)) {
                                    ForEach(section.trainings, id: \.series) { item in
                                        MarkAttemptCellView(cellDataAttempt: item, countMarkInCell: attemptSeries)
                                            .id(item.series) // Присваиваем уникальный ID каждому элементу
                                    }
                                }
                            }
                            .scrollContentBackground(.hidden)
                        }
                        if trainingSetting.last?.typeTraining == 0, !oneTraining.oneTrainingData.isEmpty {
                            // Также показываем тренировки, если тип 0
                            ForEach(oneTraining.oneTrainingData, id: \.id) { section in
                                ForEach(section.trainings, id: \.series) { item in
                                    MarkAttemptCellView(cellDataAttempt: item, countMarkInCell: attemptSeries)
                                        .id(item.series) // Присваиваем уникальный ID каждому элементу
                                }
                            }
                        }
                    }
                    .listRowBackground(PaletteApp.adaptiveBGSecondary)
                    .onChange(of: oneTraining.oneTrainingData) { _ in
                        // Прокрутка к последнему элементу при изменении данных
                        if let lastSection = oneTraining.oneTrainingData.last,
                           let lastItem = lastSection.trainings.last {
                            withAnimation {
                                proxy.scrollTo(lastItem.series, anchor: .bottom)
                            }
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
                                        archeryService.saveOneTraining(by: idTraining, newScore, countSeriesInTarget, typeTraining)
                                        oneTraining.fetchOneTraining(idTraining, attemptSeries)
                                        showAlert = oneTraining.fetchBoolTrainingFull(idTraining, countSeriesInTarget, typeTraining) ? true : false
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
                .background(PaletteApp.adaptiveBGSecondary)
            }
            .navigationBarTitle(Tx.AddTraining.calculator.localized(), displayMode: .inline)
            .onDisappear {
                archeryService.updateAllTrainingData()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(""),
                    message: Text("\(Tx.CalculatorView.text_AttemptEnd.localized())"),
                    dismissButton: .default(Text("\(Tx.CalculatorView.text_Ok.localized())")) {
                        presentationMode.wrappedValue.dismiss()
                    })
            }
        }
    }
}
