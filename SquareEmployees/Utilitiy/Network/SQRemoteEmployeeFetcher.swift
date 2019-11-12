//
//  SQRemoteEmployeeFetcher.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation

enum SQRemoteEmployeeFetchAPI:String{
    case `default` = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    case malformed = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    case empty     = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
}

class SQRemoteEmployeeFetcher: SQRemoteFetchable, SQEmployeeFetchable {
    internal let endPoint: String
    typealias DataType = [String:[SQEmployee]]
    
    init(_ endPoint: String = SQRemoteEmployeeFetchAPI.default.rawValue){
        self.endPoint = endPoint
    }
    
    func fetchEmployees(_ handler: @escaping SQEmployeeFetchable.Handler) {
        fetchData { (result) in
            switch(result) {
            case .failure(let error):
                handler(.failure(error))
            case .success(let data):
                guard let employeelist = data["employees"] else {
                    handler(.failure(SQRemoteFetcherError.jsonParseError(description: "Nothing found under 'employees' keyword")))
                    return
                }
                handler(.success(employeelist))
            }
        }
    }
}
