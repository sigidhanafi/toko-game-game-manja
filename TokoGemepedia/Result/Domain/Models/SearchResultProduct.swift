//
//  SearchResultProduct.swift
//  Tokopedia
//
//  Created by Digital Khrisna on 26/04/18.
//  Copyright © 2018 TOKOPEDIA. All rights reserved.
//

import SwiftyJSON

public struct SearchResultProduct {
    public var productId: String?
    public var name: String?
    public var url: String?
    public var imageURL: String?
    public var imageURL700: String?
    public var price: String?
    public var condition: Int?
    public var departmentId: String?
    public var rating: Int = 0
    public var countReview: Int?
    public var originalPrice: String?
    public var discountExpired: String?
    public var discountPercentage: Int?
    public var isPreorder: Bool?
    public var badges: [SearchProductBadge]?
    public var wholesalePrice: [SearchProductWholesale]?
    public var labels: [SearchProductLabel]?
    public var topLabels: [String]?
    public var bottomLabels: [String]?
    public var shop: SearchProductShop?
    public var isOnWishlist: Bool = false
	public var categoryName: String?
	public var categoryID: String?
    
    // Analytics purpose
    public var positionProductPage: Int = 0
    
    // Top Ads Purpose
    public var productAdsClickURL: String?
    public var wishlistAdsClickURL: String?
    
    public init() {}
    
    public init(json: JSON) {
        self.productId = json["id"].stringValue
        self.name = json["name"].string
        self.url = json["url"].string
        self.imageURL = json["image_url"].string
        self.imageURL700 = json["image_url_700"].string
        self.price = json["price"].string
        self.condition = json["condition"].int
        self.departmentId = json["department_id"].string
        self.rating = json["rating"].intValue
        self.countReview = json["count_review"].int
        self.originalPrice = json["original_price"].string
        self.discountExpired = json["discount_expired"].string
        self.discountPercentage = json["discount_percentage"].int
        self.isPreorder = json["is_preorder"].bool
        self.shop = SearchProductShop(json: json["shop"])
		self.categoryName = json["category_name"].string
        let intCategoryID = json["category_id"].int ?? 0
		self.categoryID = "\(intCategoryID)"
        self.isOnWishlist = json["wishlist"].boolValue
    
        if let badgeData = json["badges"].array {
            self.badges = badgeData.map {
                return SearchProductBadge(json: $0)
            }
        }
        
        if let wholesalePriceData = json["wholesale_price"].array {
            self.wholesalePrice = wholesalePriceData.map {
                return SearchProductWholesale(json: $0)
            }
        }
        
        if let labelData = json["labels"].array {
            self.labels = labelData.map {
                return SearchProductLabel(json: $0)
            }
        }
        
        if let topLabelData = json["top_label"].array {
            self.topLabels = topLabelData.map {
                return $0.stringValue
            }
        }
        
        if let bottomLabelData = json["bottom_label"].array {
            self.bottomLabels = bottomLabelData.map {
                return $0.stringValue
            }
        }
    }
}
