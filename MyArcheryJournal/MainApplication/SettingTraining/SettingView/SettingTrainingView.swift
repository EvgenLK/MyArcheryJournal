//
//  SettingTrainingView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 09.07.2024.
//

import SwiftUI

struct SettingTrainingView: View {
    @State private var selectedTraining: EnumSelectedTraining = .free
    @State private var selectedDistance: EnumDistance = .notSelected
    @State private var selectedTarget: EnumTarget = .notSelected
    @State private var selectedButton: Int? = nil
    @State private var disabledTaggetPicker: Bool = true
    @EnvironmentObject var archeryService: ArcheryService
    @State private var isActive: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker(selection: $selectedTraining , label: Text("Picker")) {
                    Text(Tx.AddTraining.freeTraining.localized()).tag(EnumSelectedTraining.free)
                    Text(Tx.AddTraining.fixedTraining.localized()).tag(EnumSelectedTraining.fixed)
                }
                .background(PaletteApp.adaptiveGreysSysGrey5)
                .pickerStyle(SegmentedPickerStyle())
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
                
                VStack {
                    Form {
                        Picker(Tx.DataInCell.distance.localized(), selection: $selectedDistance) {
                            ForEach(EnumDistance.allCases, id: \.self) { distance in
                                Text(distance.localized)
                                    .tag(distance)
                            }
                        }
                        .listRowBackground(PaletteApp.adaptiveBGPrimary)
                        .pickerStyle(.navigationLink)
                        .onChange(of: selectedDistance) { newValue in
                            disabledTaggetPicker = newValue == .notSelected
                        }
                        
                        Picker(Tx.AddTraining.markOnTarget.localized(), selection: $selectedTarget) {
                            ForEach(EnumTarget.allCases, id: \.self) { target in
                                Text(target.localized)
                                    .tag(target)
                            }
                        }
                        .listRowBackground(PaletteApp.adaptiveBGPrimary)
                        .pickerStyle(.navigationLink)
                        .disabled(disabledTaggetPicker)
                        .foregroundColor(disabledTaggetPicker ? .gray : .primary)
                    }
                    .scrollContentBackground(.hidden)
                    .scrollDisabled(true)
                    .frame(height: 150)
                }
                
                VStack(alignment: .leading) {
                    Text(Tx.AddTraining.inputMethod.localized())
                        .padding(.leading, 32)
                    
                    HStack {
                        Button(action: {
                            self.selectedButton = 1
                        }) {
                            VStack {
                                ListImages.IconButton.calculator
                                    .font(.title)
                                Text(Tx.AddTraining.calculator.localized())
                                    .font(OurFonts.fontSFProTextRegular14)
                                    .foregroundColor(PaletteApp.adaptiveLabelPrimary)
                            }
                            .padding()
                            .frame(width: 177, height: 84)
                            .background(selectedButton == 1 ? PaletteApp.adaptiveGreysSysGrey5 : PaletteApp.adaptiveBGPrimary)
                            .cornerRadius(10)
                        }
                        Button(action: {
                            self.selectedButton = 2
                        }) {
                            VStack {
                                ListImages.IconButton.target_pro
                                    .font(.title)
                                Text(Tx.AddTraining.markOnTarget.localized())
                                    .font(OurFonts.fontSFProTextRegular14)
                                    .foregroundColor(PaletteApp.adaptiveLabelPrimary)
                            }
                            .padding()
                            .frame(width: 177, height: 84)
                            .background(selectedButton == 2 ? PaletteApp.adaptiveGreysSysGrey5 : PaletteApp.adaptiveBGPrimary)
                            .cornerRadius(10)
                        }
                        .disabled(true)
                    }
                    .padding(.horizontal, 16)
                }
                Spacer()
                
                VStack {
                    Button(action: {
                        archeryService.createTraining(TrainingModel(id: UUID(),
                                                                            typeTraining: selectedTraining.rawValue,
                                                                            imageTarget: selectedTarget.caseName(),
                                                                            dateTraining: Date(),
                                                                            nameTaget: selectedTarget.sizeTargerCase().rawValue,
                                                                            distance: Int(selectedDistance.rawValue) ?? 0,
                                                                            training: []))
                        isActive.toggle()
                        
                    }) {
                        Text(Tx.AddTraining.further.localized())
                            .font(OurFonts.fontSFProTextRegular17)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedButton == nil || selectedDistance == .notSelected || selectedTarget == .notSelected  ? PaletteApp.adaptiveLabelTertiary : PaletteApp.adaptiveBlue)
                            .cornerRadius(10)
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .disabled(selectedButton == nil || selectedDistance == .notSelected || selectedTarget == .notSelected)
                    .navigationDestination(isPresented: $isActive) {
                        CalculatorView(archeryService: archeryService, idTraining: archeryService.trainingData.last?.id ?? UUID())
                    }
                }
            }
            .background(PaletteApp.adaptiveBGSecondary)
            .navigationBarTitle(Tx.AddTraining.addTraining.localized(), displayMode: .inline)
        }
    }
}

struct SettingTrainingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingTrainingView()
            .environmentObject(ArcheryService())
    }
}
