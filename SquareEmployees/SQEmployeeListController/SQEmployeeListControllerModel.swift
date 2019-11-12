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
        //case sortMovies(SortOption)
    }
    
    enum Status {
        case busy(Bool)
        case error(Error)
        case success
    }
    
    private let fetcher: SQEmployeeFetchable
    
    var employees: [SQEmployee] = []
    var onStatusChanged : (Status)->Void = { _ in }
    
    init(_ fetcher: SQEmployeeFetchable = SQRemoteEmployeeFetcher()) {
        self.fetcher = fetcher
    }
    
    func send(_ action: Action) {
        switch action {
        case .fetch:
            self.onStatusChanged(.busy(true))
            fetcher.fetchEmployees { [unowned self] (result) in
                DispatchQueue.main.async {
                    self.onStatusChanged(.busy(false))
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
}
