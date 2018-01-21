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
    
    func getRepositories(client : APIClient = APIClient.repositoriesAPIClient()) -> Driver<[SectionOfRepositoriesModel]>{
        return self.searchText.asObservable()
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest {
                client.sectionedRepositoriesWithUsername(username: $0).catchError({ error in
                    switch error {
                    case APIClientError.BadStatus:
                        print("Error: \(error)")
                        return Observable.just([])
                    default:
                        print("Error: \(error)")
                        return Observable.just([])
                    }
                })
            }
            .asDriver(onErrorJustReturn: [])
    }
    
}

