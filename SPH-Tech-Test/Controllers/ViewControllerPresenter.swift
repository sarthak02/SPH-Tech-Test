//
//  ViewControllerPresenter.swift
//  SPH-Tech-Test
//
//  Created by TA-002 on 22/05/20.
//  Copyright © 2020 Sarthak.org. All rights reserved.
//

import Foundation
protocol ViewControllerPresenterInput {
    func getUserDataSuccess(data: UsageData)
    func getUserDataFailed(error: NSError?)
}
protocol ViewControllerPresenterOutput: AnyObject {
    func refreshUsageView(data: [YearDataModel])
    func getUserDataFailed(error: String)
}
class ViewControllerPresenter: ViewControllerPresenterInput {
    weak var output: ViewControllerPresenterOutput?
    func getUserDataSuccess(data: UsageData) {
        let quaterDataArr = self.getQuaterData(records: data.result?.records ?? [])
        let yearsUsageArray = self.getYearsUsageArray(quaterArray: quaterDataArr)
        self.output?.refreshUsageView(data: yearsUsageArray)
    }
    func getUserDataFailed(error: NSError?) {
        self.output?.getUserDataFailed(error: error?.localizedDescription ?? "Something went wrong. Please try again later.")
    }
}
//MARK:- Quater Data
extension ViewControllerPresenter {
    func getQuaterData(records: [Record?]) -> [QuarterDataModel] {
        return records.map {(
            QuarterDataModel(
                id: "\($0?.id ?? 0)" ,
                year: self.getYearAndQuaterString(rawQuarter: $0?.quarter).year,
                quarter: self.getYearAndQuaterString(rawQuarter: $0?.quarter).quarter,
                volume_of_mobile_data: Double("\($0?.volumeOfMobileData ?? "0.0")") ?? 0.0
        ))}
    }
    func getYearAndQuaterString(rawQuarter: String?) -> (year: String, quarter: String) {
        let year_quarter = "\(rawQuarter ?? "")".components(separatedBy: "-")
        if year_quarter.count > 1{
            return (year: "\(year_quarter[0])", quarter: "\(year_quarter[1])")
        }
        return (year: "", quarter: "")
    }
}
//MARK:- Years Data
extension ViewControllerPresenter {
    func getYearsUsageArray(quaterArray: [QuarterDataModel]) -> [YearDataModel] {
        var yearsDataArray: [YearDataModel] = []
        for quater in quaterArray {
            let yearData = yearsDataArray.filter { $0.year ==  quater.year }
            if yearData.isEmpty {
                yearsDataArray.append(self.getYearDataForQuaters(quaterArray: quaterArray.filter { $0.year == quater.year }))
            }
        }
        return yearsDataArray
    }
    func getYearDataForQuaters(quaterArray: [QuarterDataModel]) -> YearDataModel {
        var yearsData = YearDataModel()
        if quaterArray.count > 0 {
            yearsData.year = quaterArray.first?.year ?? ""
            for quater in quaterArray {
                yearsData.total_volume = yearsData.total_volume + quater.volume_of_mobile_data
                yearsData.quater_array.append(quater)
            }
            yearsData.quater_array.sort { (quarter_A, quarter_B) -> Bool in
                quarter_A.quarter > quarter_B.quarter
            }
            yearsData.did_volume_decrease = self.calculateDip(quaterArray: yearsData.quater_array)
        }
        return yearsData
    }
    func calculateDip(quaterArray: [QuarterDataModel]) -> Bool {
        var lastValue = 0.0
        let quaterReveresedArr = quaterArray.reversed()
        for quater in quaterReveresedArr {
            if lastValue > quater.volume_of_mobile_data {
                return true
            }
            lastValue = quater.volume_of_mobile_data
        }
        return false
    }
}
