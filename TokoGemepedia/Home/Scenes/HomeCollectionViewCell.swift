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
        
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor(red: 110.0/255.0, green: 80.0/255.0, blue: 140.0/255.0, alpha: 1.0).cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0.7
        
        self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
    }
}
