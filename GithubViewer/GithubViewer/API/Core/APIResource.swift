//
//  APIResource.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/18/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import Foundation

enum APIResourceError: Error {
    case InvalidURL
    case UnknownError
    case Other(Error)
}

protocol APIResource {
    var path : String { get }
    var method : HttpMethod {get}
}

extension APIResource {
    func requestWithBaseURL(baseURL: URL?) -> URLRequest {
        
        guard let finalURL = baseURL?.appendingPathComponent(path) else {
            fatalError("Invalid URL")
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        return request
    }
}

