//
//  SQImageCacher.swift
//  SquareEmployees
//
//  Created by Bilgehan Işıklı on 12.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

class SQImageCacher : SQImageCachable {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func createDirectoryIfNotExists(at url: URL) throws {
        if !FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
    }

    func getImageDirectory(for string: String) -> URL {
        var fileKey = string
        if let urlComponents = URLComponents(string: string) {
            fileKey = "\(urlComponents.hashValue)"
        }
        return getDocumentsDirectory().appendingPathComponent(fileKey + ".jpg")
    }
    
    func getImage(_ key: String) -> UIImage? {
        guard let data = try? Data(contentsOf: getImageDirectory(for: key)) else { return nil }
        return UIImage(data: data)
        
    }
    func saveImage(_ image: UIImage, key: String) {
        do {
            try image.pngData()?.write(to: getImageDirectory(for: key), options: .atomic)
        } catch {
            print("Image file write error: \(error)")
        }
        
    
    }
    
}
