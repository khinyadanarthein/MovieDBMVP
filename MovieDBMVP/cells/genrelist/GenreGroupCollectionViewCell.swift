//
//  GenreGroupCollectionViewCell.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 02/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class GenreGroupCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cvGenreTitle: UICollectionView!
    @IBOutlet weak var cvGenreList: UICollectionView!
    
    static var identifier : String {
        return "GenreGroupCollectionViewCell"
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cvGenreTitle.register(UINib(nibName: GenreTitleCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GenreTitleCollectionViewCell.identifier)
        
        cvGenreList.register(UINib(nibName: BestPopularCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BestPopularCollectionViewCell.identifier)
        
        cvGenreTitle.dataSource = self
        cvGenreList.dataSource = self
        cvGenreTitle.delegate = self
        cvGenreList.delegate = self
        
        cvGenreTitle.setCollectionViewLayout(generateCompositionalLayoutForTitle(), animated: false)
        cvGenreList.setCollectionViewLayout(generateCompositionalLayoutForList(), animated: false)
        
        cvGenreTitle.selectItem(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .left)
    }
    
    func generateCompositionalLayoutForTitle() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex : Int, layoutEnv : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            return self.sectionLayoutForGenreTitleView()
        }
    }
    
    func generateCompositionalLayoutForList() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex : Int, layoutEnv : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            return self.sectionLayoutForGenreSlideView()
        }
    }
    func sectionLayoutForGenreTitleView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.contentView.frame.width / 4), heightDimension: .absolute(45))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((self.contentView.frame.width / 3) - 30), heightDimension: .absolute(45))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        return section
    }
    
    func sectionLayoutForGenreSlideView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.contentView.frame.width / 2), heightDimension: .absolute(300))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((self.contentView.frame.width / 2) - 20), heightDimension: .absolute(300))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
}

extension GenreGroupCollectionViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cvGenreTitle {
            return 10
            
        } else {
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvGenreTitle {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreTitleCollectionViewCell.identifier, for: indexPath) as? GenreTitleCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if cell.isSelected {
                cell.viewSelectedColor.backgroundColor = UIColor(named: "tint-color")
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestPopularCollectionViewCell.identifier, for: indexPath) as? BestPopularCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        }
        //return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("select index \(indexPath.row)")
    }
    
}
