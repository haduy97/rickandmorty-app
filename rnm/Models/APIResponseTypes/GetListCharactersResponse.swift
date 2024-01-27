//
//  GetAllCharactersResponse.swift
//  rnm
//
//  Created by Duy Ha on 14/01/2024.
//

import Foundation

struct GetListCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String?
    }
    
    let info: Info
    let results: [CharacterModel]
}
