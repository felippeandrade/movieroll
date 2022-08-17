//
//  InicioViewController.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 26/05/22.
//

import UIKit

class ReleasesViewController: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet private weak var releasesTableView: UITableView!
    @IBOutlet private weak var activityIndicatorRelease: UIActivityIndicatorView!
    
    
    //MARK: - Private Properties
    
    private var viewModel = ReleasesViewModel()

       //MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorRelease.hidesWhenStopped = true
        activityIndicatorRelease.startAnimating()
        
        releasesTableView.delegate = self
        releasesTableView.dataSource = self
        viewModel.delegate = self
        
        viewModel.loadMovies {
            DispatchQueue.main.async {
                self.activityIndicatorRelease.stopAnimating()
                self.releasesTableView.reloadData()
            }
        }
    }
    
}

//MARK: - ReleasesViewModel Delegate

extension ReleasesViewController: ReleasesViewModelDelegate {
    func didSelectItem(movie: Movie) {
        guard let movieDetails = storyboard?.instantiateViewController(withIdentifier: "detalhesFilme") as? MoviesDetailsViewController else { return }
        let isFavorite = viewModel.checksFavorite(movie: movie)
        let isWatched = viewModel.checksWatched(movie: movie)

        let viewModel = MovieDetailsViewModel(movie: movie, isFavorite: isFavorite, isWatched: isWatched)
        movieDetails.viewModel = viewModel
        navigationController?.pushViewController(movieDetails, animated: true)
    }

}

//MARK: - TableView DataSource & Delegate

extension ReleasesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.returnsTitle(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = releasesTableView.dequeueReusableCell(withIdentifier: "idCellTable", for: indexPath) as? ReleasesTableViewCell else { return UITableViewCell() }

        cell.config(viewModel: viewModel, section: indexPath.section)
        cell.releasesCollectionView.tag = indexPath.section
        cell.releasesCollectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let tableHeader = view as? UITableViewHeaderFooterView
        tableHeader?.tintColor = UIColor.black
        tableHeader?.textLabel?.textColor = .white
        tableHeader?.textLabel?.font = UIFont(name: "AmsiPro-Bold", size: 18)
    }
}


