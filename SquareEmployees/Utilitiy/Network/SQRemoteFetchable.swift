//
//  File.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation

enum SQRemoteFetcherError: Error {
    case urlError
    case dataRecieveError
    case networkError(error: Error)
    case jsonParseError(description: String)
}

protocol SQRemoteFetchable {
    associatedtype DataType:Codable
    typealias Handler = (Result<DataType, Error>) -> Void
    var endPoint: String { get }
    func fetchData(_ handler: @escaping Handler)
}

extension SQRemoteFetchable {
    
    func fetchData(_ handler: @escaping Handler) {
        
        guard let url = URL(string: endPoint) else {
            handler(.failure(SQRemoteFetcherError.urlError))
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            guard error == nil else {
                handler(.failure(SQRemoteFetcherError.networkError(error: error!)))
                return
            }
            guard let responseData = data else {
                handler(.failure(SQRemoteFetcherError.dataRecieveError))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let data = try decoder.decode(DataType.self, from: responseData)
                handler(.success(data))
            } catch {
                handler(.failure(SQRemoteFetcherError.jsonParseError(description: "\(error)")))
            }
        }
        task.resume()
    }
}


