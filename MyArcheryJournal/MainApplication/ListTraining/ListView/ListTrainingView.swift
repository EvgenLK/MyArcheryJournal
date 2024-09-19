//
//  ContentView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 01.07.2024.
//

import SwiftUI

struct ListTrainingView: View {
    @EnvironmentObject var archeryService: ArcheryService
    @StateObject var trainingController: ListTrainingController // Измените на StateObject, чтобы управлять состоянием
    
    init(archeryService: ArcheryService) {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        self._trainingController = StateObject(wrappedValue: ListTrainingController(archeryServise: archeryService))
    }
    
    var body: some View {
        NavigationStack {
            TabView {
                NavigationStack {
                    ZStack {
                        VStack {
                            if trainingController.training.isEmpty {
                                ListImages.Other.emptyTraining
                                    .padding()
                                Text(Tx.ListTraining.emptyList)
                                    .foregroundColor(PaletteApp.gray)
                                    .font(OurFonts.fontSFProTextRegular17)
                            } else {
                                List {
                                    ForEach(trainingController.training, id: \.monthYear) { section in
                                        
                                        let headerText = Text(section.monthYear)
                                            .font(OurFonts.fontSFProTextBold20)
                                            .foregroundColor(PaletteApp.black)
                                        
                                        Section(header: headerText) {
                                            let trainings = section.trainings
                                            
                                            ForEach(trainings.indices, id: \.self) { index in
                                                let item = trainings[index]
                                                
                                                ListTrainingViewCell(cellDataTrainig: item)
                                                    .padding()
                                                    .background(PaletteApp.white)
                                                    .cornerRadius(10)
                                                    .padding(.vertical, 5)
                                                    .background(PaletteApp.backGroundView)
                                                    .listRowInsets(EdgeInsets())
                                                    .listRowSeparator(.hidden)
                                                    .padding(.bottom, index == trainings.count - 1 ? 60 : 0)
                                            }
                                            .background(PaletteApp.backGroundView)
                                        }
                                    }
                                    .scrollIndicators(.hidden)
                                }
                            }
                        }
                        VStack {
                            Spacer()
                            NavigationLink(destination: SettingTrainingView()) {
                                ListImages.Other.addTraining
                                    .font(.largeTitle)
                                    .foregroundColor(PaletteApp.blue)
                                    .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                                    .background(PaletteApp.white)
                                    .scaleEffect(1.8)
                                    .clipShape(Circle())
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing )
                            .padding()
                        }
                    }
                    .background(PaletteApp.backGroundView)
                    .navigationTitle(Tx.ListTraining.myTraining)
                }
                .environmentObject(archeryService)
                
                .tabItem {
                    ListImages.TapBar.target
                    Text(Tx.ListTraining.training)
                }
                StatisticView()
                    .tabItem {
                        ListImages.TapBar.statictic
                        Text(Tx.ListTraining.statictics)
                    }
                SettingView()
                    .tabItem {
                        ListImages.TapBar.setting
                        Text(Tx.ListTraining.setting)
                    }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let archeryService = ArcheryService()
        _ = ListTrainingController(archeryServise: archeryService)
        
        return ListTrainingView(archeryService: archeryService)
            .environmentObject(archeryService)
    }
}
