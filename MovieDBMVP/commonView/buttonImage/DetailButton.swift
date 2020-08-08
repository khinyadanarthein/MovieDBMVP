//
//  DetailButton.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 07/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

@IBDesignable
class DetailButton: UIButton {
    
        @IBInspectable
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
        
        override func prepareForInterfaceBuilder() {
            super.prepareForInterfaceBuilder()
            self.buildView()
            
        }
        
        private func buildView() {
            
           // backgroundColor = UIColor(named: "tint-color")
            titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            //setImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            setTitleColor(.white, for: .normal)
            setTitleColor(.gray, for: .highlighted)
            
            layer.cornerRadius = 20
            layer.borderWidth = 0.2
            layer.borderColor = UIColor.lightGray.cgColor
            
            handleButtonState()
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
            isEnabled = true
            //backgroundColor = UIColor.systemYellow
            setTitleColor(.white, for: .normal)
        }
        
        private func inactiveState() {
            backgroundColor = UIColor.gray
            isEnabled = false
            setTitleColor(.black, for: .normal)
            
        }
    


}
