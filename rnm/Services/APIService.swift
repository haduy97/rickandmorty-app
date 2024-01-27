//
//  APIService.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import Foundation

//Error Type
enum ServiceError: Error {
    case failedToCreateUrlRequest
    case failedToGetData
    case failedToDecodeResponse
}

//API Services for get data
final class APIService {
    static let shared = APIService()
    
    //Execute API call
    // - Parameters:
    // -- request: Request Instance/Variable
    // -- responseType: The type model expecting when be responsed (Response Type)
    // -- completion: Callback when Call API is completed
    public func execute<T: Codable>(
        _ request: Request,
        responseType type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlRequest: URLRequest = onRequest(from: request) else {
            completion(.failure(ServiceError.failedToCreateUrlRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ServiceError.failedToGetData))
                return
            }
            
            //Decode JSON Response
            do {
                let rs = try JSONDecoder().decode(type.self, from: data)
                completion(.success(rs))
            } catch {
                completion(.failure(ServiceError.failedToDecodeResponse))
            }
        }
        
        task.resume()
    }
    
    
    //Private
    private func onRequest(from request: Request) -> URLRequest? {
        guard let url: URL = request.url else { return nil }
        
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 12)
        urlRequest.httpMethod = request.httpMethod
        
        return urlRequest
    }
}
