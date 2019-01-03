//
//  ProductResultCollectionViewCell.swift
//  Tokopedia
//
//  Created by Digital Khrisna on 04/05/18.
//  Copyright © 2018 TOKOPEDIA. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

public class ProductResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productNameLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var countRatingLabel: UILabel!
    @IBOutlet private weak var productTopLabelStackView: UIStackView!
    @IBOutlet private weak var productBottomLabelStackView: UIStackView!
    @IBOutlet private weak var productShopAddressLabel: UILabel!
    @IBOutlet private weak var productBadgeStackView: UIStackView!
    
    private let disposeBag = DisposeBag()
    
    public func bind(_ viewModel: ProductResultCellViewModel) {
        
        let input = ProductResultCellViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.productImage.drive(onNext: { [weak self] url in
            guard let `self` = self else {
                return
            }
            
            let data = try? Data(contentsOf: url)
            self.productImageView.image = UIImage(data: data!)
        }).disposed(by: disposeBag)
        
        output.productName.drive(productNameLabel.rx.text).disposed(by: disposeBag)
        
        output.productPrice.drive(productPriceLabel.rx.text).disposed(by: disposeBag)
        
        output.productCountReview.drive(onNext: { [weak self] countReview in
            guard let `self` = self else {
                return
            }
            
            if countReview > 0 {
                self.countRatingLabel.isHidden = false
                self.countRatingLabel.text = String(format: "(%@)", "\(countReview)")
            } else {
                self.countRatingLabel.isHidden = true
            }
        }).disposed(by: disposeBag)
        
        output.productTopLabels.drive(onNext: { [weak self] labels in
            guard let `self` = self else {
                return
            }
            
            if labels.count > 0 {
                self.productTopLabelStackView.removeAllSubviews()
                labels.forEach { self.productTopLabelStackView.addArrangedSubview($0) }
            } else {
                self.productTopLabelStackView.removeAllSubviews()
            }
        }).disposed(by: disposeBag)
        
        output.productBottomLabels.drive(onNext: { [weak self] labels in
            guard let `self` = self else {
                return
            }
            
            if labels.count > 0 {
                self.productBottomLabelStackView.removeAllSubviews()
                labels.forEach { self.productBottomLabelStackView.addArrangedSubview($0) }
            } else {
                self.productBottomLabelStackView.removeAllSubviews()
            }
        }).disposed(by: disposeBag)
        
        output.productShopCity.drive(productShopAddressLabel.rx.text).disposed(by: disposeBag)
        
        output.productBadges.drive(onNext: { [weak self] badges in
            guard let `self` = self else {
                return
            }
            
            guard badges.count > 0 else {
                self.productBadgeStackView.removeAllSubviews()
                return
            }
            
            self.productBadgeStackView.removeAllSubviews()
            
            for urlString in badges {
                if let url = URL(string: urlString) {
                    let imageView = UIImageView(frame: .zero)
                    let data = try? Data(contentsOf: url)
                    imageView.image = UIImage(data: data!)
                    
                    self.productBadgeStackView.addArrangedSubview(imageView)
                    
                    imageView.heightAnchor.constraint(equalTo: self.productBadgeStackView.heightAnchor, multiplier: 1).isActive = true
                    imageView.widthAnchor.constraint(equalTo: self.productBadgeStackView.heightAnchor, multiplier: 1).isActive = true
                }
            }
        }).disposed(by: disposeBag)
    }
}

extension UIView {
    public func removeAllSubviews() {
        subviews.forEach({ view in
            view.removeFromSuperview()
        })
    }
}
