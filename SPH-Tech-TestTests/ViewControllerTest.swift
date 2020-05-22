//
//  ViewControllerTest.swift
//  SPH-Tech-TestTests
//
//  Created by TA-002 on 22/05/20.
//  Copyright © 2020 Sarthak.org. All rights reserved.
//
/*
 SWIFT Clean architecture only test functions for interactor and presentor
 This test be based on mock data and its hard coded values
 **/
import XCTest
@testable import SPH_Tech_Test
class ViewControllerTest: XCTestCase {
    let interactor = ViewControllerInterator()
    let presenter = ViewControllerPresenter()
    var output: ViewControllerOutput?
    var getDataSuccess: XCTestExpectation?
    override func setUp() {
        self.output = interactor
        interactor.output = presenter
        presenter.output = self
        //Offline tests
        SPHConstants.requstAPI.enableMockData = true
    }
    func testUsageOutput() {
        getDataSuccess = expectation(description: "The test will return an array for usage data and will test if the data is maniputated correctly or not")
        self.output?.getUsageData()
        waitForExpectations(timeout: 0.5)
    }
}
extension ViewControllerTest: ViewControllerPresenterOutput {
    func refreshUsageView(data: [YearDataModel]) {
        XCTAssertEqual(data.isEmpty, false)
        XCTAssertEqual(data[0].year, "2019")
        XCTAssertEqual(data[0].did_volume_decrease, false)
        XCTAssertEqual(data[0].quater_array.isEmpty, false)
        XCTAssertEqual(data[0].quater_array[0].year, data[0].year)
        XCTAssertEqual(data[0].quater_array[0].quarter, "Q1")
        getDataSuccess?.fulfill()
    }
    func getUserDataFailed(error: String) {
        print(error) //only case if webservice fails
    }
}
