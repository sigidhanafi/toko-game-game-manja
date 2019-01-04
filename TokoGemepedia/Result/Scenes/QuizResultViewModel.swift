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
        public let adsProduct: Driver<[SearchResultProduct]>
    }
    
    private let useCase: DefaultQuizResultUseCase
    private let keywords: [String]
    private let adsKeywords: [String]
    
    internal init(keywords: [String], adsKeywords: [String], useCase: DefaultQuizResultUseCase) {
        self.keywords = keywords
        self.adsKeywords = adsKeywords
        self.useCase = useCase
    }
    
    internal func transform(input: Input) -> Output {
        
        let adsProduct = input
            .didLoad
            .flatMap { [adsKeywords, useCase] _ -> Driver<[SearchResultProduct]> in
                let products = adsKeywords.map ({ (value) -> Driver<[SearchResultProduct]> in
                    return useCase
                        .recommendationProduct(query: value)
                        .asDriver(onErrorJustReturn: [])
                })
                
                return Driver.merge(products)
        }
        
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
        
        return Output(recommendationProduct: recommendationProduct,
                      adsProduct: adsProduct)
    }
}
