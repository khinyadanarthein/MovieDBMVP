//
//  MovieCellView.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 06/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import Cosmos

class MovieCellView: UIView {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var lbMovieName: UILabel!
    @IBOutlet weak var lbRatingValue: UILabel!
    @IBOutlet weak var viewRatingStar: CosmosView!
    @IBOutlet weak var viewTop: UIView!
}
