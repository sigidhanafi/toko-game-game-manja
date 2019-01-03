//
//  ProductResultCellViewModel.swift
//  Tokopedia
//
//  Created by Digital Khrisna on 15/05/18.
//  Copyright © 2018 TOKOPEDIA. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

public class ProductResultCellViewModel {
    public struct Input {
        
    }
    
    public struct Output {
        public let productImage: Driver<URL>
        public let productName: Driver<String>
        public let productPrice: Driver<String>
        public let productRating: Driver<Int>
        public let productCountReview: Driver<Int>
        public let productLabels: Driver<[SearchProductLabel]>
        public let productTopLabels: Driver<[UIButton]>
        public let productBottomLabels: Driver<[UIButton]>
        public let productShopName: Driver<String>
        public let productShopCity: Driver<String>
        public let productBadges: Driver<[String]>
    }
    
    private let productItem: SearchResultProduct
    
    public init(with productItem: SearchResultProduct) {
        self.productItem = productItem
    }
    
    public func transform(input: Input) -> Output {
        
        let productItemState = BehaviorRelay<SearchResultProduct>(value: productItem)
        let productDriver = Driver.just(productItemState)
        
        let productImage = productDriver.flatMap { product -> Driver<URL> in
            guard let url = URL(string: product.value.imageURL ?? "") else {
                return Driver.empty()
            }
            return Driver.just(url)
        }
        
        let productName = productDriver.map { product -> String in
            guard let name = product.value.name else {
                return ""
            }
            return name
        }
        
        let productPrice = productDriver.map { product -> String in
            guard let price = product.value.price else {
                return ""
            }
            return price
        }
        
        let productRating = productDriver.map { product -> Int in
            return product.value.rating
        }
        
        let productCountReview = productDriver.map { product -> Int in
            guard let countReview = product.value.countReview else {
                return 0
            }
            return countReview
        }
        
        let productLabels = productDriver.map { product -> [SearchProductLabel] in
            if let productLabels = product.value.labels, productLabels.count > 0 {
                return productLabels
            } else {
                return []
            }
        }
        
        let productTopLabels = productDriver.map { product -> [UIButton] in
            if let productLabels = product.value.topLabels, productLabels.count > 0 {
                return productLabels.map({ label -> UIButton in
                    let holderButton = UIButton(frame: .zero)
                    holderButton.setTitle(label, for: .normal)
                    holderButton.isUserInteractionEnabled = false
                    holderButton.layer.cornerRadius = 10
                    holderButton.layer.masksToBounds = true
                    holderButton.layer.borderWidth = 1
                    holderButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    holderButton.layer.borderColor = #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)
                    holderButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.38), for: .normal)
                    holderButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                    holderButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
                    holderButton.sizeToFit()
                    return holderButton
                })
            } else {
                return []
            }
        }
        
        let productBottomLabels = productDriver.map { product -> [UIButton] in
            if let productLabels = product.value.bottomLabels, productLabels.count > 0 {
                return productLabels.map({ label -> UIButton in
                    let holderButton = UIButton(frame: .zero)
                    holderButton.setTitle(label, for: .normal)
                    holderButton.isUserInteractionEnabled = false
                    holderButton.layer.cornerRadius = 10
                    holderButton.layer.masksToBounds = true
                    holderButton.layer.borderWidth = 1
                    holderButton.backgroundColor = #colorLiteral(red: 0.8549019608, green: 0.9607843137, blue: 0.8588235294, alpha: 1)
                    holderButton.layer.borderColor = #colorLiteral(red: 0.8549019608, green: 0.9607843137, blue: 0.8588235294, alpha: 1)
                    holderButton.setTitleColor(#colorLiteral(red: 0.2588235294, green: 0.7098039216, blue: 0.2862745098, alpha: 1), for: .normal)
                    holderButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                    holderButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
                    holderButton.sizeToFit()
                    return holderButton
                })
            } else {
                return []
            }
        }
        
        let productShopName = productDriver.map { product -> String in
            guard let shop = product.value.shop, let name = shop.name else {
                return ""
            }
            return name
        }
        
        let productShopCity = productDriver.map { product -> String in
            guard let shop = product.value.shop, let city = shop.city else {
                return ""
            }
            guard let badges = product.value.badges else {
                return city
            }
            let activeBadges = badges.filter { $0.isShowing }
            if !activeBadges.isEmpty {
                return String(format: " • %@", city)
            }
            return city
        }
        
        let productBadges = productDriver.map { product -> [String] in
            if let badges = product.value.badges, badges.count > 0 {
                let urls = badges
                    .filter { $0.isShowing }
                    .map {
                        return $0.imageURL ?? ""
                }
                
                return urls
            } else {
                return []
            }
        }
        
        return Output(productImage: productImage,
                      productName: productName,
                      productPrice: productPrice,
                      productRating: productRating,
                      productCountReview: productCountReview,
                      productLabels: productLabels,
                      productTopLabels: productTopLabels,
                      productBottomLabels: productBottomLabels,
                      productShopName: productShopName,
                      productShopCity: productShopCity,
                      productBadges: productBadges)
    }
}
