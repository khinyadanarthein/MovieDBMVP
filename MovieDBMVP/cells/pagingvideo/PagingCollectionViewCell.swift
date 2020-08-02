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
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.contentView.frame.width), heightDimension: .absolute(255))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.contentView.frame.width), heightDimension: .absolute(255))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        //section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 35, leading: 0, bottom: 5, trailing: 0)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.row)
//        self.slideIndex.currentPage = indexPath.row
        print(currentPage)
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == self.cvSlideVideo { //Your scrollView outlet
//            let pageWidth = scrollView.frame.width
//            self.currentPage += Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
//            self.slideIndex.currentPage = currentPage
//            print("pageWidth \(pageWidth)")
//            print("x \(scrollView.contentOffset.x)")
//            print("width \(scrollView.frame.width)")
//            print(currentPage)
//
//        }
//
//    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        for cell in cvSlideVideo.visibleCells {
//            let indexPath = cvSlideVideo.indexPath(for: cell)
//            print("index \(indexPath?.row)")
//        }
//
        slideIndex.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        
        
        
    }
}

