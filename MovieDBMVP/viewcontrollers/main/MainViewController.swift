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
      
      mainCollectionView.register(UINib(nibName: ShowCaseCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ShowCaseCollectionViewCell.identifier)
      
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
        self.mainCollectionView.reloadSections(IndexSet(integer: HomeSection.PagingVideo.rawValue))
    }
    
    func loadSlideVideo(data: MovieVideoDetailVO, index: Int) {
        self.mainCollectionView.reloadSections(IndexSet(integer: HomeSection.PagingVideo.rawValue))
    }
    
    func showBestMovieList(data: [BestMovieVO]) {
        self.mainCollectionView.reloadSections(IndexSet(integer: HomeSection.BestPopular.rawValue))
    }
    
    func showGenreList() {
        self.mainCollectionView.reloadSections(IndexSet(integer: HomeSection.GenreGroup.rawValue))
    }
    func loadingCollectionData() {
        //self.mainCollectionView.reloadData()
    }
    
    func showShowCaseList() {
        self.mainCollectionView.reloadSections(IndexSet(integer: HomeSection.Showcase.rawValue))
    }
    func showActorList(data: [MovieCastDetailVO]) {
        self.mPresenter.actorList = data
        self.mainCollectionView.reloadSections(IndexSet(integer: HomeSection.Actor.rawValue))
    }
    func loadShowcaseVideo(data: MovieVideoDetailVO, index: Int) {
        self.mainCollectionView.reloadItems(at: [IndexPath(row: index, section: HomeSection.Showcase.rawValue)])
        //mainCollectionView.reloadSections(Inds)
    }
    func navigateToMovieDetail(movie: MovieDetailVO) {
        self.navigateToDetail(movie: movie)
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
            return mPresenter.showcaseList.count
            
        case HomeSection.Actor.rawValue :
            return mPresenter.actorList.count
            
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
          cell.mDelegate = self
          if mPresenter.slidemMovieVideo.count > 0 {
            cell.updateIndex = mPresenter.updatedSlideIndex
            cell.videoDataList = mPresenter.slidemMovieVideo
            //cell.cvSlideVideo.reloadItems(at: [IndexPath(row: mPresenter.updatedSlideIndex, section: 0)])
            cell.cvSlideVideo.scrollToItem(at: IndexPath(row: mPresenter.updatedSlideIndex, section: 0), at: .centeredHorizontally, animated: false)
          }
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
            cell.movieList = mPresenter.genreMovieList
            cell.selectedTitle = mPresenter.selectedGenre
            cell.cvGenreList.reloadData()
            cell.cvGenreTitle.reloadData()
            cell.genreDelegate = self
            cell.detailDelegate = self
            return cell
            
        case HomeSection.Showcase.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShowCaseCollectionViewCell.identifier, for: indexPath) as? ShowCaseCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backgroundColor = UIColor(named: "fill-color")
            cell.mData = mPresenter.showcaseList[indexPath.row]
            cell.mDelegate = self
            cell.index = indexPath.row
            let id = mPresenter.showcaseList[indexPath.row].id
            for video in self.mPresenter.showcaseVideo {
                if video.key == id {
                    cell.videoData = video.value
                }
            }
            
            return cell
            
        case HomeSection.Actor.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.identifier, for: indexPath) as? PersonCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.mData = mPresenter.actorList[indexPath.row]
            //print("actor list \(mPresenter.actorList.count)")
            return cell

        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {

        case HomeSection.BestPopular.rawValue:
            self.mPresenter.onTapMovie(movieId: mPresenter.bestMovieList[indexPath.row].id)
            
        default:
            break
        }
    }
}

extension MainViewController : VideoPlayDelegate {
    func onTapPlayButton(movieId: Int, index : Int, section : Int) {
        mPresenter.getMovieVideo(movieId: movieId, index: index, section: section)
    }
    
}
extension MainViewController : GenreTileDelegate {
    func onTapTitle(id: Int) {
        mPresenter.getMovieByGenreId(genreId: id)
    }
}

extension MainViewController : MovieDetailDelegate {
    func onTapMovie(movieId: Int) {
        mPresenter.onTapMovie(movieId: movieId)
    }
}
