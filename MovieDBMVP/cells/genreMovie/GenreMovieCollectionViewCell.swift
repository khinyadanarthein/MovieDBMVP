//
//  GenreMovieCollectionViewCell.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 06/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class GenreMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieCellView: MovieCellView!
    
    static var identifier : String {
        return "GenreMovieCollectionViewCell"
    }
    
    var mData:GenreMovieVO? = nil {
        didSet{
            if let data = mData{
                self.bindData(data: data)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieCellView.viewRatingStar.settings.updateOnTouch = false
        movieCellView.viewRatingStar.settings.fillMode = .precise
        
    }
    
    fileprivate func bindData(data:GenreMovieVO){
        
        //set data
        movieCellView.lbMovieName.text = data.originalTitle
        movieCellView.lbRatingValue.text = "\( data.voteAverage)"
        movieCellView.viewRatingStar.rating = data.voteAverage/2
        
        if data.voteCount < 8000 {
            movieCellView.viewTop.isHidden = true
        } else {
            movieCellView.viewTop.isHidden = false
        }
        
        let imageURL = IMAGE_URL_PATH + (data.posterPath ?? "")
        let url = URL(string: imageURL)
        movieCellView.backImageView.kf.indicatorType = .activity
        movieCellView.backImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "netflix-logo"),
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
                //print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("upcoming Job failed: \(error.localizedDescription)")
            }
        }
    }

}
