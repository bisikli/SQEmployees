//
//  SQEmployeeListControllerModel.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation

class SQEmployeeListControllerModel {
    
    enum Action {
        case fetch
    }
    
    enum Status {
        case busy
        case error(Error)
        case success
    }
    
    private let fetcher: SQEmployeeFetchable
    
    var employees: [SQEmployee] = []
    var onStatusChanged : (Status)->Void = { _ in }
    
    init(_ fetcher: SQEmployeeFetchable = SQRemoteEmployeeFetcher(SQRemoteEmployeeFetchAPI.default.rawValue)) {
        self.fetcher = fetcher
    }
    
    func send(_ action: Action) {
        switch action {
        case .fetch:
            self.onStatusChanged(.busy)
            fetcher.fetchEmployees { [unowned self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        self.onStatusChanged(.error(error))
                    case .success(let employees):
                        self.employees = employees
                        self.onStatusChanged(.success)
                    }
                }
            }
            break
        }
    }
    
    func cellModel(for indexPath: IndexPath) -> SQEmployeeListCellModel {
        let employee = employees[indexPath.row]
        return SQEmployeeListCellModel(picture: employee.photo_url_small,
                                       name: employee.full_name,
                                       team: employee.team,
                                       email: employee.email_address)
    }
}
