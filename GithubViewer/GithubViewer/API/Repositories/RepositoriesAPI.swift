//
//  RepositoriesAPI.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/18/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import RxSwift

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
}

