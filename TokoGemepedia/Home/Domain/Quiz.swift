//
//  Quiz.swift
//  TokoGemepedia
//
//  Created by Nakama on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Quiz {
    var name: String
    var image: String
    var description: String
    
    init(name: String, image: String, description: String) {
        self.name = name
        self.image = image
        self.description = description
    }
}
