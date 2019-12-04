//
//  SQImageFetcheble.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

class SQRemoteImageFetcher : SQImageFetcheble {
    
    private var dataTask: URLSessionDataTask?
    
    func fetchImage(with url: URL, _ handler: @escaping SQImageFetcheble.Handler) {
        
        if let existingTask = dataTask,  existingTask.state == .suspended {
            existingTask.resume()
        }
        
        func onResultInMainThread(_ result: Result<UIImage, Error>) {
            DispatchQueue.main.async {
                handler(result)
            }
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        dataTask = session.dataTask(with: urlRequest) { [weak self]
            (data, response, error) in
            guard let responseData = data else {
                onResultInMainThread(.failure(SQRemoteFetcherError.dataRecieveError))
                return
            }
            guard error == nil else {
                onResultInMainThread(.failure(SQRemoteFetcherError.networkError(error: error!)))
                return
            }
            
            guard let image = UIImage(data: responseData) else {
                return
            }
            
            onResultInMainThread(.success(image))
            
            self?.dataTask = nil
        }
        dataTask?.resume()
        
    }
    
    func pauseFetching() {
        dataTask?.suspend()
    }
    
    
}
