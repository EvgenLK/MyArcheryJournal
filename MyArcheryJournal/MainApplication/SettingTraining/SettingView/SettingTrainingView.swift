//
//  SettingTrainingView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 09.07.2024.
//

import SwiftUI

struct SettingTrainingView: View {
    var settingTrainingController = SettingTrainingController()
    @State private var selectedTraining: EnumSelectedTraining = .free
    @State private var selectedDistance: EnumDistance = .notSelected
    @State private var selectedTarget: EnumTarget = .notSelected
    @State private var selectedButton: Int? = nil
    @State private var disabledTargetPicker: Bool = true
    @EnvironmentObject var archeryService: ArcheryService
    @EnvironmentObject var snackBarManager: SnackBarManager
    @State private var isActive: Bool = false
    @State private var selectedCard: Int? = nil
    
    var body: some View {
        NavigationStack {
            VStack {
                segmentPickerView
                
                formView
                
                actionButtons
                
                Spacer()
                
                furtherActionButton
            }
            .background(PaletteApp.adaptiveBGSecondary)
            .navigationBarTitle(Tx.AddTraining.addTraining.localized(), displayMode: .inline)
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    private var segmentPickerView: some View {
        Picker(selection: $selectedTraining, label: Text("")) {
            Text(Tx.AddTraining.freeTraining.localized()).tag(EnumSelectedTraining.free)
            Text(Tx.AddTraining.fixedTraining.localized()).tag(EnumSelectedTraining.fixed)
        }
        .background(PaletteApp.adaptiveGreysSysGrey5)
        .pickerStyle(SegmentedPickerStyle())
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
    }
    
    private var formView: some View {
        VStack {
            Form {
                distancePicker
                targetPicker
            }
            .scrollContentBackground(.hidden)
            .scrollDisabled(true)
            .frame(height: 150)
        }
    }
    
    private var distancePicker: some View {
        Picker(Tx.DataInCell.distance.localized(), selection: $selectedDistance) {
            ForEach(EnumDistance.allCases, id: \.self) { distance in
                Text(distance.localized)
                    .tag(distance)
            }
        }
        .listRowBackground(PaletteApp.adaptiveBGPrimary)
        .pickerStyle(.navigationLink)
        .onChange(of: selectedDistance) { newValue in
            disabledTargetPicker = newValue == .notSelected
        }
    }
    
    private var targetPicker: some View {
        VStack {
            NavigationLink(destination: SettingTrainingTargerViewCollection(cards: settingTrainingController.addCardTarget(), selectedCard: $selectedCard)) {
                if let selectedCard = selectedCard {
                    HStack {
                        Text(Tx.SettingTraining.target.localized())
                            .foregroundColor(PaletteApp.adaptiveLabelPrimary)
                        Spacer()
                        Text("\(settingTrainingController.addCardTarget()[selectedCard].title)")
                            .foregroundColor(PaletteApp.adaptiveLabelPrimary)
                    }
                } else {
                    Text(Tx.SettingTraining.target.localized())
                        .foregroundColor(PaletteApp.adaptiveLabelPrimary)
                }
            }
            .disabled(selectedDistance == .notSelected)
        }
        .listRowBackground(PaletteApp.adaptiveBGPrimary)
    }
    
    private var actionButtons: some View {
        VStack(alignment: .leading) {
            Text(Tx.AddTraining.inputMethod.localized())
                .padding(.leading, 32)
            
            HStack {
                buttonView(for: 1, title: Tx.AddTraining.calculator.localized(), icon: ListImages.IconButton.calculator)
                buttonView(for: 2, title: Tx.AddTraining.markOnTarget.localized(), icon: ListImages.IconButton.target_mark)
                    .disabled(true)
                    .overlay(Color.black.opacity(0.3).cornerRadius(10))
            }
            .padding(.horizontal, 16)
        }
    }
    
    private func buttonView(for button: Int, title: String, icon: Image) -> some View {
        Button(action: {
            self.selectedButton = button
        }) {
            VStack {
                icon.font(.title)
                Text(title)
                    .font(OurFonts.fontSFProTextRegular14)
                    .foregroundColor(PaletteApp.adaptiveLabelPrimary)
            }
            .padding()
            .frame(width: 177, height: 84)
            .background(selectedButton == button ? PaletteApp.adaptiveGreysSysGrey5 : PaletteApp.adaptiveBGPrimary)
            .cornerRadius(10)
        }
    }
    
    private var furtherActionButton: some View {
        Button(action: {
            guard let selectedCardIndex = selectedCard else { return }
            let cardIndex = selectedCardIndex + 1
            let selectTargetImage = selectedTarget.caseNameByIndex(cardIndex)
            self.selectedTarget = EnumTarget.allCases[cardIndex]
            archeryService.createTraining(TrainingModel(id: UUID(),
                                                        typeTraining: selectedTraining.rawValue,
                                                        imageTarget: selectTargetImage,
                                                        dateTraining: Date(),
                                                        nameTarget: selectedTarget.sizeTargerCase().rawValue,
                                                        distance: Int(selectedDistance.rawValue) ?? 0,
                                                        training: []))
            snackBarManager.show(message: archeryService.snackBarMessage ?? "")
            isActive.toggle()
            
        }) {
            Text(Tx.AddTraining.further.localized())
                .font(OurFonts.fontSFProTextRegular17)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(selectedButton == nil || selectedDistance == .notSelected || selectedCard == nil
                            ? PaletteApp.adaptiveLabelTertiary : PaletteApp.adaptiveBlue)
                .cornerRadius(10)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
        .disabled(selectedButton == nil || selectedDistance == .notSelected || selectedCard == nil)
        .navigationDestination(isPresented: $isActive) {
            CalculatorView(archeryService: archeryService, idTraining: archeryService.trainingData.last?.id ?? UUID())
                .environmentObject(snackBarManager)
        }
    }
}
