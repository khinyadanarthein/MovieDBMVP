//
//  SlideVideoView.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 07/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class SlideVideoView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var mainVIew: UIView!
    @IBOutlet weak var ivBackImage: UIImageView!
    @IBOutlet weak var playBtn: PlayButton!
    
    @IBOutlet weak var btntest: UIButton!
    
    @IBOutlet weak var videoPlayerView: WKYTPlayerView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }
    
    @IBAction func onTapBtn(_ sender: Any) {
        print("test btn")
    }
    
    private func buildView() {
        /**
         1) xib add
         2) add subview
         */
        Bundle.main.loadNibNamed(String(describing: SlideVideoView.self), owner: self, options: nil)
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        playBtn.isUserInteractionEnabled = true
        playBtn.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(onTapPlayBtn(tapGestureRecognizer:))))
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func onTapPlayBtn(tapGestureRecognizer: UITapGestureRecognizer)
    {
         print("test play btn")
    }

}
