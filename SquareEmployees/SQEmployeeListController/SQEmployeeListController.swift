//
//  SQEmployeeListController.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

class SQEmployeeListController: UITableViewController {
    
    private let viewModel : SQEmployeeListControllerModel
    
    init(_ viewModel: SQEmployeeListControllerModel = SQEmployeeListControllerModel()) {
        self.viewModel = viewModel
        super.init(style: .plain)
        tableView.tableFooterView = UIView()
        tableView.register(SQEmployeeListCell.self, forCellReuseIdentifier: SQEmployeeListCell.reuseIdentifier)
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.send(.fetch)
    }
    
    private func bind() {
        viewModel.onStatusChanged = { [unowned self] status in
            switch(status) {
            case .busy:
                self.handleBusyState()
            case .error(let error):
                self.handleEmptyState("Error fetching employees: \n \(error.localizedDescription)")
            case .success:
                self.handleReload()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SQEmployeeListCell.reuseIdentifier, for: indexPath) as! SQEmployeeListCell
        
        viewModel.cellModel(for: indexPath).decorate(cell)
        
        return cell
        
    }
    
    func handleBusyState() {
        tableView.separatorStyle = .none
        let indicator = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        indicator.contentMode = .scaleAspectFit
        tableView.backgroundView = indicator
        
        
        indicator.addAspectRatioConstraint(aspectRatio: 1)
        indicator.addMultipleConstraints(attributes: [.centerX,.centerY], to: view)
        indicator.addConstraint(attribute1: .width, to: tableView, multiplier: 0.3)
        
        let anim = CABasicAnimation(keyPath: "transform.rotation.y")
        anim.duration = 2
        anim.fromValue = 0
        anim.toValue = Float.pi
        anim.repeatCount = Float.infinity
        
        indicator.layer.add(anim, forKey: "loading")
        
    }
    
    func handleEmptyState(_ message: String ) {
        tableView.separatorStyle = .none
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0,
                                                 width: tableView.bounds.size.width,
                                                 height: tableView.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.preferredFont(forTextStyle: .body)
        messageLabel.sizeToFit()

        tableView.backgroundView = messageLabel;
    }
    
    func handleReload() {
        if viewModel.employees.count > 0 {
            self.tableView.backgroundView = nil
            self.tableView.separatorStyle = .singleLine
        } else {
            handleEmptyState("There are no Employees..")
        }
        self.tableView.reloadData()
    }
}
