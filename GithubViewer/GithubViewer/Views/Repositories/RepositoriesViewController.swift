//
//  ViewController.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/16/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class RepositoriesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var repositoriesSearchBar: UISearchBar!
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let searchText = Variable<String?>(nil)
    private let viewModel = RepositoriesViewModel()
    
    private let dataSource = RxTableViewSectionedReloadDataSource<SectionOfRepositoriesModel>(
        configureCell: { (_, tv, ip, repository: RepositoryModel) in
            let cell = tv.dequeueReusableCell(withIdentifier: "RepositoryCell") as! RepositoryCell
            cell.setupCellWithRepository(repository: repository)
            return cell
    },
        titleForHeaderInSection: { dataSource, sectionIndex in
            let section = dataSource[sectionIndex]
            return section.items.count > 0 ? "\(section.header) (\(section.items.count))" : "No repositories found"
    })
    
    // MARK: - Lifecycle Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupObserving()
    }
    
    // MARK: - Private
    private func setupObserving() {
        
        viewModel.getRepositories()
            .drive(repositoriesTableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        repositoriesSearchBar.rx.text
            .orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
        repositoriesSearchBar.rx.cancelButtonClicked
            .map{""}
            .bind(to: viewModel.searchText)
            .disposed(by: disposeBag)
        
    }

}

