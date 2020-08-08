//
//  Router.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 08/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
        
    var mainStoryBoard:UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func navigateToDetail(movie : MovieDetailVO){
        
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        //if let vc = vc {
            vc.movie = movie
            print("movie id \(movie.id)")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        //}
    }
}
