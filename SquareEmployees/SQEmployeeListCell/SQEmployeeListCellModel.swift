//
//  SQEmployeeListCellModel.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

struct SQEmployeeListCellModel {
    
    private(set) var imageFetcher: SQImageFetcheble
    let picture: String?
    let name: String
    let team: String
    let email: String
    
    init(_ employee: SQEmployee, _ fetcher: SQImageFetcheble = SQImageFetcher()) {
        imageFetcher = fetcher
        picture = employee.photo_url_small
        name    = employee.full_name
        team    = employee.team
        email   = employee.email_address
    }
    
    func fetchImage(_ completion: @escaping SQImageFetcheble.Handler) {
        guard let pictureURL = URL(string: picture ?? "") else {
            return
        }
        imageFetcher.fetchImage(with: pictureURL, completion)
    }
    func pauseFetchingImage() {
        imageFetcher.pauseFetching()
    }
}

extension SQEmployeeListCellModel: Equatable {
    static func == (lhs: SQEmployeeListCellModel, rhs: SQEmployeeListCellModel) -> Bool {
        return lhs.email == rhs.email
    }
}

extension SQEmployeeListCellModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
    }
}
