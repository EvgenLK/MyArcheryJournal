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
                            // Первая кнопка с переходом на страницу с текстом
                            NavigationLink(destination: SettingMainTextDoc(text: loadText(from: languageManager.selectedLanguage.rawValue == "en" ? "UserAgreement_English" : "UserAgreement"))) {
                                Text("\(Tx.SettingMain.userAgreement.localized())")
                                    .foregroundColor(PaletteApp.adaptiveBlue)
                            }
                            
                            // Вторая кнопка с переходом на страницу с текстом
                            NavigationLink(destination: SettingMainTextDoc(text: loadText(from: languageManager.selectedLanguage.rawValue == "en" ? "PrivacyPolicy_English" : "PrivacyPolicy"))) {
                                Text("\(Tx.SettingMain.privacyPolicy.localized())")
                                    .foregroundColor(PaletteApp.adaptiveBlue)
                            }
                        }
                        .listRowBackground(PaletteApp.adaptiveBGPrimary)
                    }
                    .scrollContentBackground(.hidden)
                    .background(PaletteApp.adaptiveBGSecondary)
                    .scrollDisabled(true)
                    
                    Spacer()
                    Text("\(Tx.SettingMain.versionApp.localized()) 1.0")
                        .foregroundColor(.gray)
                    // Текст с авторскими правами
                    Text("\(Tx.SettingMain.copyrights.localized())")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding()
                }
                .background(PaletteApp.adaptiveBGSecondary)
            }
            .navigationTitle(Tx.ListTraining.setting.localized())
        }
    }
}

extension SettingView {
    func loadText(from fileName: String) -> String {
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "txt") {
            do {
                let text = try String(contentsOf: fileURL, encoding: .utf8)
                return text
            } catch {
                return "Не удалось загрузить текст из файла."
            }
        }
        return "Файл не найден."
    }
}
