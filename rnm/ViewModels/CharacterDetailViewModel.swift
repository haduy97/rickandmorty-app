//
//  CharacterDetailViewModel.swift
//  rnm
//
//  Created by Duy Ha on 20/01/2024.
//

import Foundation

final class CharacterDetailViewModel: NSObject {
    private let character: CharacterModel
    
    init(_ character: CharacterModel) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
