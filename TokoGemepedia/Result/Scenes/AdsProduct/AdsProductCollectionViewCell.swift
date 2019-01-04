//
//  AdsProductCollectionViewCell.swift
//  TokoGemepedia
//
//  Created by Digital Khrisna on 04/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import UIKit

class AdsProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UINib(nibName: "ProductResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductResultCollectionViewCell")
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    var adsItems: [SearchResultProduct] = []
    static let identifier = "AdsProductCollectionViewCell"
}

extension AdsProductCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adsItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductResultCollectionViewCell", for: indexPath) as! ProductResultCollectionViewCell
        
        let item = adsItems[indexPath.row]
        let cellVM = ProductResultCellViewModel(with: item)
        cell.bind(cellVM)
        
        return cell
    }
}

extension AdsProductCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.size.width / 2) - 8
        let height: CGFloat = width + 110
        
        return CGSize(width: width, height: height)
    }
}
