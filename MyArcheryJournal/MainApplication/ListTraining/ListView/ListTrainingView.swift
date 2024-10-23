//
//  ContentView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 01.07.2024.
//

import SwiftUI

struct ListTrainingView: View {
    @StateObject var trainingController: ListTrainingController
    @EnvironmentObject var archeryService: ArcheryService
    @EnvironmentObject var languageManager: LanguageManager
    
    init(archeryService: ArcheryService) {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(PaletteApp.adaptiveBGPrimary)
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        self._trainingController = StateObject(wrappedValue: ListTrainingController(archeryServise: archeryService))
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                ZStack {
                    VStack {
                        if trainingController.training.isEmpty {
                            ListImages.Other.emptyTraining
                                .padding()
                            Text(Tx.ListTraining.emptyList.localized())
                                .foregroundColor(PaletteApp.adaptiveLabelSecondary)
                                .font(OurFonts.fontSFProTextRegular17)
                        } else {
                            List {
                                ForEach(trainingController.training, id: \.monthYear) { section in
                                    
                                    let headerText = Text(section.monthYear)
                                        .font(OurFonts.fontSFProTextBold20)
                                        .foregroundColor(PaletteApp.adaptiveLabelPrimary)
                                    
                                    Section(header: headerText) {
                                        let trainings = section.trainings
                                        
                                        ForEach(trainings.indices, id: \.self) { index in
                                            let item = trainings[index]
                                            
                                            ListTrainingViewCell(cellDataTrainig: item)
                                                .padding()
                                                .background(PaletteApp.adaptiveBGPrimary)
                                                .cornerRadius(10)
                                                .padding(.vertical, 5)
                                                .listRowInsets(EdgeInsets())
                                                .listRowSeparator(.hidden)
                                                .padding(.bottom, index == trainings.count - 1 ? 60 : 0)
                                        }
                                        .listRowBackground(PaletteApp.adaptiveBGSecondary)
                                    }
                                }
                                .scrollIndicators(.hidden)
                            }
                            .scrollContentBackground(.hidden)
                            .background(PaletteApp.adaptiveBGSecondary)
                            .environmentObject(languageManager)
                        }
                    }
                    VStack {
                        Spacer()
                        NavigationLink(destination: SettingTrainingView()) {
                            ListImages.Other.addTraining
                                .font(.largeTitle)
                                .foregroundColor(PaletteApp.adaptiveBlue)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                                .background(PaletteApp.targetWhite)
                                .scaleEffect(1.9)
                                .clipShape(Circle())
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing )
                        .padding()
                    }
                }
                .navigationTitle(Tx.ListTraining.myTraining.localized())
            }
            .environmentObject(archeryService)
            
            .tabItem {
                ListImages.TapBar.target
                Text(Tx.ListTraining.training.localized())
            }
            StatisticView()
                .tabItem {
                    ListImages.TapBar.statictic
                    Text(Tx.ListTraining.statictics.localized())
                }
            SettingView()
                .environmentObject(languageManager)
                .tabItem {
                    ListImages.TapBar.setting
                    Text(Tx.ListTraining.setting.localized())
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let archeryService = ArcheryService()
        let languageManager = LanguageManager()

        return ListTrainingView(archeryService: archeryService)
            .environmentObject(archeryService)
            .environmentObject(languageManager)
    }
}
