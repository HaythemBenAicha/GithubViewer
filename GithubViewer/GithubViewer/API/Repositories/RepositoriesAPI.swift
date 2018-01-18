//
//  RepositoriesAPI.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/18/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import Foundation

enum RepositoriesAPI {
    case userRepositories (username : String)
}

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
