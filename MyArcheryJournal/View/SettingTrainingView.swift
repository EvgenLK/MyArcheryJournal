//
//  SettingTrainingView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 09.07.2024.
//

import SwiftUI

struct SettingTrainingView: View {
    @State private var selectedSegment = 0
    @State private var selectedDistance: EnumDistance = .notSelected
    @State private var selectedTarget: EnumTarget = .notSelected
    @State private var selectedButton: Int? = nil
    @State private var disabledTaggetPicker: Bool = true
    @EnvironmentObject var trainingController: TrainingUserController
    
    var body: some View {
        VStack {
            Picker(selection: $selectedSegment , label: Text("Picker")) {
                Text(Tx.AddTraining.freeTraining).tag(0)
                Text(Tx.AddTraining.fixedTraining).tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            
            VStack {
                Form {
                    Picker(Tx.DataInCell.distance, selection: $selectedDistance) {
                        ForEach(EnumDistance.allCases, id: \.self) { distance in
                            Text(distance.rawValue)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    .onChange(of: selectedDistance) { newValue in
                        disabledTaggetPicker = newValue == .notSelected
                    }
                    
                    HStack {
                        Picker(Tx.AddTraining.markOnTarget, selection: $selectedTarget) {
                            ForEach(EnumTarget.allCases, id: \.self) { target in
                                Text(target.rawValue)
                            }
                        }
                        .pickerStyle(.navigationLink)
                        .disabled(disabledTaggetPicker)
                        
                        if disabledTaggetPicker {
                            Image(systemName: "lock")
                                .foregroundColor(.gray)
                        }
                    }
                    .foregroundColor(disabledTaggetPicker ? .gray : .primary)
                }
                .scrollDisabled(true)
                .frame(height: 150)
            }
            
            VStack(alignment: .leading) {
                Text(Tx.AddTraining.inputMethod)
                    .padding(.leading, 32)
                
                HStack {
                    Button(action: {
                        self.selectedButton = 1
                        print("1111")
                    }) {
                        VStack {
                            ListImages.IconButton.calculator
                                .font(.title)
                            Text(Tx.AddTraining.calculator)
                                .font(OurFonts.fontSFProTextRegular14)
                                .foregroundColor(PaletteApp.black)
                        }
                        .padding()
                        .frame(width: 177)
                        .background(selectedButton == 1 ? PaletteApp.systemGray : PaletteApp.white)
                        .cornerRadius(10)
                    }
                    Button(action: {
                        self.selectedButton = 2
                    }) {
                        VStack {
                            ZStack {
                                ListImages.IconButton.target_mark
                                    .font(.title)
                                
//                                ListImages.IconButton.icon_pro
//                                    .position(x: 90, y: 180)
                            }
                            Text(Tx.AddTraining.markOnTarget)
                                .font(OurFonts.fontSFProTextRegular14)
                                .foregroundColor(PaletteApp.black)
                        }
                        .padding()
                        .frame(width: 177)
                        .background(selectedButton == 2 ? PaletteApp.systemGray : PaletteApp.white)
                        .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 16)
            }
            Spacer()
            
            VStack {
                Button(action: {
                    trainingController.saveTraining(TrainingModel(id: nil,
                                                                  imageTarget: selectedTarget.caseName(),
                                                                  dateTraining: Date(),
                                                                  nameTaget: selectedTarget.sizeTargerCase().rawValue,
                                                                  distance: Int(selectedDistance.rawValue) ?? 0))
                    trainingController.featchTraining()
                }) {
                    Text(Tx.AddTraining.further)
                        .font(OurFonts.fontSFProTextRegular17)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedButton == nil ? PaletteApp.systemGray : PaletteApp.blue)
                    
                        .cornerRadius(10)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .disabled(selectedButton == nil)
            }
        }
        .background(PaletteApp.backGroundView)
        .navigationBarTitle(Tx.AddTraining.addTraining, displayMode: .inline)
        .toolbar(.hidden, for: .tabBar)
    }
}
