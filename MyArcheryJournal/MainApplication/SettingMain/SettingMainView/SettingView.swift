//
//  SettingView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 03.07.2024.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var languageManager: LanguageManager

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text(Tx.AddTraining.calculator.localized())
                    .font(.largeTitle)
                    .padding()
                
                ForEach(EnumLanguage.allCases, id: \.self) { language in
                    HStack {
                        Button(action: {
                            if languageManager.selectedLanguage == language {
                            } else {
                                languageManager.selectedLanguage = language
                            }
                        }) {
                            Image(systemName: languageManager.selectedLanguage == language ? "checkmark.square" : "square")
                                .foregroundColor(languageManager.selectedLanguage == language ? .blue : .gray)
                        }
                        
                        Text(language.displayName)
                            .font(.title2)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                Button(action: {
                    let selectedLanguage = languageManager.selectedLanguage.rawValue
                    print("Выбранный язык: \(selectedLanguage)")
                }) {
                    Text("Подтвердить выбор")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Языки")
        }
    }
}
