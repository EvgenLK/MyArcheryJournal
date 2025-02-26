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
    @EnvironmentObject var snackBarManager: SnackBarManager
    @ObservedObject var oneTraining: CalculatorController
    @State private var showAlert = false
    private let idTraining: UUID
    private var trainingSetting: [TrainingModel]
    private let numberButton: [String]
    private let attemptSeries: Int
    private let countSeriesInTarget: Int
    private let typeTraining: Int
    @State private var selectedCell: SelectedElementModel?
    @State private var tapElementBool = false

    init(archeryService: ArcheryService, idTraining: UUID) {
        self.idTraining = idTraining
        self.trainingSetting = archeryService.trainingData
        self.oneTraining = CalculatorController(archeryServise: archeryService)
        self.typeTraining = trainingSetting.last?.typeTraining ?? 0
        self.numberButton = EnumListingButton.fromValueTarget(trainingSetting.last?.imageTarget ?? "").setButton
        self.countSeriesInTarget = EnumCountSeriesInTarget.fromValueSeries(trainingSetting.last?.imageTarget ?? "").setCount
        self.attemptSeries = EnumMarkCount.fromValue(trainingSetting.last?.distance ?? 0).markCount
        self.oneTraining.fetchOneTraining(idTraining, attemptSeries)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollViewReader { proxy in
                    List {
                        ForEach(oneTraining.oneTrainingData, id: \.id) { section in
                            if trainingSetting.last?.typeTraining == 1 {
                                Section(header: SectionCellMarkView(roundCellAttempt: section)) {
                                    ForEach(section.trainings, id: \.series) { item in
                                        MarkAttemptCellView(cellDataAttempt: item,
                                                            countMarkInCell: attemptSeries,
                                                            selectedElementIndex: $selectedCell)
                                            .id(item.series)
                                    }
                                }
                            } else {
                                // Для типа тренировки 0 показываем тренировки без заголовков
                                ForEach(section.trainings, id: \.series) { item in
                                    MarkAttemptCellView(cellDataAttempt: item,
                                                        countMarkInCell: attemptSeries,
                                                        selectedElementIndex: $selectedCell)
                                        .id(item.series)
                                }
                                .scrollContentBackground(.hidden) // Скрыть фон
                            }
                        }
                    }
                    .onChange(of: selectedCell) { newValue in
                        if let tapElement = newValue?.tapElement, tapElement {
                            tapElementBool.toggle()
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
                
                ButtonGridView(onButtonTap: handleButtonTap, numberButton: numberButton)
            }
            .navigationBarTitle(Tx.AddTraining.calculator.localized(), displayMode: .inline)
            .task {
                archeryService.updateAllTrainingData()
            }
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
            .alert(isPresented: $tapElementBool) {
                Alert(
                    title: Text(Tx.CalculatorView.text_deleteAttempt.localized()),
                    message: Text(Tx.CalculatorView.test_messageDelete.localized()),
                    primaryButton: .destructive(Text(Tx.CalculatorView.text_confirmationYes.localized())) {
                        // Проверка значений перед удалением
                        guard let selectedSeries = selectedCell?.series,
                              let selectedIndex = selectedCell?.index else {
                            print("Ошибка: Одно или несколько значений отсутствуют.")
                            return
                        }

                        // Вызов метода для удаления
                        archeryService.deleteAttemptTraining(by: idTraining, attemptSeries, selectedSeries, selectedIndex)
                        oneTraining.fetchOneTraining(idTraining, attemptSeries)
                        snackBarManager.show(message: archeryService.snackBarMessage ?? "")
                    },
                    secondaryButton: .cancel(Text(Tx.CalculatorView.text_confirmationNo.localized())) {
                        selectedCell = nil
                    }
                )
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func handleButtonTap(for index: Int) {
        let newScore = EnumListingMark.fromValue(numberButton[index]).setMark
        let indexElement = selectedCell?.index ?? 0
        let numberSeries = selectedCell?.series ?? 0
        let tapCellBool = selectedCell?.tapElement ?? false
        
        archeryService.saveOneTraining(with: SaveOneTrainingModel(id: idTraining,
                                                                  mark: newScore,
                                                                  seriesCount: countSeriesInTarget,
                                                                  typetraining: typeTraining,
                                                                  attemptInSeries: attemptSeries,
                                                                  numberSeries: numberSeries,
                                                                  index: indexElement,
                                                                  changeInCell: tapCellBool))
        oneTraining.fetchOneTraining(idTraining, attemptSeries)
        selectedCell = nil
        showAlert = oneTraining.fetchBoolTrainingFull(idTraining, countSeriesInTarget, typeTraining) ? true : false
    }
}
