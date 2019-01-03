//
//  HomeCollectionViewCell.swift
//  TokoGemepedia
//
//  Created by Nakama on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
//
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var quizTitleLabel: UILabel!
    
    static let identifier = "HomeCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageView.layer.borderColor = UIColor.white.cgColor
        self.imageView.layer.borderWidth = 5
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        self.imageView.layer.masksToBounds = true
    }
}
