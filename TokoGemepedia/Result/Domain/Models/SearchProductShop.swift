//
//  SearchProductShop.swift
//  Tokopedia
//
//  Created by Digital Khrisna on 26/04/18.
//  Copyright © 2018 TOKOPEDIA. All rights reserved.
//

import SwiftyJSON

public struct SearchProductShop {
    public var location: String?
    public var city: String?
    public var clover: String?
    public var shopId: String?
    public var isOfficial: Bool = false
    public var isGold: Bool = false
    public var reputation: String?
    public var name: String?
    public var url: String?

    public init() {}
    
    public init(json: JSON) {
        self.location = json["location"].string
        self.city = json["city"].string
        self.clover = json["clover"].string
        self.shopId = json["id"].stringValue
        self.isOfficial = json["is_official"].boolValue
        self.isGold = json["is_gold"].boolValue
        self.reputation = json["reputation"].string
        self.name = json["name"].string
        self.url = json["url"].string
    }
}
