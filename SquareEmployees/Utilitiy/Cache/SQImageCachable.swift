//
//  SQImageCachable.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

protocol SQImageCachable {
    func getImage(_ key: String) -> UIImage?
    func saveImage(_ image: UIImage, key: String)
}
