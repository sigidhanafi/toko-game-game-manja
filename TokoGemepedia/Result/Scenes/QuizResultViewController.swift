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

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var resultLabel: UILabel!
    private let disposeBag = DisposeBag()
    private let viewModel: QuizResultViewModel
    private let result: ResultArray
    private var items: [SearchResultProduct] = []
    
    internal init(result: ResultArray, keywords: [String]) {
        self.result = result
        self.viewModel = QuizResultViewModel(keywords: keywords, useCase: QuizResultUseCase())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        collectionView.register(UINib(nibName: "ProductResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductResultCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func bindViewModel() {
        let input = QuizResultViewModel.Input(didLoad: Driver.just(()))
        let output = viewModel.transform(input: input)
        
        output
            .recommendationProduct
            .drive(onNext: { (products: [SearchResultProduct]) in
                products.forEach({ (result) in
                    self.items.append(result)
                })
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        resultLabel.text = result.result
    }
}

extension QuizResultViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductResultCollectionViewCell", for: indexPath) as! ProductResultCollectionViewCell
        
        let item = items[indexPath.row]
        let cellVM = ProductResultCellViewModel(with: item)
        cell.bind(cellVM)
        
        return cell
    }
}

extension QuizResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.size.width / 2) - 8
        let height: CGFloat = width + 110
        
        return CGSize(width: width, height: height)
    }
}
