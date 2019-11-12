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
            case .busy(let isBusy):
                break
            case .error(let error):
                break
            case .success:
                self.tableView.reloadData()
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
}
