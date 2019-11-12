//
//  SQEmployee.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation

struct SQEmployee: Codable {
    let uuid: String
    let full_name: String
    let phone_number: String?
    let email_address: String
    let biography: String?
    let photo_url_small: String?
    let photo_url_large: String?
    let team: String
    let employee_type: SQEmployeeType
}

enum SQEmployeeType: String, Codable {
    case FULL_TIME
    case PART_TIME
    case CONTRACTOR
}
