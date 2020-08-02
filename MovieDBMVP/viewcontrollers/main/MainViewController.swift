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
    case GenreTitle = 3
    case Showcase = 4
    case Actor = 5
}

class MainViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var items : [HomeSection] = [
        HomeSection.PagingVideo,
        HomeSection.BestPopular,
        HomeSection.ShowTime,
        HomeSection.GenreTitle
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainCollectionView.register(UINib(nibName: PagingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PagingCollectionViewCell.identifier)
        
        mainCollectionView.register(UINib(nibName: BestPopularCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BestPopularCollectionViewCell.identifier)
            
        mainCollectionView.register(UINib(nibName: ShowTimeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ShowTimeCollectionViewCell.identifier)
        
        mainCollectionView.register(UINib(nibName: GenreTitleCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GenreTitleCollectionViewCell.identifier)

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

            case HomeSection.GenreTitle :
                return self.sectionLayoutForGenreTitleView()
            default:
                fatalError("Crash")
            }
        }
        
    }
    
    func sectionLayoutForPagingView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(235))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(235))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        //section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width / 4), heightDimension: .absolute(35))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((self.view.frame.width / 4) - 40), heightDimension: .absolute(35))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
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
            
        case HomeSection.GenreTitle.rawValue :
            return 10
            
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
//        case HomeSection.SlideVideo.rawValue:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideVideoCollectionViewCell.identifier, for: indexPath) as? SlideVideoCollectionViewCell else {
//                return UICollectionViewCell()
//            }
//            return cell
           
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
            
        case HomeSection.GenreTitle.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreTitleCollectionViewCell.identifier, for: indexPath) as? GenreTitleCollectionViewCell else {
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
    
}
