//
//  Constants.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/18/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import Foundation

struct Constants {
    // MARK: - Config
    struct Config {
        static let baseURL = URL(string: "https://api.github.com")
    }
    
    // MARK: - EndPoints
    struct EndPoint {
        static let userRepositories = "/users/%@/repos"
    }
}

