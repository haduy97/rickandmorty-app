//
//  CharacterDetailView.swift
//  rnm
//
//  Created by Duy Ha on 29/01/2024.
//

import UIKit

// View of single Character
final class CharacterDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("CharacterDetailView Error!!")
    }

}
