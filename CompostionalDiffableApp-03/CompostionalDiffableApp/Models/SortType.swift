//
//  SortType.swift
//  CompostionalDiffableApp
//
//  Created by yongzhan on 2020/6/14.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import Foundation

enum SortType: CaseIterable, CustomStringConvertible {
    case popularity
    case rating
    case releaseData
    
    var description: String {
        switch self {
        case .popularity:
            return "最多人喜欢"
        case .rating:
            return "最多评价"
        case .releaseData:
            return "最新发布"
        }
    }
    
}
