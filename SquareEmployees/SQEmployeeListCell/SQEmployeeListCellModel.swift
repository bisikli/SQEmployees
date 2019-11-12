//
//  SQEmployeeListCellModel.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

struct SQEmployeeListCellModel {
    
    let picture: String?
    let name: String
    let team: String
    let email: String
    
    func decorate(_ cell: SQEmployeeListCell) {
        cell.name.text = name
        cell.team.text = team
        cell.email.text = email
        cell.picture.loadImage(with: picture ?? "", placeholder: UIImage(systemName: "person.circle"))
    }
    
}
