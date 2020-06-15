//
//  BageItemCollectionViewCell.swift
//  CompostionalDiffableApp
//
//  Created by yongzhan on 2020/6/15.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import UIKit

class GameItemCollectionViewCell: UICollectionViewCell {
    static let reusedId = "GameItemId"
    var imageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    func configure( game: Game){
        let imageId = (game.cover.imageId ?? "")
        if !imageId.isEmpty {
            print("\(imageId)")
            imageView.backgroundColor = .yellow
        } else {
            imageView.image = nil
        }
    }
    
    private func setupCell(){
        contentView.addSubview(imageView)
        layer.cornerRadius = 5
        clipsToBounds = true
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
