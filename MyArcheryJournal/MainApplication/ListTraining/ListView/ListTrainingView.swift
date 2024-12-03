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
    @EnvironmentObject var snackBarManager: SnackBarManager
    
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
                                            contextViewWithCell(item: item)
                                                .listRowSeparator(.hidden)
                                        }
                                        .listRowBackground(PaletteApp.adaptiveBGSecondary)
                                    }
                                }
                                .padding(.bottom, 12)
                                .listRowInsets(EdgeInsets())
                                .environmentObject(languageManager)
                                
                            }
                            .scrollContentBackground(.hidden)
                            .background(PaletteApp.adaptiveBGSecondary)
                            .scrollIndicators(.hidden)
                        }
                    }

                    HStack {
                        NavigationLink(destination: SettingTrainingView()) {
                            ListImages.Other.addTraining
                                .font(.largeTitle)
                                .foregroundColor(PaletteApp.adaptiveBlue)
                                .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                                .background(PaletteApp.targetWhite)
                                .scaleEffect(1.9)
                                .clipShape(Circle())
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding()
                    }
                }
                .navigationTitle(Tx.ListTraining.myTraining.localized())
            }
            .overlay(alignment: .top) {
                SnackbarView(message: snackBarManager.snackBarMessage,
                             icon: EnumSnackBarMessage.messageType(for: snackBarManager.snackBarMessage).icon,
                             color: EnumSnackBarMessage.messageType(for: snackBarManager.snackBarMessage).color,
                             isShowing: $snackBarManager.showSnackBar)
            }
            .environmentObject(archeryService)
            .environmentObject(snackBarManager)
            
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

    private func contextViewWithCell(item: ListTrainingModelCell) -> some View {
        ZStack {
            NavigationLink(destination: CalculatorView(archeryService: archeryService, idTraining: item.id)) {
                EmptyView()
            }
            ListTrainingViewCell(cellDataTrainig: item)
                .padding()
                .background(PaletteApp.adaptiveBGPrimary)
                .cornerRadius(12)
                .listRowSeparator(.hidden)
                
                .contextMenu {
                    Button(role: .destructive) {
                        archeryService.deleteDataWithId(id: item.id)
                        trainingController.fetchTraining()
                        snackBarManager.show(message: archeryService.snackBarMessage ?? "")
                    } label: {
                        Label(Tx.ListTraining.deleteCell.localized(), systemImage: "trash")
                    }
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
