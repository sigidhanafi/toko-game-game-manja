//
//  QuizResultViewController.swift
//  TokoGemepedia
//
//  Created by Digital Khrisna on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

internal class QuizResultViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let viewModel: QuizResultViewModel
    
    internal init(keywords: [String]) {
        self.viewModel = QuizResultViewModel(keywords: keywords, useCase: QuizResultUseCase())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = QuizResultViewModel.Input(didLoad: Driver.just(()))
        let output = viewModel.transform(input: input)
        
        output
            .recommendationProduct
            .drive(onNext: { (products: [SearchResultProduct]) in
                print(">>> \(products)")
            })
            .disposed(by: disposeBag)
    }
}
