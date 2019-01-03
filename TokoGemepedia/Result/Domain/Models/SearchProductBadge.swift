//
//  SearchProductBadge.swift
//  Tokopedia
//
//  Created by Digital Khrisna on 26/04/18.
//  Copyright © 2018 TOKOPEDIA. All rights reserved.
//

import SwiftyJSON

public struct SearchProductBadge {
    public var title: String?
    public var imageURL: String?
    public var isShowing: Bool = false
    
    public init() {}
    
    public init(json: JSON) {
        self.title = json["title"].string
        self.imageURL = json["image_url"].string
        self.isShowing = json["show"].boolValue
    }
}
