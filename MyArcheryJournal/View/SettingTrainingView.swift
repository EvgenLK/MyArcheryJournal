//
//  SettingTrainingView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 09.07.2024.
//

import SwiftUI

struct SettingTrainingView: View {
    @State private var selectedSegment = 0
    @State private var selectedButton = 0
    @State private var selectedDist = 0
    let dist = ["Не выбрано","10","20","30"]
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            Picker(selection: $selectedSegment , label: Text("Picker")) {
                Text("Свободная").tag(0)
                Text("Фиксированая").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 20, trailing: 16))
            
            Form {
                Picker("Дистанция", selection: $selectedDist) {
                    ForEach(dist, id: \.self) { item in
                        Text("\(item)")
                    }
                }
                .pickerStyle(.navigationLink)
                Picker("Мишень", selection: $selectedDist) {
                    ForEach(dist, id: \.self) { item in
                        Text("\(item)")
                    }
                }
                .pickerStyle(.navigationLink)
            }
            .scrollDisabled(true)
            .frame(height: 150)
            
            VStack(alignment: .leading) {
                Text("Способ ввода")
                    .padding(.leading, 32)
                
                HStack {
                    Button(action: {
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
                        .background(PaletteApp.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
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

                        .background(PaletteApp.white)
                        .cornerRadius(10)
                        
                    }
                }
                .padding(.horizontal, 16)
            }
            Spacer()
            VStack {
                Button(action: {
                    print("121212")
                }) {
                    Text("Далее")
                        .font(OurFonts.fontSFProTextRegular17)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .frame(width: .infinity, height: 45,alignment: .center)
            }
        }
        .background(PaletteApp.backGroundView)
            .navigationBarItems(leading:
                                    Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(PaletteApp.blue)
                    .font(.title)
            }
            )
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Tx.AddTraining.addTraining, displayMode: .inline)
            .toolbar(.hidden, for: .tabBar)
        }        
}
