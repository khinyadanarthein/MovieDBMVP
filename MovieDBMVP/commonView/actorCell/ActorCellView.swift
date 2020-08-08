//
//  ActorCellView.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 06/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class ActorCellView: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var ivBackImage: UIImageView!
    
    @IBOutlet weak var ivFavorite: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    
    @IBOutlet weak var ivLikeIcon: UIImageView!
    @IBOutlet weak var lbLikeHistory: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }
    
    private func buildView() {
        /**
         1) xib add
         2) add subview
         */
        Bundle.main.loadNibNamed(String(describing: ActorCellView.self), owner: self, options: nil)
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
