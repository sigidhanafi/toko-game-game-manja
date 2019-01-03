//
//  SearchProductWholesale.swift
//  Tokopedia
//
//  Created by Digital Khrisna on 26/04/18.
//  Copyright © 2018 TOKOPEDIA. All rights reserved.
//

import SwiftyJSON

public struct SearchProductWholesale {
    public var price: Int?
    public var quantityMin: Int?
    public var quantityMax: Int?
    
    public init() {}
    
    public init(json: JSON) {
        self.price = json["price"].int
        self.quantityMin = json["quantity_min"].int
        self.quantityMax = json["quantity_max"].int
    }
}
