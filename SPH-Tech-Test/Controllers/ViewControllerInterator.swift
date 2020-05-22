//
//  ViewControllerInterator.swift
//  SPH-Tech-Test
//
//  Created by TA-002 on 22/05/20.
//  Copyright © 2020 Sarthak.org. All rights reserved.
//

import Foundation
protocol ViewControllerInteratorInput {
    func getUsageData()
}
protocol ViewControllerInteratorOutput {
    func getUserDataSuccess(data: UsageData)
    func getUserDataFailed(error: NSError?)
}
class ViewControllerInterator: ViewControllerInteratorInput {
    var output: ViewControllerInteratorOutput?
    func getUsageData() {
        SPHConstants.requstAPI.enableMockData ? self.getMockUsageData() : self.getLiveUsageData()
    }
    //To test offline
    func getMockUsageData() {
        let usageData: UsageData = load("UsageData.json")
        self.output?.getUserDataSuccess(data: usageData)
    }
    //Live data
    func getLiveUsageData() {
        var request = URLRequest(url: URL(string: "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if error != nil || data == nil {
                    self.output?.getUserDataFailed(error: error as NSError?)
                } else if let json = try? JSONSerialization.jsonObject(with: data!) as? Dictionary<String, AnyObject>,
                    let data = try? JSONSerialization.data(withJSONObject: json, options: []),
                    let responseModel = try? JSONDecoder().decode(UsageData.self, from: data) {
                    self.output?.getUserDataSuccess(data: responseModel)
                } else {
                    self.output?.getUserDataFailed(error: error as NSError?)
                }
            } catch {
                self.output?.getUserDataFailed(error: nil)
            }
        })
        task.resume()
    }
}
