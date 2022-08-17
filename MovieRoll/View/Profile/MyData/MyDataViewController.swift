//
//  MeusDadosViewController.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 04/06/22.
//

import UIKit
import FirebaseAuth

class MyDataViewController: UIViewController {

    //MARK: - Componentes
    
    lazy var myDataImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 64
        image.backgroundColor = UIColor(named: "darkGrayMovieRoll")
        return image
    }()
        
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome"
        label.textColor = .white
       return label
    }()
    
    lazy var myNameDataTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite seu nome",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.backgroundColor = UIColor(named: "darkGrayMovieRoll")
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "AmsiPro-Regular", size: 17)
        return textField
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-mail"
        label.textColor = .white
       return label
    }()
    
    lazy var myEmailDataTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite seu e-mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.autocapitalizationType = UITextAutocapitalizationType.none
        textField.backgroundColor = UIColor(named: "darkGrayMovieRoll")
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "AmsiPro-Regular", size: 17)
        textField.delegate = self
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Senha"
        label.textColor = .white
       return label
    }()
    
    lazy var myPasswordDataTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite sua senha",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.isSecureTextEntry = true
        textField.backgroundColor = UIColor(named: "darkGrayMovieRoll")
        textField.borderStyle = .roundedRect
        textField.font = UIFont(name: "AmsiPro-Regular", size: 17)
        textField.delegate = self
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Salvar", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AmsiPro-Bold", size: 17)
        button.backgroundColor = UIColor(named: "orangeMovieRoll")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var eyeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = UIColor.gray
        button.addTarget(self, action: #selector(eyeButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(named: "darkGrayMovieRoll")
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Public Properties
    
    var viewModel: MeusDadosViewModel?

    //MARK: - Public Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = "Meus Dados"
        view.addSubview(myDataImage)
        view.addSubview(nameLabel)
        view.addSubview(myNameDataTextField)
        view.addSubview(emailLabel)
        view.addSubview(myEmailDataTextField)
        view.addSubview(passwordLabel)
        view.addSubview(myPasswordDataTextField)
        view.addSubview(saveButton)
        view.addSubview(eyeButton)
        view.addSubview(closeButton)
        setupConstraints()
        hideKeyboardWhenTappedAround()
        
        configureScreen()
        
        viewModel?.delegate = self
    }
    
    //MARK: - Private Methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myDataImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myDataImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            myDataImage.heightAnchor.constraint(equalToConstant: 128),
            myDataImage.widthAnchor.constraint(equalToConstant: 128),

            nameLabel.topAnchor.constraint(equalTo: myDataImage.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            
            myNameDataTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            myNameDataTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            myNameDataTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: myNameDataTextField.bottomAnchor, constant: 16),
            emailLabel.leadingAnchor.constraint(equalTo: myNameDataTextField.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: myNameDataTextField.trailingAnchor),
            
            myEmailDataTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 4),
            myEmailDataTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            myEmailDataTextField.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: myEmailDataTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: myEmailDataTextField.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: myEmailDataTextField.trailingAnchor),
            
            myPasswordDataTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 4),
            myPasswordDataTextField.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
            myPasswordDataTextField.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor),
            
            saveButton.topAnchor.constraint(equalTo: myPasswordDataTextField.bottomAnchor, constant: 45),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 170),
            
            eyeButton.centerYAnchor.constraint(equalTo: myPasswordDataTextField.centerYAnchor),
            eyeButton.heightAnchor.constraint(equalToConstant: 20),
            eyeButton.widthAnchor.constraint(equalToConstant: 25),
            eyeButton.trailingAnchor.constraint(equalTo: myPasswordDataTextField.trailingAnchor, constant: -6),
            
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 4),
        ])
    }
    
    private func configureScreen() {
        guard let viewModel = viewModel else { return }
        myNameDataTextField.text = viewModel.getUserName
        myEmailDataTextField.text = viewModel.getUserEmail
        myDataImage.image = UIImage(data: viewModel.getUserImage) ?? UIImage(named: "perfil")
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: - Actions
    
    @objc func saveButtonAction() {
        viewModel?.saveButtonAction(
            nome: myNameDataTextField.text,
            email: myEmailDataTextField.text,
            password: myPasswordDataTextField.text
        )
    }
    
    @objc func eyeButtonAction() {
        viewModel?.eyeButtonPressed(visivel: myPasswordDataTextField.isSecureTextEntry)
    }
    
    @objc func closeButtonAction() {
        dismiss(animated: true)
    }
}
//MARK: - MyData ViewModelDelegate
extension MyDataViewController: MyDataViewModelDelegate {
    func authenticationAlertError(message: String) {
        let alerta = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alerta.addAction(okAction)
    
        present(alerta, animated: true)
    }
    
    func securePasswordTextField() {
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        myPasswordDataTextField.isSecureTextEntry = true
    }
    
    func notSecurePasswordTextField() {
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        myPasswordDataTextField.isSecureTextEntry = false
    }
    
    func dismissModal() {
        presentingViewController?.presentingViewController?.childViewControllerForPointerLock?.children.last?.viewWillAppear(true)
        self.view.window!.rootViewController?.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func alertErrorPassword() {
        let alert = UIAlertController(title: "Atenção", message: "Senha precisa ter 6 caracteres", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
    
        present(alert, animated: true)
    }
 
    func alertErrorEmail() {
        let alert = UIAlertController(title: "Atenção", message: "E-mail no formato inválido", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
    
        present(alert, animated: true)
    }
}

//MARK: - UITextField Delegate

extension MyDataViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

