//
//  SettingTrainingView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 09.07.2024.
//

import SwiftUI

struct SettingTrainingView: View {
    @State private var selectedSegment = 0
    @State private var selectedDist = "Не выбрано"
    @State private var selectedButton: Int? = nil
    let dist = ["Не выбрано", "10","20","30","40"]

    var body: some View {
        VStack {
            Picker(selection: $selectedSegment , label: Text("Picker")) {
                Text("Свободная").tag(0)
                Text("Фиксированая").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
            
            VStack {
                
                    Form {
                        Picker("Дистанция", selection: $selectedDist) {
                            ForEach(dist, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.navigationLink)
                        
                        Picker("Отметка на мишени", selection: $selectedDist) {
                            ForEach(dist, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.navigationLink)
                    }
                    
                    .scrollDisabled(true)
                    .frame(height: 150)
                
            }
            VStack(alignment: .leading) {
                Text("Способ ввода")
                    .padding(.leading, 32)
                
                HStack {
                    Button(action: {
                        self.selectedButton = 1
                        print("1111")
                    }) {
                        VStack {
                            ListImages.IconButton.calculator
                                .font(.title)
                            Text("Калькулятор")
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
                        print("1111")
                    }) {
                        VStack {
                            ListImages.IconButton.target_mark
                                .font(.title)
                            Text("Отметка на мишени")
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
                    
                }) {
                    Text("Далее")
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
