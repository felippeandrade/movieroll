//
//  HistoricoViewController.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 04/06/22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet  weak var segmentedControlRouletteFavoritesWatched: UISegmentedControl!
    @IBOutlet private weak var historyCollectionView: UICollectionView!
    
    //MARK: - Private Properties
    
    private var segmentedControlIndex = 0
    
    private var searchController: UISearchController?
    
    //MARK: - Public Properties
    
    var viewModel: HistoryViewModel?
    
    //MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        viewModel?.loadMovies()
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
        setupSegmentedControl()
        
        createSearchBar()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.loadMovies()
        historyCollectionView.reloadData()
    }
    
    
    //MARK: - Private Methods
    
    private func createSearchBar(){
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        
        changeColorTextSearchBar()
    }
    
    private func changeColorTextSearchBar(){
        let textFieldInsideSearchBar = searchController?.searchBar.value(forKey: "searchField") as? UITextField
        
        textFieldInsideSearchBar?.textColor = .white
    }
    
    private func setupSegmentedControl() {
        segmentedControlRouletteFavoritesWatched.setTitleTextAttributes(
            [.foregroundColor: UIColor.white],
            for: .normal
        )
    }
    
    //MARK: - Actions
    
    @IBAction func actionSegmentedControl(_ sender: Any) {
        segmentedControlIndex = segmentedControlRouletteFavoritesWatched.selectedSegmentIndex
        historyCollectionView.reloadData()
    }
    
}
//MARK: - HistoricoViewModelDelegate

extension HistoryViewController: HistoryViewModelDelegate {
    func reloadCollectionView() {
        historyCollectionView.reloadData()
    }
    
}

//MARK: - UICollectionView dataSource & Delegate

extension HistoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems(segmentedControlIndex: segmentedControlIndex) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = historyCollectionView.dequeueReusableCell(withReuseIdentifier: "historicoCell", for: indexPath) as? HistoryCollectionViewCell else { return UICollectionViewCell() }
        
        guard let cellViewModel = viewModel?.getCellViewModel(indexPath: indexPath, segmentedControlIndex: segmentedControlIndex) else {return UICollectionViewCell()}
        
        cell.setupCell(viewModel: cellViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        let movie = viewModel.returnsMovie(indexMovie: indexPath.item, indexSegmenterController: segmentedControlIndex)
        guard let movieDetails = storyboard?.instantiateViewController(withIdentifier: "detalhesFilme") as? MoviesDetailsViewController else { return }
        let isFavorite = viewModel.checksFavorite(movie: movie)
        let isWatched = viewModel.checksWatched(movie: movie)
        
        let movieDetailsViewModel = MovieDetailsViewModel(movie: movie, isFavorite: isFavorite, isWatched: isWatched)
        movieDetails.viewModel = movieDetailsViewModel
        navigationController?.pushViewController(movieDetails, animated: true)
    }
}
//MARK: - UISearchBar Results Updating

extension HistoryViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.searchResults(searchController: searchController)
    }
    
}



