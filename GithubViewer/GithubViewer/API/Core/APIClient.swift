//
//  APIClient.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/18/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import RxSwift


enum APIClientError: Error {
    case ParsingError
    case ServerError
    case UnknownError
    case Other(Error)
    case BadStatus(status: Int)
}

enum HttpMethod: String {
    case GET = "GET"
}

final class APIClient {
    
    // MARK: - Private
    private let baseURL: URL
    private let session: URLSession
    
    init(baseURL: URL, configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.baseURL = baseURL
        self.session = URLSession(configuration: configuration)
    }
}

extension APIClient {
    
    private func data(resource: APIResource) -> Observable<Data>{
        let request = resource.requestWithBaseURL(baseURL: self.baseURL)
        
        return Observable.create { observer in
            
            let task = self.session.dataTask(with: request as URLRequest ) { data, response, error in
                
                if let error = error {
                    observer.onError(APIClientError.Other(error))
                } else {
                    guard let HTTPResponse = response as? HTTPURLResponse else {
                        observer.onError(APIClientError.ServerError)
                        return
                    }
                    
                    guard let data = data else {
                        observer.on(.error(APIClientError.UnknownError))
                        return
                    }
                    
                    if 200 ..< 300 ~= HTTPResponse.statusCode {
                        
                        observer.on(.next(data))
                        observer.on(.completed)
                        
                    }
                    else {
                        observer.onError(APIClientError.BadStatus(status: HTTPResponse.statusCode))
                    }
                }
            }
            
            task.resume()
            return Disposables.create(with: task.cancel)
        }
    }
}




