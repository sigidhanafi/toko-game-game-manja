//
//  QuizResultViewModel.swift
//  TokoGemepedia
//
//  Created by Digital Khrisna on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import RxCocoa
import RxSwift

internal class QuizResultViewModel {
    internal struct Input {
        public let didLoad: Driver<Void>
    }
    
    internal struct Output {
        public let recommendationProduct: Driver<[SearchResultProduct]>
    }
    
    private let useCase: DefaultQuizResultUseCase
    private let keywords: [String]
    
    internal init(keywords: [String], useCase: DefaultQuizResultUseCase) {
        self.keywords = keywords
        self.useCase = useCase
    }
    
    internal func transform(input: Input) -> Output {
        
        let recommendationProduct = input
            .didLoad
            .flatMap { [keywords, useCase] _ -> Driver<[SearchResultProduct]> in
                let products = keywords.map ({ (value) -> Driver<[SearchResultProduct]> in
                    return useCase
                        .recommendationProduct(query: value)
                        .asDriver(onErrorJustReturn: [])
                })
                
                return Driver.merge(products)
        }
        
        let cek = recommendationProduct.flatMap { (product) -> Driver<[SearchResultProduct]> in
            return Driver.just(product)
        }
        
        return Output(recommendationProduct: recommendationProduct)
    }
}
