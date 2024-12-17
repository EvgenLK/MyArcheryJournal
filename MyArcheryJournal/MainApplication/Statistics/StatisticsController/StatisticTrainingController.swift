//
//  StatisticTrainingController.swift
//  MyArcheryJournal
//
//  Created by Evgenii Kutasov on 08.12.2024.
//

import Foundation
import Combine
import SwiftUI

final class StatisticTrainingController: ObservableObject {
    @Published var histogramStatictics = [StatisticsModelXY]()
    @Published var lineStatictics = [StatisticsModelXY]()
    @Published var circleStatictics = [StatisticsModelXY]()
    @Published var typePeriod: EnumStatisticsPeriod = .week
    private let currentDate = Date()
    
    private let archeryServise: ArcheryService
    private var cancellables = Set<AnyCancellable>()
    
    init(archeryServise: ArcheryService) {
        self.archeryServise = archeryServise
        
        archeryServise.$trainingData
            .sink { [weak self] _ in
                self?.fetchStatistics()
            }
            .store(in: &cancellables)
    }
    
    func fetchStatistics() {
        let dataStatistics = archeryServise.fetchAndPrintData()
        histogramStatictics = histogramData(allData: dataStatistics, typePeriod: typePeriod.period)
        lineStatictics = lineGraphData(allData: dataStatistics, typePeriod: typePeriod.period)
        circleStatictics = circleData(allData: dataStatistics, typePeriod: typePeriod.period)
    }
    
    func histogramData(allData: [TrainingModel], typePeriod: Int) -> [StatisticsModelXY] {
        var dataStatistic = [StatisticsModelXY]()
        var trainingAllData = allData
        
        switch typePeriod {
        case 1: 
            trainingAllData = trainingAllData.filter { training in
                return training.dateTraining.weekOfYear == currentDate.weekOfYear
            }
        case 2:
            trainingAllData = trainingAllData.filter { training in
                return training.dateTraining.monthOfYear == currentDate.monthOfYear
            }
        case 3:
            let isFirstHalfOfYear = currentDate.isInFirstHalfOfYear()

            trainingAllData = trainingAllData.filter { training in
                let isTrainingInFirstHalf = training.dateTraining.isInFirstHalfOfYear()
                return isFirstHalfOfYear == isTrainingInFirstHalf
            }
        default:
            break
        }
        
        let session = trainingAllData.flatMap { $0.training }
        for i in 0...11 {
            let aXisXCount = session.filter { $0.point == i }
            dataStatistic.append(StatisticsModelXY(x: EnumListingMark.fromValueString(i).setMarkString, y: Double(aXisXCount.count)))
        }
        
        return  dataStatistic
    }
    
    func lineGraphData(allData: [TrainingModel], typePeriod: Int) -> [StatisticsModelXY] {
        var datastat = [StatisticsModelXY]()
        var trainingAllData = allData
        
        switch typePeriod {
        case 1:
            trainingAllData = trainingAllData.filter { training in
                return training.dateTraining.weekOfYear == currentDate.weekOfYear
            }
            datastat = calculatingLineGraphData(allData: trainingAllData, typePeriod: typePeriod)
        case 2:
            trainingAllData = trainingAllData.filter { training in
                return training.dateTraining.monthOfYear == currentDate.monthOfYear
            }
            datastat = calculatingLineGraphData(allData: trainingAllData, typePeriod: typePeriod)
        case 3:
            let isFirstHalfOfYear = currentDate.isInFirstHalfOfYear()
            
            trainingAllData = trainingAllData.filter { training in
                let isTrainingInFirstHalf = training.dateTraining.isInFirstHalfOfYear() //???
                return isFirstHalfOfYear == isTrainingInFirstHalf
            }
            datastat = calculatingLineGraphData(allData: trainingAllData, typePeriod: typePeriod)

        default:
            break
        }
            datastat.sort(by: { $0.x < $1.x })
        
        return datastat
    }

    func circleData(allData: [TrainingModel], typePeriod: Int) -> [StatisticsModelXY] {
        let datastat = [StatisticsModelXY]()
        
        return  datastat
    }
    
    func calculatingLineGraphData(allData: [TrainingModel], typePeriod: Int) -> [StatisticsModelXY]  {
        var datastat = [StatisticsModelXY]()
        var dataDate = ""
        // Группируем тренировки по дате
        var groupedData = [String: [Double]]()
        
        allData.forEach { training in
            let countElements = training.training.count
            
            // Если countElements > 0, то вычисляем среднее значение
            guard countElements > 0 else {
                return // Пропускаем тренировки с нулевым количеством элементов
            }
            
            let average = training.training.reduce(0) { ($0 == 11 ? 10 : $0) + $1.point } / countElements
            if typePeriod == 1 || typePeriod == 2 {
                dataDate = training.dateTraining.formatToDDMM()
            } else {
                dataDate = training.dateTraining.formatToMMYY()

            }
            // Группируем данные по дате
            if groupedData[dataDate] != nil {
                groupedData[dataDate]?.append(Double(average))
            } else {
                groupedData[dataDate] = [Double(average)]
            }
        }
        
        // Для каждой группы данных (по дате) вычисляем среднее значение
        for (date, averages) in groupedData {
            let totalAverage = averages.reduce(0, +) / Double(averages.count)
            datastat.append(StatisticsModelXY(x: date, y: totalAverage))
        }
        return datastat
    }
}
