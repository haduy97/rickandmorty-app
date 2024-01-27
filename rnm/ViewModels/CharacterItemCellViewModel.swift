//
//  CharacterCellViewModel.swift
//  rnm
//
//  Created by Duy Ha on 16/01/2024.
//

import Foundation

final class CharacterItemCellViewModel: Equatable {

    private let status: EnumCharacterStatus
    private let imgUrl: URL?
    public let name: String
    
    public var statusText: String {
        let status = "Status: \(status.text)"
        return status
    }
    
    
    // Init
    init(name: String, status: EnumCharacterStatus, imgUrl: URL?) {
        self.name = name
        self.status = status
        self.imgUrl = imgUrl
    }
    
    // Func
    public func getImg(_ completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url: URL = imgUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        ImageLoader.shared.fetchImg(url, completion: completion)
    }
    
    
    //Equatable
    static func == (lhs: CharacterItemCellViewModel, rhs: CharacterItemCellViewModel) -> Bool {
        return lhs.name == rhs.name &&
            lhs.status == rhs.status &&
            lhs.imgUrl == rhs.imgUrl
    }
}
