//
//  ImageLoader.swift
//  rnm
//
//  Created by Duy Ha on 23/01/2024.
//

import Foundation

final class ImageLoader {
    static let shared = ImageLoader()
    
    private let imageCache = NSCache<NSString, NSData>()
    
    public func fetchImg(_  url: URL,completion: @escaping (Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString // NSString == String
        
        // If the image already cached
        if let data = imageCache.object(forKey: key) {
            completion(.success(data as Data)) // NSData == Data
            return
        }
        
        // If the image not cached yet
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 20.0)
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            let value = data as NSData // NSData == Data
            self?.imageCache.setObject(value, forKey: key)
            
            completion(.success(data))
        }
        
        task.resume()
    }
}
