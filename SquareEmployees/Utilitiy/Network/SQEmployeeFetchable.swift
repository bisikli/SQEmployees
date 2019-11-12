//
//  SQEmployeeFetchable.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation

protocol SQEmployeeFetchable {
    typealias Handler = (Result<[SQEmployee], Error>) -> Void
    func fetchEmployees(_ handler: @escaping Handler)
}
