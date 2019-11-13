//
//  SquareEmployeesTests.swift
//  SquareEmployeesTests
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import XCTest
@testable import SquareEmployees

class SquareEmployeesTests: XCTestCase {

    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testErrorState() {
        let listModel = SQEmployeeListControllerModel(SQRemoteEmployeeFetcher(SQRemoteEmployeeFetchAPI.malformed.rawValue))
        
        let expectation = self.expectation(description: #function)
        
        var expectedError : Error?
        
        listModel.onStatusChanged = { status in
            switch status {
            case .error(let error):
                expectedError = error
                expectation.fulfill()
            default: break
            }
        }
        
        listModel.send(.fetch)
        waitForExpectations(timeout: 4)
        XCTAssertNotNil(expectedError)
    }
    
    func testEmptyState() {
        let listModel = SQEmployeeListControllerModel(SQRemoteEmployeeFetcher(SQRemoteEmployeeFetchAPI.empty.rawValue))
        
        let expectation = self.expectation(description: #function)
        
        var employees : [SQEmployee]?
        
        
        listModel.onStatusChanged = { status in
            switch status {
            case .success:
                employees = listModel.employees
                expectation.fulfill()
            default: break
            }
        }
        
        listModel.send(.fetch)
        waitForExpectations(timeout: 4)
        XCTAssertNotNil(employees)
        XCTAssert(employees!.isEmpty)
    }
    
    func testLoading() {
        
        
        class MockEmployeeFetcher: SQEmployeeFetchable {
            func fetchEmployees(_ handler: @escaping SQEmployeeFetchable.Handler) {
                let mockEmployee = SQEmployee(uuid: "abc",
                                              full_name: "Jane Doe",
                                              phone_number: nil,
                                              email_address: "email",
                                              biography: nil,
                                              photo_url_small: nil,
                                              photo_url_large: nil,
                                              team: "ATeam",
                                              employee_type: .CONTRACTOR)
                handler(.success([mockEmployee]))
            }
        }
        
        let listModel = SQEmployeeListControllerModel(MockEmployeeFetcher())
        let expectation = self.expectation(description: #function)
        
        var employees = [SQEmployee]()
        
        
        listModel.onStatusChanged = { status in
            switch status {
            case .success:
                employees = listModel.employees
                expectation.fulfill()
            default: break
            }
        }
        
        listModel.send(.fetch)
        waitForExpectations(timeout: 4)
        XCTAssert(employees.count == 1)
        XCTAssert(employees[0].full_name == "Jane Doe")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
