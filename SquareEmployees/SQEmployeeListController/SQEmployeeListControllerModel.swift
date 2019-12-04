//
//  SQEmployeeListControllerModel.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

enum SQEmployeeListSection: CaseIterable {
    case employee
}

class SQEmployeeListControllerModel {
    
    enum Action {
        case fetch
        case prefetch(items:[IndexPath])
        case cancelPrefetch(items:[IndexPath])
    }
    
    enum Status {
        case busy
        case error(Error)
        case empty
    }
    
    private let fetcher: SQEmployeeFetchable
    private var diffableDataSource : UITableViewDiffableDataSource<SQEmployeeListSection, SQEmployeeListCellModel>?
 
    private var cellModels = [SQEmployeeListCellModel]()
    var onStatusChanged : (Status)->Void = { _ in }
    
    init(_ fetcher: SQEmployeeFetchable = SQRemoteEmployeeFetcher(SQRemoteEmployeeFetchAPI.default.rawValue)) {
        self.fetcher = fetcher
    }
    
    func send(_ action: Action) {
        switch action {
        case .fetch:
            self.onStatusChanged(.busy)
            fetcher.fetchEmployees { [unowned self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        self.onStatusChanged(.error(error))
                    case .success(let employees):
                        self.cellModels = employees.map({SQEmployeeListCellModel($0)})
                        self.diffableDataSource?.apply(self.snapshot, animatingDifferences: false)
                        if self.cellModels.isEmpty {
                            self.onStatusChanged(.empty)
                        }
                    }
                }
            }
            break
        case .prefetch(let items):
            for indexPath in items {
                if indexPath.row < cellModels.count {
                    cellModels[indexPath.row].fetchImage { (_) in }
                } else {
                    //download new cellmodels first
                }
            }
            break
        case .cancelPrefetch(let items):
            for indexPath in items {
                if indexPath.row < cellModels.count {
                    cellModels[indexPath.row].pauseFetchingImage()
                } else {
                    //download new cellmodels first
                }
            }
            break
        }
    }
    
    func setupDataSource(of tableView: UITableView) {
        tableView.register(SQEmployeeListCell.self, forCellReuseIdentifier: SQEmployeeListCell.reuseIdentifier)
        diffableDataSource = UITableViewDiffableDataSource(tableView: tableView) { (tableView, indexPath, cellModel) -> UITableViewCell? in
                
            let cell = tableView.dequeueReusableCell(withIdentifier: SQEmployeeListCell.reuseIdentifier, for: indexPath) as! SQEmployeeListCell
            
            cell.decorate(cellModel)
            
            return cell
        }
        tableView.dataSource = diffableDataSource
    }

    
    var snapshot : NSDiffableDataSourceSnapshot<SQEmployeeListSection,SQEmployeeListCellModel> {
        var snapshot = NSDiffableDataSourceSnapshot<SQEmployeeListSection,SQEmployeeListCellModel>()
        snapshot.appendSections(SQEmployeeListSection.allCases)
        snapshot.appendItems(cellModels)
        return snapshot
    }
    
    
}


