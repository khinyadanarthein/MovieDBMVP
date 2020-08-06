//
//  TitleCollectionReusableView.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 02/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class TitleCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lbTitleName: UILabel!
    @IBOutlet weak var lbSeeMore: UnderlinedLabel!
    
    static var identifier : String {
        return "TitleCollectionReusableView"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
