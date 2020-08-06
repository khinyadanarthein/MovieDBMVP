//
//  BestPopularCollectionViewCell.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import Cosmos

class BestPopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivBackImage: UIImageView!
    @IBOutlet weak var lbMovieName: UILabel!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var cosmosRatingValue: CosmosView!
    @IBOutlet weak var viewTop: UIView!
    
    
    static var identifier : String {
        return "BestPopularCollectionViewCell"
    }
    
    var mData:BestMovieVO? = nil {
        didSet{
            if let data = mData{
                self.bindData(data: data)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cosmosRatingValue.settings.updateOnTouch = false
        cosmosRatingValue.settings.fillMode = .precise
        
    }
    
    fileprivate func bindData(data:BestMovieVO){
        
        //set data
        lbMovieName.text = data.originalTitle
        lbRating.text = "\( data.voteAverage)"
        cosmosRatingValue.rating = data.voteAverage/2
        
        if data.voteCount < 8000 {
            self.viewTop.isHidden = true
        } else {
            self.viewTop.isHidden = false
        }
        
        let imageURL = IMAGE_URL_PATH + (data.posterPath ?? "")
        let url = URL(string: imageURL)
        ivBackImage.kf.indicatorType = .activity
        ivBackImage.kf.setImage(
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
