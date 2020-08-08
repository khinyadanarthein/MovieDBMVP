//
//  MovieCastCollectionViewCell.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 08/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: ActorCellView!

      static var identifier : String {
          return "MovieCastCollectionViewCell"
      }
    
    var mData:MovieCastVO? = nil {
        didSet{
            if let data = mData{
                self.bindData(data: data)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    fileprivate func bindData(data:MovieCastVO){
        
        //set data
        containerView.lbName.text = data.name ?? ""
        
        let imageURL = IMAGE_URL_PATH + (data.profilePath ?? "")
        let url = URL(string: imageURL)
        containerView.ivBackImage.kf.indicatorType = .activity
        containerView.ivBackImage.kf.setImage(
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
