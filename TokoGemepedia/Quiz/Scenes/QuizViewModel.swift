//
//  QuizViewModel.swift
//  TokoGemepedia
//
//  Created by Digital Khrisna on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import RxCocoa
import RxSwift

internal class QuizViewModel {
    internal struct Input {
        internal let didLoad: Driver<Void>
        internal let didSelectOption: Driver<Int>
    }
    
    internal struct Output {
        internal let question: Driver<String>
        internal let firstOption: Driver<String>
        internal let secondOption: Driver<String>
        internal let thirdOption: Driver<String>
        internal let fourthOption: Driver<String>
        internal let fifthOption: Driver<String>
        internal let redirectToResultPage: Driver<(keywords: [String], result: ResultArray)>
    }
    
    private let quiz: Quize
    internal init(quiz: Quize) {
        self.quiz = quiz
    }
    
    internal func transform(input: Input) -> Output {
        var questions = quiz.questions
        var currentQuestion: Question?
        var currentQuestionIndex = 0
        var currentScore = 0
        var currentKeywords: [String] = []
        let shouldRedirectToResult: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        
        let questionOnLoad = input
            .didLoad
            .flatMap ({ _ -> Driver<Question> in
                guard currentQuestionIndex < questions.count else { return .empty() }
                return Driver.just(questions[currentQuestionIndex])
            })

        let questionOnSelectOption = input
            .didSelectOption
            .flatMap ({ (selectedIndex: Int) -> Driver<Question> in
                guard let ques = currentQuestion else { return .empty() }
                currentScore += ques.options[selectedIndex].value
                ques.options[selectedIndex].keyword.forEach({ (val: String) in currentKeywords.append(val) })
                if currentQuestionIndex == questions.count {
                    shouldRedirectToResult.accept(true)
                    return Driver.empty()
                }
                
                return Driver.just(questions[currentQuestionIndex])
            })
        
        let nextQuestionResult = Driver
            .merge(questionOnLoad, questionOnSelectOption)
            .do(onNext: { (que: Question) in
                currentQuestionIndex += 1
                currentQuestion = que
            })
        
        let question = nextQuestionResult
            .map ({ (que: Question) -> String in
                return que.name
            })
        
        let firstOption = nextQuestionResult
            .map ({ (que: Question) -> String in
                return que.options[0].answer
            })
        
        let secondOption = nextQuestionResult
            .map ({ (que: Question) -> String in
                return que.options[1].answer
            })
        
        let thirdOption = nextQuestionResult
            .map ({ (que: Question) -> String in
                return que.options[2].answer
            })
        
        let fourthOption = nextQuestionResult
            .map ({ (que: Question) -> String in
                return que.options[3].answer
            })
        
        let fifthOption = nextQuestionResult
            .map ({ (que: Question) -> String in
                return que.options[4].answer
            })
        
        let redirectToResultPage = shouldRedirectToResult
            .filter { $0 }
            .flatMap ({ [weak self] _ -> Driver<(keywords: [String], result: ResultArray)> in
                guard let `self` = self else { return .empty() }
                guard let findResult = self.quiz.resultArray.first(where: { (result: ResultArray) -> Bool in
                    return currentScore > result.min && currentScore <= result.max
                }) else { return .empty() }
                return Driver.just((keywords: currentKeywords, result: findResult))
            })
        
        return Output(question: question.asDriver(),
                      firstOption: firstOption.asDriver(),
                      secondOption: secondOption.asDriver(),
                      thirdOption: thirdOption.asDriver(),
                      fourthOption: fourthOption.asDriver(),
                      fifthOption: fifthOption.asDriver(),
                      redirectToResultPage: redirectToResultPage.asDriverOnErrorJustComplete())
    }
}

extension ObservableType {
    
    public func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }
    
    public func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { error in
            return Driver.empty()
        }
    }
    
    public func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}
