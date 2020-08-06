//
//  MainViewController.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import RxSwift

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
        HomeSection.GenreGroup,
        HomeSection.Showcase,
        HomeSection.Actor
    ]
    
    
    let bag = DisposeBag()
    var mPresenter : MainPresenter = MainPresenterImpl()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initIndicator()
        initView()
        initDataObservationMVP()
        
    }
    
    fileprivate func initIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    fileprivate func initDataObservationMVP() {
        mPresenter.attachView(view: self)
        mPresenter.onUIReady()
    }
    
    private func initView() {

      mainCollectionView.register(UINib(nibName: PagingCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PagingCollectionViewCell.identifier)
      
      mainCollectionView.register(UINib(nibName: BestPopularCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BestPopularCollectionViewCell.identifier)
          
      mainCollectionView.register(UINib(nibName: ShowTimeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ShowTimeCollectionViewCell.identifier)
      
      mainCollectionView.register(UINib(nibName: GenreGroupCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GenreGroupCollectionViewCell.identifier)
      
      mainCollectionView.register(UINib(nibName: SlideVideoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SlideVideoCollectionViewCell.identifier)
      
      mainCollectionView.register(UINib(nibName: PersonCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PersonCollectionViewCell.identifier)
      
      mainCollectionView.register(UINib(nibName: TitleCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleCollectionReusableView.identifier)
      
      mainCollectionView.dataSource = self
      mainCollectionView.delegate = self
      
      mainCollectionView.setCollectionViewLayout(generateCompositionalLayout(), animated: false)
    }
}

extension MainViewController : MainPageView {
    
    func showLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    func showErrorMessage(err: String) {
        let alert = UIAlertController(title: "Loading Error", message: err, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMovieSlides(data: [MainVideoVO]) {
        self.mPresenter.movieSlides = data
        self.mainCollectionView.reloadData()
    }
    
    func loadMovieVideo(data: [MovieVideoDetailVO]) {
        self.mainCollectionView.reloadData()
    }
    
    func showBestMovieList(data: [BestMovieVO]) {
        self.mainCollectionView.reloadData()
    }
    
    func showGenreList(data: [GenreVO]) {
        self.mainCollectionView.reloadData()
    }
    func loadingCollectionData() {
        self.mainCollectionView.reloadData()
    }
}

extension MainViewController {
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
                
            case HomeSection.Showcase :
                return self.sectionLayoutForVideoSlideView()

            case HomeSection.Actor :
                return self.sectionLayoutForActorView()
            
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(170), heightDimension: .absolute(300))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150), heightDimension: .absolute(300))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        var section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        //Header
        section = addHeaderSection(section: section)
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
    
    func sectionLayoutForVideoSlideView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(200))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(200))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        var section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        //section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0)
        
        section = addHeaderSection(section: section)
        return section
    }
    
    func sectionLayoutForActorView() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width/2.2), heightDimension: .absolute(200))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute((self.view.frame.width/2.2) - 20), heightDimension: .absolute(200))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        //group.interItemSpacing = NSCollectionLayoutSpacing.fixed(10)
        
        var section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        //Header
        section = addHeaderSection(section: section)
        return section
    }
    
    func addHeaderSection (section : NSCollectionLayoutSection) -> NSCollectionLayoutSection{
        
        //Header
        let headerSize = NSCollectionLayoutSize(widthDimension: .absolute(self.view.frame.width), heightDimension: .absolute(50))
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }
    
}

extension MainViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleCollectionReusableView.identifier, for: indexPath) as? TitleCollectionReusableView {
            
            switch indexPath.section {
            case HomeSection.BestPopular.rawValue:
                cell.lbTitleName.text = "BEST POPULAR FILMS AND SERIALS"
                cell.lbSeeMore.isHidden = true
            
            case HomeSection.Showcase.rawValue:
                cell.mainView.backgroundColor = UIColor(named: "fill-color")
                cell.lbTitleName.text = "SHOWCASES"
                cell.lbSeeMore.text = "MORE SHOWCASES"
                cell.lbSeeMore.isHidden = false
                
            case HomeSection.Actor.rawValue:
                cell.lbTitleName.text = "BEST ACTORS"
                cell.lbSeeMore.text = "MORE ACTORS"
                cell.lbSeeMore.isHidden = false
                
            default:
                return cell
            }
            
            return cell
        }
      
        return UICollectionReusableView()
        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            
        case HomeSection.PagingVideo.rawValue :
            return mPresenter.movieSlides.count
            
        case HomeSection.BestPopular.rawValue :
            return mPresenter.bestMovieList.count
            
        case HomeSection.ShowTime.rawValue :
            return 1
            
        case HomeSection.GenreGroup.rawValue :
            return 1
            
        case HomeSection.Showcase.rawValue :
            return 10
            
        case HomeSection.Actor.rawValue :
            return 10
            
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
          cell.slideVideoList = mPresenter.movieSlides
          //cell.movieVideo = mPresenter.movieVideo
          cell.mDelegate = self
          return cell
           
        case HomeSection.BestPopular.rawValue:
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestPopularCollectionViewCell.identifier, for: indexPath) as? BestPopularCollectionViewCell else {
              return UICollectionViewCell()
          }
          cell.mData = mPresenter.bestMovieList[indexPath.row]
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
            cell.genreList = mPresenter.genreList
            print("genre list \(mPresenter.genreList.count)")
            return cell
            
        case HomeSection.Showcase.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SlideVideoCollectionViewCell.identifier, for: indexPath) as? SlideVideoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = UIColor(named: "fill-color")
            return cell
            
        case HomeSection.Actor.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.identifier, for: indexPath) as? PersonCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell

        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
}

extension MainViewController : VideoPlayDelegate {
    func onTapPlayButton(movieId: Int) {
        mPresenter.getMovieVideo(movieId: movieId)
    }
    
}

extension MainViewController : UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       
        
    }
}
