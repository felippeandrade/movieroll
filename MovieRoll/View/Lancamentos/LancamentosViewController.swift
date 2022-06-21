//
//  InicioViewController.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 26/05/22.
//

import UIKit

class LancamentosViewController: UIViewController {
    
    @IBOutlet weak var lancamentosTableView: UITableView!
    @IBOutlet weak var activityIndicatorLancamento: UIActivityIndicatorView!
   
    var viewModel = LancamentosViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorLancamento.hidesWhenStopped = true
        activityIndicatorLancamento.startAnimating()
        
        lancamentosTableView.delegate = self
        lancamentosTableView.dataSource = self
        viewModel.delegate = self
        
        viewModel.carregarFilmes()
    }
}
//MARK: - TableView DataSource & Delegate
extension LancamentosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.retornaTitulo(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = lancamentosTableView.dequeueReusableCell(withIdentifier: "idCellTable", for: indexPath) as? LancamentosTableViewCell else { return UITableViewCell() }

        let movies = viewModel.getFilmesLancamentos[indexPath.section]
        cell.config(viewModel: viewModel, movies: movies)
        cell.lancamentosCollectionView.tag = indexPath.section
        cell.lancamentosCollectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let tableHeader = view as! UITableViewHeaderFooterView
        tableHeader.tintColor = UIColor.black
        tableHeader.textLabel?.textColor = .white
    }
}

extension LancamentosViewController: LancamentosViewModelDelegate {
    func didSelectItem(movie: Movie) {
        guard let detalhesFilme = storyboard?.instantiateViewController(withIdentifier: "detalhesFilme") as? DetalhesFilmeViewController else { return }
        let ehFavorito = viewModel.verificaFavorito(movie: movie)
        let foiAssistido = viewModel.verificaAssistido(movie: movie)

        let viewModel = DetalhesFilmeViewModel(movie: movie, ehFavorito: ehFavorito, foiAssistido: foiAssistido)
        detalhesFilme.viewModel = viewModel
        navigationController?.pushViewController(detalhesFilme, animated: true)
    }
    
    func stopLoading() {
        activityIndicatorLancamento.stopAnimating()
    }
    
    func reloadTableView() {
        lancamentosTableView.reloadData()
    }
}

