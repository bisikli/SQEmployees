//
//  SQEmployeeListCell.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

class SQEmployeeListCell: UITableViewCell {
    let picture         = SQImageView()
    lazy var name       = UILabel.create().addingFont(UIFont.preferredFont(forTextStyle: .headline))
    lazy var team       = UILabel.create().addingFont(UIFont.preferredFont(forTextStyle: .subheadline))
    lazy var email      = UILabel.create().addingFont(UIFont.preferredFont(forTextStyle: .caption2))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        decorate()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        picture.image = UIImage(systemName: "person.circle.fill")!
        //some way to cancel existing URL query for an image
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupViews() {
        contentView.addSubview(picture)
        picture.addAspectRatioConstraint(aspectRatio: 1)
        picture.addMultipleConstraints(attributes: [.leading,.top], to: contentView, offset: 10)
        picture.addHeightConstraint(100)
  
    
        let contentStack = UIStackView(arrangedSubviews: [name,team,email])
        contentStack.axis = .vertical
        contentStack.distribution = .fillProportionally
        contentStack.spacing = 5
    
        contentView.addSubview(contentStack)
    
        contentStack.addMultipleConstraints(attributes: [.trailing,.bottom], to: contentView, offset: -5)
        contentStack.addConstraint(attribute1: .top, to: contentView, offset:10)
        contentStack.addConstraint(attribute1: .leading, to: picture, attribute2: .trailing, offset:10)
        contentStack.addConstraint(attribute1: .bottom, to: picture, relatedBy: .greaterThanOrEqual, offset: 10)
        
    }
    
    private func decorate() {
        picture.contentMode = .scaleAspectFit
    }
}
