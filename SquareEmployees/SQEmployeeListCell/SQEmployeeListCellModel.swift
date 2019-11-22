//
//  SQEmployeeListCellModel.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

struct SQEmployeeListCellModel:Hashable {
    
    let picture: String?
    let name: String
    let team: String
    let email: String
    
    init(_ employee: SQEmployee) {
        picture = employee.photo_url_small
        name    = employee.full_name
        team    = employee.team
        email   = employee.email_address
    }
    
    func decorate(_ cell: SQEmployeeListCell) {
        cell.name.text = name
        cell.team.text = team
        cell.email.text = email
        cell.picture.loadImage(with: picture ?? "", placeholder: UIImage(systemName: "person.circle.fill"))
    }
    
}
