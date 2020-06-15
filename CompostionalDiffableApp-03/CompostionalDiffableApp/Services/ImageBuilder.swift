//
//  ImageBuilder.swift
//  CompostionalDiffableApp
//
//  Created by yongzhan on 2020/6/15.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import Foundation

// https://images.igdb.com/igdb/image/upload/t_cover_big/dfgkfivjrhcksyymh9vw.jpg

private let imageBaseURL = "https://images.igdb.com/igdb/image/upload/"

enum ImageSize: String {
    case COVER_BIG = "t_cover_big"
    case COVER_SMALL = "t_cover_small"
    
}

enum ImageType: String {
    case jpg = "jpg"
    case png = "png"
}

func ImageBuilder(imageId: String, imageSize: ImageSize = .COVER_BIG, imageType: ImageType = .jpg) -> String {
    return "\(imageBaseURL)\(imageSize.rawValue)/\(imageId).\(imageType.rawValue)"
}

