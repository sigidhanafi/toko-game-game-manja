//
//  SearchProductLabel.swift
//  Tokopedia
//
//  Created by Digital Khrisna on 26/04/18.
//  Copyright © 2018 TOKOPEDIA. All rights reserved.
//

import SwiftyJSON

public struct SearchProductLabel {
    public var title: String?
    public var color: String?
    
    public init() {}
    
    public init(json: JSON) {
        self.title = json["title"].string
        self.color = json["color"].string
    }
}
