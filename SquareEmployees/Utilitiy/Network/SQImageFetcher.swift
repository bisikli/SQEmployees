//
//  SQImageFetcheble.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

class SQRemoteImageFetcher : SQImageFetcheble {
    
    func fetchImage(with url: URL, _ handler: @escaping SQImageFetcheble.Handler) {
        
        func onResult(_ result: Result<UIImage, Error>) {
            DispatchQueue.main.async {
                handler(result)
            }
        }
        
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            guard let responseData = data else {
                onResult(.failure(SQRemoteFetcherError.dataRecieveError))
                return
            }
            guard error == nil else {
                onResult(.failure(SQRemoteFetcherError.networkError(error: error!)))
                return
            }
            
            guard let image = UIImage(data: responseData) else {
                return
            }
            
            onResult(.success(image))
        }
        task.resume()
        
        
    }
}
