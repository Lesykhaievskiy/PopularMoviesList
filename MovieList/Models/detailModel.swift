//
//  detailModel.swift
//  MovieList
//
//  Created by Олексій Гаєвський on 01.02.2024.
//

import Foundation

struct DetailMovieResponse: Codable{
    let result: DetailMovie
}
struct DetailMovie: Codable{
    let title: String
        //let release_date: String
    let overview: String
    let poster_path: String?
}
