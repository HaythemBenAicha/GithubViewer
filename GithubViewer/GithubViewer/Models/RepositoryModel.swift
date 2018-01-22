//
//  RepositoryModel.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/18/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import Foundation

struct RepositoryModel : Codable {
    
    // MARK: - Properties
    let reposID: Int
    let name: String?
    let repoDescription: String?
    let forksCount : Int?
    let starsCount : Int?
    let language : String?
    let updatedAt : String?
    
}

extension RepositoryModel {
    enum CodingKeys: String, CodingKey {
        case reposID = "id"
        case name
        case repoDescription = "description"
        case forksCount = "forks_count"
        case starsCount = "stargazers_count"
        case language
        case updatedAt = "updated_at"
        
    }
}

