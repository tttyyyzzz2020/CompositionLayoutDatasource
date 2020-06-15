//
//  Game.swift
//  CompostionalDiffableApp
//
//  Created by yongzhan on 2020/6/14.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import Foundation


struct Game: Identifiable, Codable {
    var id: Int
    var cover: Cover
    var firstReleaseDate: Int
    var genres: [Genre]
    var name: String
    var platforms: [Platform]
    var popularity: Double
    var rating: Double?
}

struct Cover: Codable {
    var id: Int
    var imageId: String
}

struct Genre: Codable {
    var id: Int
}

struct Platform:Codable {
    var id: Int
}
