//
//  PlayButton.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 02/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class PlayButton: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var mainView : UIView!
    @IBOutlet weak var ivPlay : UIImageView!
    
    var isActive : Bool = true {
        didSet {
            handleButtonState()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder : coder)
        buildView()
    }
    
    private func buildView() {
        Bundle.main.loadNibNamed(String(describing: PlayButton.self), owner: self, options: nil)
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = UIColor(named: "tint-color")
        mainView.layer.cornerRadius = 35
        mainView.layer.borderWidth = 0
        self.mainView.isUserInteractionEnabled = true
        
        //handleButtonState()
    }
    
    private func handleButtonState() {
        if isActive {
            activeState()
        }
        else {
            inactiveState()
        }
    }
    
    private func activeState() {
        //isEnabled = true
        backgroundColor = UIColor(named: "tint-color")
        //setTitleColor(.white, for: .normal)
    }
    
    private func inactiveState() {
        backgroundColor = UIColor.gray
        //isEnabled = false
        //setTitleColor(.black, for: .normal)
        
    }
}
