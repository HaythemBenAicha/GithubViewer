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

class RepositoriesViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var repositoriesSearchBar: UISearchBar!
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let searchText = Variable<String?>(nil)
    private let viewModel = RepositoriesViewModel()
    
    // MARK: - Lifecycle Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupObserving()
    }
    
    // MARK: - Private
    private func setupObserving() {
        viewModel.getRepositories()
            .drive(repositoriesTableView.rx.items(cellIdentifier: "RepositoryCell")) { (_, repository, cell : RepositoryCell) in
                cell.setupCellWithRepository(repository: repository)
        }.disposed(by: disposeBag)
        
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

