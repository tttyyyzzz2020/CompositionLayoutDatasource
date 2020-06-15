//
//  BageItemCollectionViewCell.swift
//  CompostionalDiffableApp
//
//  Created by yongzhan on 2020/6/15.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import UIKit

class BageItemCollectionViewCell: UICollectionViewCell {
    static let reusedId = "BadgeItemId"
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    func configure( text: String, isSelected: Bool){
        titleLabel.text = text
        titleLabel.textColor =  isSelected ? .label : .secondaryLabel
        backgroundColor = isSelected ? .systemFill : .secondarySystemFill
    }
    
    private func setupCell(){
        contentView.addSubview(titleLabel)
        layer.cornerRadius = 5
        clipsToBounds = true
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        return contentView.systemLayoutSizeFitting(CGSize(width: titleLabel.intrinsicContentSize.width + 50 , height: 40))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
