//
//  SQImageView.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

class SQImageView: UIImageView {
    
    private let fetcher : SQImageFetcheble
    private let cache : SQImageCachable
    
    init(_ fetcher: SQImageFetcheble = SQRemoteImageFetcher(), _ cache: SQImageCachable = SQImageCacher() ) {
        self.fetcher = fetcher
        self.cache = cache
        super.init(frame: .zero)
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadImage(with urlString: String, placeholder: UIImage? = nil) {
        
        if let cachedImage = cache.getImage(urlString) {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        fetcher.fetchImage(with: url) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.setImageAnimated(image)
                self.cache.saveImage(image, key:urlString)
            case .failure(let error):
                self.image = placeholder
                break
            }
        }
    }
    
    private func setImageAnimated(_ image: UIImage) {
        UIView.transition(with: self, duration: 2, options: .transitionCrossDissolve, animations: {
            self.image = image
            self.layer.borderWidth = 0
        })
    }
}
