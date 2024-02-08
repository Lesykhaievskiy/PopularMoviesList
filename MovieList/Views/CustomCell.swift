//
//  CustomCell.swift
//  MovieList
//
//  Created by Олексій Гаєвський on 01.02.2024.
//

import UIKit

class CustomCell: UITableViewCell {
    static let reuseIdentifier = "MovieCell"
    private (set) var movie: Movie!

    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
   private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "house")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    private var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Title"
        label.numberOfLines = 0
        return label
    }()
    
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    public func configure(with movie: Movie){
        self.movie = movie
        self.movieTitleLabel.text = movie.title
 
        loadImage()
    }
    
    

    func setupViews() {
       
        addSubview(movieImageView)
        addSubview(movieTitleLabel)
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            movieImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 150),
            movieImageView.heightAnchor.constraint(equalToConstant: 150)
        ])

        NSLayoutConstraint.activate([
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            movieTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            movieTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    private func loadImage() {
        guard let imageURL = movie.imageURL else {
            print("Error: Image URL is nil.")
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self?.movieImageView.image = UIImage(data: data)
                }
            } else {
                print("Error loading image: \(error?.localizedDescription ?? "")")
            }
        }.resume()
    }

    
}
