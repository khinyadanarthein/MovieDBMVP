//
//  PagingCollectionViewCell.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class PagingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cvSlideVideo: UICollectionView!
    @IBOutlet weak var slideIndex: UIPageControl!
    
    static var identifier : String {
        return "PagingCollectionViewCell"
    }
    var currentPage = 0
    
    var dummeyItemCount = 5
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.slideIndex.numberOfPages = dummeyItemCount
        
        cvSlideVideo.register(UINib(nibName: SlideVideoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SlideVideoCollectionViewCell.identifier)
        cvSlideVideo.dataSource = self
        cvSlideVideo.delegate = self
        cvSlideVideo.setCollectionViewLayout(generateCompositionalLayout(), animated: false)
    }
    
    func generateCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex : Int, layoutEnv : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            return self.sectionLayoutForSlideView()
        }
        
    }
    
    func sectionLayoutForSlideView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.contentView.frame.width), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.contentView.frame.width), heightDimension: .fractionalHeight(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        //section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
        section.visibleItemsInvalidationHandler = { (visibleItems, point, env) -> Void in
            //            print(visibleItems.last?.indexPath.row)
            self.slideIndex.currentPage = visibleItems.last?.indexPath.row ?? 0
            
        }
        return section
    }
    
}

extension PagingCollectionViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummeyItemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideVideoCollectionViewCell.identifier, for: indexPath) as? SlideVideoCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    
}

