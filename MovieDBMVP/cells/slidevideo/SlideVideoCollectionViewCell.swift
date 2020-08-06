//
//  SlideVideoCollectionViewCell.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import Kingfisher
import YoutubePlayer_in_WKWebView

class SlideVideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivBackImage: UIImageView!
    @IBOutlet weak var playBtnView: PlayButton!
    @IBOutlet weak var videoView: WKYTPlayerView!
    
    static var identifier : String {
        return "SlideVideoCollectionViewCell"
    }
    var videoKey : String?
    var mDelegate : VideoPlayDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        videoView.isHidden = true
        playBtnView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(onTapPlayBtn(tapGestureRecognizer:))))
    }

    @objc func onTapPlayBtn(tapGestureRecognizer: UITapGestureRecognizer)
    {
       // mDelegate.onTapPlayButton(movieId: mData?.id ?? 0)
//        print("video key \(self.mData?.key ?? "no link")")
        self.videoView.isHidden = false
        self.videoView.load(withVideoId: self.mData?.key ?? "")
    }
    
    var mData:MainVideoVO? = nil {
        didSet{
            if let data = mData{
                self.bindData(data: data)
            }
        }
    }
    
    fileprivate func bindData(data:MainVideoVO){
        
        //
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
