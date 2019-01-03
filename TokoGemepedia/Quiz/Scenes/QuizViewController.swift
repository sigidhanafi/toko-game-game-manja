//
//  QuizViewController.swift
//  TokoGemepedia
//
//  Created by Digital Khrisna on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

internal class QuizViewController: UIViewController {

    @IBOutlet internal weak var questionLabel: UILabel!
    @IBOutlet internal weak var firstQuestionButton: UIButton!
    @IBOutlet internal weak var secondQuestionButton: UIButton!
    @IBOutlet internal weak var thirdQuestionButton: UIButton!
    @IBOutlet internal weak var fourthQuestionButton: UIButton!

    private let disposeBag = DisposeBag()
    private let viewModel: QuizViewModel
    private let selectedOption: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    internal init(quiz: Quize) {
        self.viewModel = QuizViewModel(quiz: quiz)
        super.init(nibName: nil, bundle: nil)
    }
    
    internal required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
        self.bindActionButton()
    }

    private func bindViewModel() {
        let input = QuizViewModel.Input(didLoad: Driver.just(()),
                                        didSelectOption: selectedOption.skip(1).asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)
        
        output.question.drive(questionLabel.rx.text).disposed(by: disposeBag)
        output.firstOption.drive(firstQuestionButton.rx.title()).disposed(by: disposeBag)
        output.secondOption.drive(secondQuestionButton.rx.title()).disposed(by: disposeBag)
        output.thirdOption.drive(thirdQuestionButton.rx.title()).disposed(by: disposeBag)
        output.fourthOption.drive(fourthQuestionButton.rx.title()).disposed(by: disposeBag)
        output
            .redirectToResultPage
            .drive(onNext: { (data: (keywords: [String], result: ResultArray)) in
                let vc = QuizResultViewController(result: data.result, keywords: data.keywords)
                self.navigationController?.pushViewController(vc, animated: true)
                self.navigationController?.viewControllers.removeAll(where: { $0 == self })
            })
            .disposed(by: disposeBag)
    }
    
    private func bindActionButton() {
        firstQuestionButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: { _ in
                self.selectedOption.accept(self.firstQuestionButton.tag)
            })
            .disposed(by: disposeBag)
        
        secondQuestionButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: { _ in
                self.selectedOption.accept(self.secondQuestionButton.tag)
            })
            .disposed(by: disposeBag)
        
        thirdQuestionButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: { _ in
                self.selectedOption.accept(self.thirdQuestionButton.tag)
            })
            .disposed(by: disposeBag)
        
        fourthQuestionButton
            .rx
            .tap
            .asDriver()
            .drive(onNext: { _ in
                self.selectedOption.accept(self.fourthQuestionButton.tag)
            })
            .disposed(by: disposeBag)
    }
}
