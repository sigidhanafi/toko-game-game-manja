//
//  QuizResultUseCase.swift
//  TokoGemepedia
//
//  Created by Digital Khrisna on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import RxCocoa
import RxSwift
import SwiftyJSON
import Moya

protocol DefaultQuizResultUseCase {
    func recommendationProduct(query: String) -> Observable<[SearchResultProduct]>
}

class QuizResultUseCase: DefaultQuizResultUseCase {
    func recommendationProduct(query: String) -> Observable<[SearchResultProduct]> {
        let provider = MoyaProvider<AceTarget>()
        return provider
            .rx
            .request(AceTarget.getProduct(query: query))
            .asObservable()
            .flatMap({ (response: Response) -> Observable<[SearchResultProduct]> in
                let responseJSON = JSON(response.data)
                let results = responseJSON["data"]["products"].arrayValue.map { return SearchResultProduct(json: $0) }
                return Observable.just(results)
            })
    }
}
