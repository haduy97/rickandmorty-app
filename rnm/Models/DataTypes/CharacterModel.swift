//
//  RMCharacter.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: EnumCharacterStatus
    let species: String
    let type: String
    let gender: EnumCharacterGender
    let origin: OriginModel
    let location: OriginModel
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

enum EnumCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
            
        case .unknown:
            return "Unknown"
        }
    }
}

enum EnumCharacterGender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}
