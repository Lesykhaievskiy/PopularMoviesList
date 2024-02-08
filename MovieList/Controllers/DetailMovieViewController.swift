//
//  DetailMovieViewController.swift
//  MovieList
//
//  Created by Олексій Гаєвський on 01.02.2024.
//
import UIKit

class DetailMovieViewController: UIViewController {
    var viewModel: MovieViewModel
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
    
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let movieImage: UIImageView = {
       let iv = UIImageView()
       iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "house")
        iv.tintColor = .label
        
        return iv
    }()
    
    private let movieTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Title"
        label.numberOfLines = 0
        return label
    }()
    
    private let movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.text = "Overview"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var vStack: UIStackView = {
        let vStack = UIStackView(arrangedSubviews: [movieTitleLabel, movieOverviewLabel])
        vStack.axis = .vertical
        vStack.distribution = .fill
        vStack.spacing = 12
        vStack.alignment = .center
        return vStack
    }()
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: nil, action: nil)
        self.movieTitleLabel.text = self.viewModel.movie.title
        self.movieOverviewLabel.text = self.viewModel.movie.overview
        self.navigationItem.title = self.viewModel.movie.title
        loadImage()
        addGradientToImage()
            
    }
    
    private func loadImage() {
        guard let imageURL = viewModel.movie.imageURL else {
            print("Error: Image URL is nil.")
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self?.movieImage.image = UIImage(data: data)
                }
            } else {
                print("Error loading image: \(error?.localizedDescription ?? "")")
            }
        }.resume()
    }
    
    
    
    private func addGradientToImage() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = movieImage.bounds
        movieImage.layer.addSublayer(gradientLayer)
    }


    private func setupUI() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(movieImage)
        self.contentView.addSubview(vStack)
        
        let height = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = UILayoutPriority(1)
        height.isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        vStack.translatesAutoresizingMaskIntoConstraints = false
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            movieImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -45),
            movieImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),

            movieTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieTitleLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10),
            movieTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            movieOverviewLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            movieOverviewLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: -10),
            movieOverviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            movieOverviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            vStack.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 10),
            vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            vStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20)
        ])
    }

}
