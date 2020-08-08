//
//  DetailViewController.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 07/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import Cosmos
import YouTubePlayer

class DetailViewController: UIViewController {

    @IBOutlet weak var ivBack: UIImageView!
    @IBOutlet weak var ivSearch: UIImageView!
    @IBOutlet weak var ivPosterImage: UIImageView!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var comosRatingStar: CosmosView!
    @IBOutlet weak var lbVoteCount: UILabel!
    @IBOutlet weak var lbRatingValue: UILabel!
    @IBOutlet weak var lbRunTime: UILabel!
    @IBOutlet weak var stackGenre: UIStackView!
    @IBOutlet weak var ivFavHeart: UIImageView!
    @IBOutlet weak var lbStoryLine: UILabel!
    @IBOutlet weak var btnPlayTrailer: DetailButton!
    @IBOutlet weak var btnRateMovie: DetailButton!
    @IBOutlet weak var trailerView: YouTubePlayerView!
    @IBOutlet weak var trailerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cvMovieCasts: UICollectionView!
    @IBOutlet weak var lbOriginalTitle: UILabel!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var lbProduction: UILabel!
    @IBOutlet weak var lbPremiereDate: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var cvMovieCrews: UICollectionView!
    
    var id : Int!
    var movie : MovieDetailVO?
    
    var mPresenter : DetailPresenter = DetailPresenterImpl()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initIndicator()
        initDataObservationMVP()
        registerView()
        
    }
    
    fileprivate func initIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    fileprivate func initDataObservationMVP() {
        mPresenter.attachView(view: self)
        mPresenter.onUIReady(movieId: self.movie!.id)
        self.bindData(movie: self.movie!)
    }
    
    fileprivate func bindData(movie : MovieDetailVO) {
        
        //let data = RealmHelper.shared.getMovieDetailById(id: self.id)
        
        //if let movie = data {
        
        let imageURL = IMAGE_URL_PATH + movie.posterPath
        let url = URL(string: imageURL)
        
        ivPosterImage.kf.indicatorType = .activity
        ivPosterImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.flipFromLeft(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                _ = value.source.url
            case .failure(let error):
                print("Detail Job failed: \(error.localizedDescription)")
            }
        }
        
        self.lbYear.text = String(movie.releaseDate.prefix(4))
        self.lbMovieTitle.text = movie.title
        self.comosRatingStar.rating = movie.voteAverage/2
        self.lbVoteCount.text = "\(movie.voteCount) VOTES"
        self.lbRatingValue.text = "\(movie.voteAverage)"
        self.lbDescription.text = movie.overview
        self.lbStoryLine.text = movie.overview
        
        if  movie.runtime != 0 {
            let runtime = CommonUtils.shared.minutesToHoursMinutes(minutes: movie.runtime)
            self.lbRunTime.text = "\(runtime.hours)hr \(runtime.leftMinutes)min"
            
        } else {
            self.lbRunTime.text = ""
        }
        self.lbOriginalTitle.text = movie.originalTitle
        
        for type in movie.genres {
            // for type label
            self.lbType.text! += type.name + ", "
            
            // for view
            let labelGenre = UILabel()
            labelGenre.text = type.name
            labelGenre.font = UIFont.boldSystemFont(ofSize: 13)
            labelGenre.textAlignment = .center
            labelGenre.textColor = UIColor.white
            labelGenre.backgroundColor = UIColor.darkGray
            labelGenre.layer.masksToBounds = true
            labelGenre.layer.cornerRadius = 10
            stackGenre.addArrangedSubview(labelGenre)
        }
        if movie.genres.count > 0 {
            self.lbType.text?.removeLast()
        }
        self.lbPremiereDate.text = movie.releaseDate
        if movie.productionCompanies.count > 0 {
            self.lbProduction.text = movie.productionCompanies[0].name
        } else {
            self.lbProduction.text = "-"
        }
    }
    
    func registerView() {
        
        comosRatingStar.settings.fillMode = .precise
        comosRatingStar.settings.updateOnTouch = false
        ivBack.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeTapped(tapGestureRecognizer:))))
        
        cvMovieCasts.register(UINib(nibName: MovieCastCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCastCollectionViewCell.identifier)
        
        cvMovieCasts.dataSource = self
        cvMovieCasts.delegate = self
        
        cvMovieCrews.register(UINib(nibName: MovieCrewCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MovieCrewCollectionViewCell.identifier)
        
        cvMovieCrews.dataSource = self
        cvMovieCrews.delegate = self
        
    }
    
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        mPresenter.deattachView()
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func onTapTrailerBtn(_ sender: Any) {
        mPresenter.getMovieVideo(movieId: self.movie?.id ?? 0)
    }
    @IBAction func onTapRateMovieBtn(_ sender: Any) {
    }
}

extension DetailViewController : DetailView {
    func showLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    func showErrorMessage(title: String, err: String) {
        debugPrint(err)
        let alert = UIAlertController(title: title, message: err, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMovieDetail(data: MovieDetailVO) {
        self.mPresenter.movieDetail = data
        bindData(movie: data)
    }
    
    func ratedMovie(message: String) {
        
    }
    
    func addFavoriteMovie(message: String) {
        
    }
    
    func reloadCastList() {
        self.cvMovieCasts.reloadData()
    }
    
    func reloadCrewList() {
        self.cvMovieCrews.reloadData()
    }
    
    func playVideo(data: MovieVideoDetailVO) {
        trailerViewHeightConstraint.constant = 150
        print(data.key ?? "")
        self.trailerView.loadVideoID(data.key ?? "")
        self.trailerView.delegate = self
    }
    
    
}

extension DetailViewController : YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        self.trailerView.play()
    }
}

extension DetailViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == cvMovieCasts {
            return self.mPresenter.movieCastList.count
        }
        return self.mPresenter.movieCrewList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == cvMovieCasts {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastCollectionViewCell.identifier, for: indexPath) as? MovieCastCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.mData = self.mPresenter.movieCastList[indexPath.row]
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCrewCollectionViewCell.identifier, for: indexPath) as? MovieCrewCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.mData = self.mPresenter.movieCrewList[indexPath.row]
        return cell
    }
    
}
extension DetailViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cvMovieCasts {
            return CGSize(width: 170, height: 200)
        }
        return CGSize(width: 150, height: 200)
    }

}
