//
//  ApiCaller.swift
//  MovieList
//
//  Created by Олексій Гаєвський on 01.02.2024.
//

import Foundation

struct constants{
    static let apiKey = "2ccc9fcb3e886fcb5f80015418735095"
    static let baseURL = "https://api.themoviedb.org"

}

enum ApiError: Error{
    case failedToGetData
}

class ApiCaller{
    static let shared = ApiCaller()
    func getPopularMovies(completion: @escaping(Result<[Movie], Error>) -> Void){
        let urlString = "\(constants.baseURL)/3/movie/popular?api_key=\(constants.apiKey)"
        guard let url = URL(string: urlString) else {return}
        let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else{return}
            
            do{
                let result = try JSONDecoder().decode(PopularMovieResponse.self, from: data)
                completion(.success(result.results))              
            }catch{
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    
//    func getDetailmovie(movieId: Int, completion: @escaping(Result<DetailMovie, Error>) -> Void) {
//            let urlString = "\(constants.baseURL)/3/movie/\(movieId)?api_key=\(constants.apiKey)"
//            guard let url = URL(string: urlString) else { return }
//            let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
//                guard let data = data, error == nil else {
//                completion(.failure(error ?? ApiError.failedToGetData))
//                    return
//                }
//
//                do {
//                    let result = try JSONDecoder().decode(DetailMovieResponse.self, from: data)
//                    completion(.success(result.result))
//                    print(result.result)
//                } catch {
//                    completion(.failure(error))
//                }
//            }
//            dataTask.resume()
//        }
//    
}
