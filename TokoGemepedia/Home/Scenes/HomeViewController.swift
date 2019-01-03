//
//  ViewController.swift
//  TokoGemepedia
//
//  Created by Nakama on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var items: [Quiz] = [
        Quiz(name: "Quiz 1", image: "capten-america", description: "wall e description"),
        Quiz(name: "Quiz 2", image: "capten-america", description: "wall e description"),
        Quiz(name: "Quiz 3", image: "capten-america", description: "wall e description"),
        Quiz(name: "Quiz 4", image: "capten-america", description: "wall e description"),
        Quiz(name: "Quiz 5", image: "capten-america", description: "wall e description")
    ]
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        let imageView = UIImageView(image: #imageLiteral(resourceName: "background"))
        collectionView.backgroundView = imageView
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        let quiz = items[indexPath.row]
        cell.imageView.image = UIImage(named: quiz.image)
        cell.quizTitleLabel.text = quiz.name
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width - 32, height: 400)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}
