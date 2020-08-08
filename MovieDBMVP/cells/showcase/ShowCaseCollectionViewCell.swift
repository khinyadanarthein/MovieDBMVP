//
//  ShowCaseCollectionViewCell.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 01/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView
import YouTubePlayer

class ShowCaseCollectionViewCell: UICollectionViewCell {
    
    static var identifier : String {
        return "ShowCaseCollectionViewCell"
    }
    
    @IBOutlet weak var mainView: SlideVideoView!
    @IBOutlet weak var ivBackImage: UIImageView!
    @IBOutlet weak var videoPlayView: YouTubePlayerView!
    @IBOutlet weak var btnPlayView: UIButton!
    
    var index :Int!
    
    var mData:MovieShowCaseVO? = nil {
        didSet{
            if let data = mData{
                self.bindData(data: data)
            }
        }
    }
    
    var videoData:MovieVideoDetailVO? = nil {
        didSet{
            if let data = videoData{
                self.videoPlayView.isHidden = false
                self.ivBackImage.isHidden = true
                self.videoPlayView.loadVideoID(data.key ?? "")
                self.videoPlayView.delegate = self
            }
        }
    }
    
    var mDelegate : VideoPlayDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.videoPlayView.isHidden = true
        
    }
    @IBAction func onTapBtnPlay(_ sender: Any) {
        mDelegate.onTapPlayButton(movieId: mData?.id ?? 0, index: self.index, section: HomeSection.Showcase.rawValue)
    }
    
    fileprivate func bindData(data:MovieShowCaseVO){
        
        //
        let imageURL = IMAGE_URL_PATH + (data.posterPath ?? "")
        let url = URL(string: imageURL)
        self.ivBackImage.kf.indicatorType = .activity
        self.ivBackImage.kf.setImage(
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

extension ShowCaseCollectionViewCell : YouTubePlayerDelegate {
    
    func playerReady(_ videoPlayer: YouTubePlayerView) {
        self.videoPlayView.play()
    }
}
