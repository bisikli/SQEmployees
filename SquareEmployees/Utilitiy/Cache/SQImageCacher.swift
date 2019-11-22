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

    func getImageDirectory(for key: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(key + ".jpg")
    }
    
    func getImage(_ key: String) -> UIImage? {

        guard let fileKey = keyMap[key] else { return nil }
        
        guard let data = try? Data(contentsOf: getImageDirectory(for: fileKey)) else { return nil }
        return UIImage(data: data)
        
    }
    func saveImage(_ image: UIImage, key: String) {
        do {
            let fileKey = keyMap[key,default:UUID().uuidString]
            try image.pngData()?.write(to: getImageDirectory(for: fileKey), options: .atomic)
            keyMap[key] = fileKey
        } catch {
            print("Image file write error: \(error)")
        }
        
    
    }
    
    private var keyMap : [String:String] {
        get {
            UserDefaults.standard.value(forKey: "SQImageCacher.keyMap") as? [String:String] ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "SQImageCacher.keyMap")
        }
    }
    
}
