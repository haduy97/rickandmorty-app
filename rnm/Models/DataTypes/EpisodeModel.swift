//
//  RMEpisode.swift
//  rnm
//
//  Created by Duy Ha on 04/01/2024.
//

import Foundation

struct EpisodeModel: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
