//
//  Location.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import Foundation

struct LocationModel: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
