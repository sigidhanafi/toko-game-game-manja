//
//  AceTarget.swift
//  TokoGemepedia
//
//  Created by Digital Khrisna on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import Moya

public enum AceTarget {
    case getProduct(query: String)
}

extension AceTarget: TargetType {
    public var baseURL: URL { return URL(string: "https://ace.tokopedia.com")! }
    
    public var path: String {
        switch self {
        case .getProduct:
            return "/search/product/v3"
        }
    }
    
    public var parameters: [String: Any]? {
        switch self {
        case let .getProduct(query):
            return [
                "q": query,
                "source": "search",
                "start": 0,
                "rows": 3,
                "unique_id": "0",
                "device": "ios"
            ]
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding.default)
    }
    
    public var validationType: ValidationType {
        return .none
    }
    public var sampleData: Data {
        return "{ \"data\": 123 }".data(using: .utf8)!
    }
    
    public var headers: [String: String]? {
        return [ "Authorization" : "team3rdpartyanvato123OK!001" ]
    }
}
