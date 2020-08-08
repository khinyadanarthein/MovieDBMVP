//
//  GenreTitleCollectionViewCell.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class GenreTitleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var viewSelectedColor: UIView!
    //@IBOutlet weak var cvGenreList: UICollectionView!
    
    static var identifier : String {
        return "GenreTitleCollectionViewCell"
    }
    var selectTitle : Int!
    
    var mData:GenreVO? = nil {
        didSet{
            if let data = mData{
                self.bindData(data: data)
            }
        }
    }
    
    fileprivate func bindData(data:GenreVO){
        
        //set data
        lbTitle.text = data.name
        if selectTitle == data.id {
            lbTitle.textColor = .white
            viewSelectedColor.backgroundColor = UIColor(named: "tint-color")
            
        } else {
            lbTitle.textColor = .darkGray
            viewSelectedColor.backgroundColor = UIColor(named: "primary-color")
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    
//        cvGenreList.register(UINib(nibName: BestPopularCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BestPopularCollectionViewCell.identifier)
//        cvGenreList.dataSource = self
//        cvGenreList.delegate = self
//        cvGenreList.setCollectionViewLayout(generateCompositionalLayout(), animated: false)
    }
//
//    func generateCompositionalLayout() -> UICollectionViewCompositionalLayout {
//
//        return UICollectionViewCompositionalLayout { (sectionIndex : Int, layoutEnv : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//            return self.sectionLayoutForSlideView()
//        }
//
//    }
//
//    func sectionLayoutForSlideView() -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.contentView.frame.width / 3), heightDimension: .absolute(300))
//
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((self.contentView.frame.width / 3) - 30), heightDimension: .absolute(300))
//
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//
//        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
//        section.interGroupSpacing = 10
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//
//        return section
//    }
//
//}
//
//extension GenreTitleCollectionViewCell : UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestPopularCollectionViewCell.identifier, for: indexPath) as? BestPopularCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//        return cell
//    }
//
//}
//extension GenreTitleCollectionViewCell : GenreTileDelegate {
//    func onTapTitle(id: Int) {
//        self.cvGenreList.reloadData()
//    }
}
