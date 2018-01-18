//
//  RepositoriesViewModel.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/19/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import RxSwift
import RxCocoa
    
final class RepositoriesViewModel {
    
    var searchText = Variable<String>("")
    
    func getRepositories() -> Driver<[RepositoryModel]>{
        return Observable.just([])
            .asDriver(onErrorJustReturn: [])
    }
    
}
