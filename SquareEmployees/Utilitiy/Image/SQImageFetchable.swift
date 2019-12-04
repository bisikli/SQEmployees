//
//  SQImageFetchable.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

protocol SQImageFetcheble {
    typealias Handler = (Result<UIImage, Error>) -> Void
    func fetchImage(with url: URL, _ handler: @escaping Handler)
    func pauseFetching()
}
extension SQImageFetcheble {
    func pauseFetching() {}
}
