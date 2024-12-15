//
//  SettingView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 03.07.2024.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("isDarkModeEnabled") var isDarkModeEnabled: Bool = false
    @EnvironmentObject var languageManager: LanguageManager
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Form {
                        Section {
                            Toggle(isOn: $isDarkModeEnabled) {
                                Text(isDarkModeEnabled ? Tx.SettingMain.themeLight.localized() : Tx.SettingMain.themeBlack.localized())
                            }
                            .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
                            
                            Picker(Tx.SettingMain.selectLanguage.localized(), selection: $languageManager.selectedLanguage) {
                                ForEach(EnumLanguage.allCases, id: \.self) { language in
                                    Text(language.displayName).tag(language)
                                }
                                .listRowBackground(PaletteApp.adaptiveBGPrimary)
                            }
                            .pickerStyle(.navigationLink)
                        }
                        .listRowBackground(PaletteApp.adaptiveBGPrimary)
                        
                        Section {
                            Button(action: {
                                print("платная версия")
                            }) {
                                Text(Tx.SettingMain.paidVersion.localized())
                                    .foregroundColor(PaletteApp.adaptiveBlue)
                            }
                        }
                        .listRowBackground(PaletteApp.adaptiveBGPrimary)
                    }
                    .scrollContentBackground(.hidden)
                    .background(PaletteApp.adaptiveBGSecondary)
                    .scrollDisabled(true)
                }
            }
            .navigationTitle(Tx.ListTraining.setting.localized())
        }
    }
}
