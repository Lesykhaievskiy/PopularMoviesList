//
//  MovieModel.swift
//  MovieList
//
//  Created by Олексій Гаєвський on 01.02.2024.
//

import Foundation


struct PopularMovieResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable{
    let title: String
    let id: Int
    let poster_path: String?
    let overview: String
    
    
    var imageURL: URL? {
        if let posterPath = poster_path {
            let baseURL = "https://image.tmdb.org/t/p/w500"
            return URL(string: baseURL + posterPath)
        }
        return nil
    }
    
}

extension Movie{
    public static func getMockArray() -> [Movie]{
        return [
            Movie(title: "Lesyk", id: 1, poster_path: nil, overview: "EOvnijnv uf eifj weif woidjweo jvrewieojd wekodeow "),
            Movie(title: "KMEvkoa", id: 2, poster_path: nil, overview: "POVDoododkvokdev eojeiowefoe "),
            Movie(title: "rverevev", id: 3, poster_path: nil, overview: "lalalalalalalalalalaalalaalalalalalalalalalalalallalalala "),
            Movie(title: "Leervrresyk", id: 4, poster_path: nil, overview: "hahahahahhahaahhahahahahahahahahahahaha")
                
     ]
    }
}
