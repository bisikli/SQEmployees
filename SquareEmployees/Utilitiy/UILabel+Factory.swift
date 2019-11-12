//
//  UILabel+Factory.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

extension UILabel {
    
    static func create(_ numberOfLines : Int = 0) -> UILabel {
        let label = UILabel()
        label.numberOfLines = numberOfLines
        return label
    }
    
    func addingFont(_ font: UIFont) -> UILabel {
        self.font = font
        return self
    }
    
    func addingColor(_ color: UIColor) -> UILabel {
        self.textColor = color
        return self
    }
}
