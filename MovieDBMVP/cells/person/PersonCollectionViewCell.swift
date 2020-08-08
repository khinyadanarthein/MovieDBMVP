//
//  PersonCollectionViewCell.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    
    static var identifier : String {
        return "PersonCollectionViewCell"
    }
    
    @IBOutlet weak var containerView: ActorCellView!
    
    var mData:MovieCastDetailVO? = nil {
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
    
    fileprivate func bindData(data:MovieCastDetailVO){
        
        //set data
        containerView.lbName.text = data.name
        
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
