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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        
        mokData = [
            TrainingCellModel(imageTaghet: ListImages.Target.fita40mm,
                              dateTraining: formattedDate,
                              countShot: "296",
                              allShot: "300",
                              distance: "70м",
                              nameTaget: "40mm",
                              avarageShot: "10"),
            TrainingCellModel(imageTaghet: ListImages.Target.fita122mm,
                              dateTraining: formattedDate,
                              countShot: "250",
                              allShot: "300",
                              distance: "50м",
                              nameTaget: "30mm",
                              avarageShot: "8"),
            TrainingCellModel(imageTaghet: ListImages.Target.recurceFita3x20Ver,
                              dateTraining: formattedDate,
                              countShot: "250",
                              allShot: "300",
                              distance: "50м",
                              nameTaget: "30mm",
                              avarageShot: "8"),
            TrainingCellModel(imageTaghet: ListImages.Target.universalFita3x20Ver,
                              dateTraining: formattedDate,
                              countShot: "250",
                              allShot: "300",
                              distance: "50м",
                              nameTaget: "30mm",
                              avarageShot: "8"),
        ]
    }
    
    var body: some View {
        TabView {
            NavigationView {
                ZStack {
                    Color(PaletteApp.backGroundView)
                        .edgesIgnoringSafeArea(.all)
                        .navigationTitle(Tx.ListTraining.myTraining)
                    VStack {
                        if emptyListData {
                            ListImages.Other.emptyTraining
                                .padding()
                            Text(Tx.ListTraining.emptyList)
                                .foregroundColor(PaletteApp.gray)
                                .font(OurFonts.fontSFProTextRegular17)
                        } else {
                            
                            List {
                                Section(header: Text("06.24")) {
                                    ForEach(mokData) { item in
                                        TrainingCellView(cellDataTrainig: item)
                                    }
                                }
                            }
                        }
                    }
                    VStack {
                        Spacer()
                        Button(action: {
                            print("Кнопка нажата")
                        }) {
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
            }
            .tabItem {
                ListImages.TapBar.target
                Text(Tx.ListTraining.training)
            }
            .tag(0)
            StatisticView()
                .tabItem {
                    ListImages.TapBar.statictic
                    Text(Tx.ListTraining.statictics)
                }
                .tag(1)
            SettingView()
                .tabItem {
                    ListImages.TapBar.setting
                    Text(Tx.ListTraining.setting)
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListTrainingView()
    }
}
