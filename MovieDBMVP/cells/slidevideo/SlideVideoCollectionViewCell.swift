//
//  SlideVideoCollectionViewCell.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import Kingfisher
import YouTubePlayer

class SlideVideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var svContainer: UIView!
    @IBOutlet weak var ivBackImage: UIImageView!
    @IBOutlet weak var videoView: YouTubePlayerView!
    @IBOutlet weak var btnPlayVideo: UIButton!
    
    static var identifier : String {
        return "SlideVideoCollectionViewCell"
    }
    var videoKey : String?
    var mDelegate : VideoPlayDelegate!
    var index :Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        videoView.isHidden = true
       
    }

    @IBAction func onTapPlayBtn(_ sender: Any) {
        videoView.isHidden = false
        self.mDelegate.onTapPlayButton(movieId: (self.mData?.id)!, index: index, section: HomeSection.PagingVideo.rawValue)
    }
    
    var mData:MainVideoVO? = nil {
        didSet{
            if let data = mData{
                self.bindData(data: data)
            }
        }
    }
    
    var videoData:MovieVideoDetailVO? = nil {
        didSet{
            if let data = videoData{
                self.videoView.isHidden = false
                self.videoView.loadVideoID(data.key ?? "")
                self.videoView.delegate = self
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
extension SlideVideoCollectionViewCell : YouTubePlayerDelegate {
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        self.videoView.play()
    }
}
