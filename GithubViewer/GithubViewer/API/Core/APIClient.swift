//
//  APIClient.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/18/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import Foundation

enum APIClientError: Error {
    case ParsingError
    case ServerError
    case UnknownError
}

enum HttpMethod: String {
    case GET = "GET"
}
