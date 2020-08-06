//
//  MainViewController.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

enum HomeSection : Int {
    case PagingVideo = 0
    case BestPopular = 1
    case ShowTime = 2
    case GenreGroup = 3
    case Showcase = 4
    case Actor = 5
}

class MainViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var items : [HomeSection] = [
        HomeSection.PagingVideo,
        HomeSection.BestPopular,
        HomeSection.ShowTime,
        HomeSection.GenreGroup
    ]
    
    var mDelegate : GenreTileDelegate!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainCollectionView.register(UINib(nibName: PagingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PagingCollectionViewCell.identifier)
        
        mainCollectionView.register(UINib(nibName: BestPopularCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BestPopularCollectionViewCell.identifier)
            
        mainCollectionView.register(UINib(nibName: ShowTimeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ShowTimeCollectionViewCell.identifier)
        
        mainCollectionView.register(UINib(nibName: GenreGroupCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GenreGroupCollectionViewCell.identifier)

//        mainCollectionView.register(UINib(nibName: BestPopularCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BestPopularCollectionViewCell.identifier)
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        
        mainCollectionView.setCollectionViewLayout(generateCompositionalLayout(), animated: false)
    }
    
    func generateCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionIndex : Int, layoutEnv : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            switch self.items[sectionIndex]{
                
            case HomeSection.PagingVideo:
                return self.sectionLayoutForPagingView()
                
            case HomeSection.BestPopular:
                return self.sectionLayoutForBestPopularView()

            case HomeSection.ShowTime:
                return self.sectionLayoutForShowTimeView()

            case HomeSection.GenreGroup :
                return self.sectionLayoutForGenreTitleView()
//
//            case HomeSection.GenreList :
//                return self.sectionLayoutForGenreTitleView()
            default:
                fatalError("Crash")
            }
        }
        
    }
    
    func sectionLayoutForPagingView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(255))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(255))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        //section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 35, leading: 0, bottom: 5, trailing: 0)
        
        return section
    }
    
    func sectionLayoutForBestPopularView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width/2), heightDimension: .absolute(350))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((self.view.frame.width/2) - 20), heightDimension: .absolute(350))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        return section
    }
    
    func sectionLayoutForShowTimeView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(170))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(170))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        //section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
        return section
    }
    
    func sectionLayoutForGenreTitleView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(350))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(350))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        return section
    }
    
    func sectionLayoutForGenreSlideView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width / 3), heightDimension: .absolute(300))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((self.view.frame.width / 3) - 30), heightDimension: .absolute(300))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
    
}

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            
        case HomeSection.PagingVideo.rawValue :
            return 1
            
        case HomeSection.BestPopular.rawValue :
            return 10
            
        case HomeSection.ShowTime.rawValue :
            return 1
            
        case HomeSection.GenreGroup.rawValue :
            return 1
            
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {

        case HomeSection.PagingVideo.rawValue:
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PagingCollectionViewCell.identifier, for: indexPath) as? PagingCollectionViewCell else {
              return UICollectionViewCell()
          }
          return cell
           
        case HomeSection.BestPopular.rawValue:
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestPopularCollectionViewCell.identifier, for: indexPath) as? BestPopularCollectionViewCell else {
              return UICollectionViewCell()
          }
          return cell
            
        case HomeSection.ShowTime.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowTimeCollectionViewCell.identifier, for: indexPath) as? ShowTimeCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
            
        case HomeSection.GenreGroup.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreGroupCollectionViewCell.identifier, for: indexPath) as? GenreGroupCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell

//        case NextSection.ForYou.rawValue:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookPreviewInListCollectionViewCell.identifier, for: indexPath) as? BookPreviewInListCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            return cell
//
//        case NextSection.CuratedList.rawValue:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CuratedBooksCollectionViewCell.identifier, for: indexPath) as? CuratedBooksCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            return cell
            
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
}

extension MainViewController : UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        
    }
}
