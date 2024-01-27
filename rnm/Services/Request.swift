//
//  APIRequest.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import Foundation

//Singlet request API call
final class Request {
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    private let endpoint: Endpoint
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]
    
    //Constructed url for the API request in String Formatter
    private var urlComponents: URLComponents {
        var components = URLComponents(string: Constants.baseUrl)!
        components.path += "/" + endpoint.rawValue
        components.path += pathComponents.isEmpty ? "" : "/" + pathComponents.joined(separator: "/")
        components.queryItems = queryParameters.isEmpty ? nil : queryParameters
        
        return components
    }
    
    //Constructed url for the API request in string format
//    private var urlString: String {
//        var string = Constants.baseUrl + "/"
//        string += endpoint.rawValue
//
//        if !pathComponents.isEmpty {
//            pathComponents.forEach { string += "/\($0)" }
//        }
//
//        if !queryParameters.isEmpty {
//            string += "?"
//            //name=value&name=value...
//            let argument = queryParameters.compactMap({
//                guard let value = $0.value else { return nil }
//
//                return "\($0.name)=\(value)"
//            }).joined(separator: "&")
//
//            string += argument
//        }
//
//        return string
//    }
    
    //Public
    //Computed & Constructed API url
    public var url: URL? {
        return urlComponents.url
    }
    
    //Desired method
    public let httpMethod = "GET"
    
    //Initial with Props
    // - Props:
    // -- endpoint
    // -- pathComponents: Collection of Paths
    // -- queryParameters: Collection of Parameters
    init(endpoint: Endpoint, pathComponents: [String] = [], queryParameters: [URLQueryItem] = []) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        let string = url.absoluteString
        
        guard string.starts(with: Constants.baseUrl) else { return nil }
        let trimmed = string.replacingOccurrences(of: Constants.baseUrl + "/", with: "")
        
        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty {
                let endpointString: String = components[0]
                if let endpoint = Endpoint(rawValue: endpointString) {
                    self.init(endpoint: endpoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty {
                let endpointString: String = components[0]
                let queryItemsString: String = components[1]
                
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else { return nil }
                    
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                
                if let endpoint = Endpoint(rawValue: endpointString) {
                    self.init(endpoint: endpoint, queryParameters: queryItems)
                    return
                }
            }
            
        }
        
        return nil
    }
}

//Extension Request
extension Request {
     static let getListCharacters = Request(endpoint: .character)
}
