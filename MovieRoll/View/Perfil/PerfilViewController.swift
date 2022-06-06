//
//  ViewController.swift
//  MovieRoll
//
//  Created by Vitor Henrique Barreiro Marinho on 25/05/22.
//

import UIKit

class PerfilViewController: UIViewController {

    @IBOutlet weak var perfilTableView: UITableView!
    
    let viewModel = PerfilViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perfilTableView.delegate = self
        perfilTableView.dataSource = self
    }
}

extension PerfilViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let meusDadosVC = storyboard?.instantiateViewController(withIdentifier: "meusDadosVC") as? MeusDadosViewController {
                meusDadosVC.viewModel = viewModel.getMeusDadosViewModel()
                meusDadosVC.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(meusDadosVC, animated: true)
            }
        }
        if indexPath.row == 1 {
            if let historicoVC = storyboard?.instantiateViewController(withIdentifier: "historicoVC") as? HistoricoViewController {
                historicoVC.viewModel = viewModel.getHistoricoViewModel()
                historicoVC.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(historicoVC, animated: true)
            }
        }
        if indexPath.row == 2 {
            if let configuracoesVC = storyboard?.instantiateViewController(withIdentifier: "configuracoesViewController") as? ConfiguracoesViewController {
                configuracoesVC.navigationItem.largeTitleDisplayMode = .never
                navigationController?.pushViewController(configuracoesVC, animated: true)
            }
        }
    }
}

extension PerfilViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .darkGray
        
        var content = cell.defaultContentConfiguration()
        
        content.image = UIImage(named: viewModel.getImage(indexPath: indexPath))

        content.imageProperties.maximumSize = CGSize(
            width: viewModel.getMaximumSize(indexPath: indexPath),
            height: viewModel.getMaximumSize(indexPath: indexPath)
        )
        content.imageProperties.cornerRadius = CGFloat(viewModel.getCornerRadius(indexPath: indexPath))
        
        content.text = viewModel.getText(indexPath: indexPath)
        content.secondaryText = viewModel.getSecondaryText(indexPath: indexPath)
        content.textProperties.color = .white
        content.secondaryTextProperties.color = .white
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
}

