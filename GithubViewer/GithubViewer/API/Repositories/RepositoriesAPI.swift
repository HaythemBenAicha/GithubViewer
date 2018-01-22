//
//  RepositoriesAPI.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/18/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import RxSwift
import RxDataSources


// MARK: - Enum
enum RepositoriesAPI {
    case userRepositories (username : String)
}

// MARK: - Config request params
extension RepositoriesAPI: APIResource {
    
    var path : String {
        switch self {
        case .userRepositories(let username):
            return  String(format: Constants.EndPoint.userRepositories, username)
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .userRepositories:
            return HttpMethod.GET
        }
    }
    
}

// MARK: - Get Server Sesponse
extension APIClient {
    class func repositoriesAPIClient() -> APIClient {
        return APIClient(baseURL: (Constants.Config.baseURL)!)
    }
    
    func repositoriesWithUsername(username: String) -> Observable<[RepositoryModel]> {
        if username.isEmpty {
            return Observable.just([])
        }
        return objects(resource: RepositoriesAPI.userRepositories(username: username))
        
    }
    
    func sectionedRepositoriesWithUsername(username: String) -> Observable<[SectionOfRepositoriesModel]> {
        let all = self.repositoriesWithUsername(username: username)
       
        return all.map({ (repositories) in
                self.sortedItems(repositories: repositories)
            })
            .map({ (repositories) in
                self.sectionedRepositories(repositories: repositories)
            })
            .map({ (sectionedRepositories) in
                self.sortedSections(sections: sectionedRepositories)
            })
    }
    
    func sectionedRepositories(repositories: [RepositoryModel]) -> [SectionOfRepositoriesModel]{
        var sections = [SectionOfRepositoriesModel]()
        if let repositoriesHeaders = NSOrderedSet.init(array: repositories.map({$0.language ?? "Not Indicated"})).array as? [String]{
            repositoriesHeaders.forEach({ (header) in
                let section = SectionOfRepositoriesModel(header: header, items: repositories.filter{$0.language == header || $0.language == nil})
                sections.append(section)
            })
        }
        
        return sections
    }
    
}

// MARK: - Sorting
extension APIClient {
    
    // TODO: - Section Sorting
    func sortedSections(sections : [SectionOfRepositoriesModel]) -> [SectionOfRepositoriesModel] {
        
        let sortedSections = sections.sorted { (section1, section2) -> Bool in
            section1.items.count > section2.items.count
        }
        
        return sortedSections
    }
    
    // TODO: - Section Sorting
    func sortedItems(repositories : [RepositoryModel]) -> [RepositoryModel] {
        
        let sortedItems = section.sorted { (item1, item2) -> Bool in
            
            let item1Stars = item1.starsCount ?? 0
            let item2Stars = item2.starsCount ?? 0
            
            return item1Stars > item2Stars
        }
    
        return sortedItems
    }
}
