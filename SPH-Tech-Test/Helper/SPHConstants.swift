//
//  SPHConstants.swift
//  SPH-Tech-Test
//
//  Created by TA-002 on 22/05/20.
//  Copyright © 2020 Sarthak.org. All rights reserved.
//
import Foundation
struct SPHConstants {
    struct Strings {
        static let appTitle = "SPH Mobile Data Tracker"
        static let okButtonTitle = "OK"
        static let SPHMobileDataUsageTitle = "SPH MOBILE DATA USAGE"
        static let errorTitle = "Error"
        static let somethingWentWrong = "Something went wrong. Please try again later."
        static func getYearDataDownFallString(year: String?) -> String {
            return "Some quater(s) in \(year ?? "") showed drop in data consumtion."
        }
    }
    struct Interface {
        static let yearDataCellIdentifier = "YearDataTableViewCell"
    }
    struct Font {
        static let HelveticaNeue = "HelveticaNeue"
    }
    struct requstAPI {
         static var enableMockData: Bool = false
    }
}
