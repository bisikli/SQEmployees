//
//  SQImageFetcher.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 3.12.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import Foundation

struct SQImageFetcher: SQImageFetcheble {
    
    private let fetcher : SQImageFetcheble
    private let cache : SQImageCachable
    
    init(_ fetcher: SQImageFetcheble = SQRemoteImageFetcher(), _ cache: SQImageCachable = SQImageCacher() ) {
        self.fetcher = fetcher
        self.cache = cache
    }
    
    func fetchImage(with url: URL, _ handler: @escaping Self.Handler) {
        if let cachedImage = cache.getImage(url.absoluteString) {
            handler(.success(cachedImage))
            return
        }
        fetcher.fetchImage(with: url) { (result) in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let image):
                self.cache.saveImage(image, key: url.absoluteString)
                handler(.success(image))
            }
            
        }
    }
    
    func pauseFetching() {
        fetcher.pauseFetching()
    }
    
    
}
