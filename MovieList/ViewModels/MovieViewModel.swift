//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Олексій Гаєвський on 03.02.2024.
//

import Foundation
import UIKit

class MovieViewModel{
    var movie: Movie

    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var movieTitle: String {
        return movie.title
    }
    
    var overViewText: String{
        return movie.overview
    }

    }

