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
    
    private let disposeBag = DisposeBag()
    private let viewModel: QuizResultViewModel
    private let result: ResultArray
    private var items: [SearchResultProduct] = []
    private var adsItems: [SearchResultProduct] = []
    
    internal init(result: ResultArray, keywords: [String], adsKeywords: [String]) {
        self.result = result
        self.viewModel = QuizResultViewModel(keywords: keywords, adsKeywords: adsKeywords, useCase: QuizResultUseCase())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        
        collectionView.register(UINib(nibName: "ProductResultCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductResultCollectionViewCell")
        collectionView.register(UINib(nibName: "AdsProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AdsProductCollectionViewCell")
        collectionView.register(UINib(nibName: "QuizResultCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "QuizResultCollectionReusableView")
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
        
        output
            .adsProduct
            .drive(onNext: { (products: [SearchResultProduct]) in
                products.forEach({ (result) in
                    self.adsItems.append(result)
                })
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension QuizResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "QuizResultCollectionReusableView", for: indexPath) as! QuizResultCollectionReusableView
        if indexPath.section == 0 {
            cell.titleLabel.text = result.result
        } else {
            cell.titleLabel.text = "Hasil yang berkaitan dengan pribadimu"
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdsProductCollectionViewCell", for: indexPath) as! AdsProductCollectionViewCell
            
            cell.adsItems = adsItems
            cell.collectionView.reloadData()
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductResultCollectionViewCell", for: indexPath) as! ProductResultCollectionViewCell
            
            let item = items[indexPath.row]
            let cellVM = ProductResultCellViewModel(with: item)
            cell.bind(cellVM)
            
            return cell
        }
    }
}

extension QuizResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width: CGFloat = (UIScreen.main.bounds.size.width / 2) - 8
            let height: CGFloat = width + 110
            return CGSize(width: UIScreen.main.bounds.size.width, height: height)
        } else {
            let width: CGFloat = (UIScreen.main.bounds.size.width / 2) - 8
            let height: CGFloat = width + 110
            
            return CGSize(width: width, height: height)
        }
    }
}
