//
//  movieListViewController.swift
//  MovieList
//
//  Created by Олексій Гаєвський on 31.01.2024.
//

import UIKit

class MovieListViewController: UIViewController {

    @IBOutlet weak var TableView: UITableView!
    
    private var movies: [Movie] = Movie.getMockArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        TableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.reuseIdentifier)
        TableView.rowHeight = 200
        self.navigationItem.title = "Popular movies"
        fetchData()
    }
    
    
    
    func fetchData(){
        ApiCaller.shared.getPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies = movies
                DispatchQueue.main.async {
                    self?.TableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data \(error)")
            
            }
        }
    }

}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.reuseIdentifier, for: indexPath) as? CustomCell else {
            fatalError("Unable to dequeue CustomCell")
        }

        let movie = self.movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.TableView.deselectRow(at: indexPath, animated: true)
        
        let movie = self.movies[indexPath.row]
        let movieViewModel = MovieViewModel(movie: movie)
        let detailVC = DetailMovieViewController(viewModel: movieViewModel)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

}
