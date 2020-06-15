//
//  Utils.swift
//  CompostionalDiffableApp
//
//  Created by yongzhan on 2020/6/14.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import Foundation

class Utils {
    static let josnDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}
