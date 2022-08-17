//
//  ViewController.swift
//  MovieRoll
//
//  Created by Vitor Henrique Barreiro Marinho on 25/05/22.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet private weak var profileTableView: UITableView!
    
    //MARK: - Private Properties
    
    private let viewModel = ProfileViewModel()
    
    //MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        viewModel.delegate = self
        viewModel.getDataFromUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getDataFromUser()
        profileTableView.reloadData()
    }
}
//MARK: - PerfilViewModel Delegate

extension ProfileViewController: ProfileViewModelDelegate {
    func showLogin() {
        let loginVC = LoginViewController()
        present(loginVC, animated: true)
    }
    
    func showMyData() {
        let meusDadosVC = MyDataViewController()
        meusDadosVC.viewModel = viewModel.getMyDataViewModel
        meusDadosVC.navigationItem.largeTitleDisplayMode = .never
        meusDadosVC.myPasswordDataTextField.isHidden = true
        meusDadosVC.eyeButton.isHidden = true
        meusDadosVC.passwordLabel.isHidden = true
        meusDadosVC.saveButton.isHidden = true
        meusDadosVC.closeButton.isHidden = true
        navigationController?.pushViewController(meusDadosVC, animated: true)
    }
    
    func showHistory() {
        if let historicoVC = storyboard?.instantiateViewController(withIdentifier: "historicoVC") as? HistoryViewController {
            historicoVC.viewModel = viewModel.getHistoryViewModel
            historicoVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(historicoVC, animated: true)
        }
    }
    
    func showSettings() {
        let configuracoesVC = SettingsViewController()
        configuracoesVC.viewModel = viewModel.getSettingsViewMdel
        configuracoesVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(configuracoesVC, animated: true)
    }
    
    func showHelp() {
        if let ajudaVC = storyboard?.instantiateViewController(withIdentifier: "ajudaVC") as? AjudaViewController {
            ajudaVC.modalPresentationStyle = .pageSheet
            ajudaVC.modalTransitionStyle = .coverVertical
            present(ajudaVC, animated: true)
        }
    }
}

//MARK: - TableView DataSource & Delegate

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor(red: 46.0/255, green: 46.0/255, blue: 46.0/255, alpha: 0.4)
        cell.selectionStyle = .none
        
        var content = cell.defaultContentConfiguration()
        
        content.image = UIImage(data: viewModel.getImage(indexPath: indexPath)) ?? UIImage(named: viewModel.getImage(indexPath: indexPath)) ?? UIImage(named: "perfil")
        
        content.imageProperties.maximumSize = CGSize(
            width: viewModel.getMaximumSize(indexPath: indexPath),
            height: viewModel.getMaximumSize(indexPath: indexPath)
        )
        content.imageProperties.cornerRadius = CGFloat(viewModel.getCornerRadius(indexPath: indexPath))
        content.text = viewModel.getText(indexPath: indexPath)
        content.secondaryText = viewModel.getSecondaryText(indexPath: indexPath)
        content.textProperties.color = .white
        content.secondaryTextProperties.color = .white
        
        content.textProperties.font = UIFont(name: "AmsiPro-Regular", size: 17) ?? UIFont()
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.optionsFromTableView(index: indexPath.row)
    }
}


