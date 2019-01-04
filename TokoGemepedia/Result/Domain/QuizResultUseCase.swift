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
    let provider = MoyaProvider<AceTarget>()

    func recommendationProduct(query: String) -> Observable<[SearchResultProduct]> {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return .empty() }
        return provider
            .rx
            .request(.getProduct(query: encodedQuery))
            .asObservable()
            .flatMap({ (response: Response) -> Observable<[SearchResultProduct]> in
                let responseJSON = JSON(response.data)
                let results = responseJSON["data"]["products"].arrayValue.map { return SearchResultProduct(json: $0) }
                return Observable.just(results)
            })
    }
}
