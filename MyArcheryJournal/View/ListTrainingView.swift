//
//  ContentView.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 01.07.2024.
//

import SwiftUI

struct ListTrainingView: View {
    var emptyListData = false
    var mokData: [TrainingCellModel] = []
    
    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = .white
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        mokData = [
            TrainingCellModel(imageTaghet: ListImages.Target.fita40mm,
                              dateTraining: Date().formatDate("dd.MM"),
                              countShot: "296",
                              allShot: "300",
                              distance: "70м",
                              nameTaget: "40mm",
                              avarageShot: "10"),
            TrainingCellModel(imageTaghet: ListImages.Target.fita122mm,
                              dateTraining: Date().formatDate("dd.MM"),
                              countShot: "250",
                              allShot: "300",
                              distance: "50м",
                              nameTaget: "30mm",
                              avarageShot: "8"),
            TrainingCellModel(imageTaghet: ListImages.Target.recurceFita3x20Ver,
                              dateTraining: Date().formatDate("dd.MM"),
                              countShot: "250",
                              allShot: "300",
                              distance: "50м",
                              nameTaget: "30mm",
                              avarageShot: "8"),
            TrainingCellModel(imageTaghet: ListImages.Target.universalFita3x20Ver,
                              dateTraining: Date().formatDate("dd.MM"),
                              countShot: "250",
                              allShot: "300",
                              distance: "50м",
                              nameTaget: "30mm",
                              avarageShot: "8"),
        ]
    }
    
    var body: some View {
        VStack {
            TabView {
                NavigationStack {
                    ZStack {
                        PaletteApp.backGroundView
                        VStack {
                            if emptyListData {
                                ListImages.Other.emptyTraining
                                    .padding()
                                Text(Tx.ListTraining.emptyList)
                                    .foregroundColor(PaletteApp.backGroundView)
                                    .font(OurFonts.fontSFProTextRegular17)
                            } else {
                                
                                List {
                                    Section(header: Text("\(Date().formatDate("MM.YYYY"))")
                                        .font(OurFonts.fontSFProTextBold20)
                                        .foregroundColor(PaletteApp.black)) {
                                        ForEach(mokData) { item in
                                            TrainingCellView(cellDataTrainig: item)
                                        }
                                    }
                                    
                                }
                            }
                        }
                        VStack {
                            Spacer()
                            NavigationLink(destination: SettingTrainingView()) {
                                Image(systemName: "plus.circle.fill")
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
                    .navigationTitle(Tx.ListTraining.myTraining)
                }
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
        ListTrainingView()
    }
}
