//
//  LoginViewController.swift
//  MovieRoll
//
//  Created by Raul Felippe on 08/06/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookLogin

class LoginViewController: UIViewController {
    
    //MARK: - Components
    
    lazy var logoImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "logotipo")
        return image
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-mail"
        label.textColor = .white
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    lazy var passwordTextField: UITextField = {
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
    
    lazy var forgottenPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Esqueci minha senha", for: .normal)
        button.setTitleColor(UIColor(named: "blueMovieRoll"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AmsiPro-Regular", size: 14)
        button.addTarget(self, action: #selector(forgotMyPasswordButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Entrar", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AmsiPro-Bold", size: 17)
        button.backgroundColor = UIColor(named: "blueMovieRoll")
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loginButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var googleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "google"), for: .normal)
        button.imageView?.image = UIImage(named: "google")
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(googleButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var facebookButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "facebook"), for: .normal)
        button.imageView?.image = UIImage(named: "facebook")
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(facebookButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Não tem uma conta? Crie uma agora", for: .normal)
        button.setTitleColor(UIColor(named: "blueMovieRoll"), for: .normal)
        button.titleLabel?.font = UIFont(name: "AmsiPro-Bold", size: 16)
        button.addTarget(self, action: #selector(registerButtonAction), for: .touchUpInside)
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
    
    //MARK: - Public Methods
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(logoImage)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(forgottenPasswordButton)
        view.addSubview(loginButton)
        view.addSubview(googleButton)
        view.addSubview(facebookButton)
        view.addSubview(registerButton)
        view.addSubview(eyeButton)
        hideKeyboardWhenTappedAround()
        
        setupConstraints()
        viewModel.delegate = self
    }
    //MARK: - Private Methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 64),
            logoImage.heightAnchor.constraint(equalToConstant: 180),
            logoImage.widthAnchor.constraint(equalToConstant: 180),
            
            emailLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 24),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 2),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 2),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor),
            
            forgottenPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 2),
            forgottenPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: forgottenPasswordButton.bottomAnchor, constant: 24),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 170),
            
            googleButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 22),
            googleButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            googleButton.heightAnchor.constraint(equalToConstant: 60),
            googleButton.widthAnchor.constraint(equalToConstant: 60),
            
            facebookButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            facebookButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            facebookButton.heightAnchor.constraint(equalToConstant: 50),
            facebookButton.widthAnchor.constraint(equalToConstant: 50),
            
            
            registerButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor, constant: 40),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            eyeButton.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            eyeButton.heightAnchor.constraint(equalToConstant: 20),
            eyeButton.widthAnchor.constraint(equalToConstant: 25),
            eyeButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: -6),
        ])
    }
    //MARK: - Actions
    
    @objc private func forgotMyPasswordButtonAction() {
        let alerta = UIAlertController(title: "Redefinição de Senha", message: "Será enviado um link de renovação de senha para o email abaixo.", preferredStyle: .alert)

        alerta.addTextField { textfield in
            textfield.placeholder = "Digite seu e-mail"
            textfield.text = self.emailTextField.text
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { [weak alerta] (_) in
            let textField = alerta?.textFields?.first
            self.viewModel.forgotMyPasswordPressedButton(email: textField?.text)
        })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .destructive)
        
        alerta.addAction(cancelAction)
        alerta.addAction(okAction)
        
    
        present(alerta, animated: true)
        
    }
    
    @objc private func loginButtonAction() {
        viewModel.concludeLoginEmailPassword(
            email: emailTextField.text,
            password: passwordTextField.text
        )
    }
    
    @objc private func googleButtonAction() {
        viewModel.concludeLoginGoogle()
    }
    
    @objc private func facebookButtonAction() {
        viewModel.concludeLoginFacebook()
    }
    
    @objc private func registerButtonAction() {
        let myDataVC = MyDataViewController()
        myDataVC.viewModel = MeusDadosViewModel()
        present(myDataVC, animated: true)
    }
    
    @objc private func eyeButtonAction() {
        viewModel.eyeButtonPressed(visivel: passwordTextField.isSecureTextEntry)
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                         action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

//MARK: - Login VieModel Delegate

extension LoginViewController: LoginViewModelDelegate {
    func securePasswordTextField() {
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordTextField.isSecureTextEntry = true
    }
    
    func notSecurePasswordTextField() {
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        passwordTextField.isSecureTextEntry = false
    }
    
    func errorAlertLogin(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
    
        present(alert, animated: true)
    }
    
    func loginFacebook(loginManager: LoginManager) {
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { result, error in
    self.viewModel.handleLoginFacebook(result: result, error: error)
}
    }
    
    func dismissModal() {
        presentingViewController?.childViewControllerForPointerLock?.children.last?.viewWillAppear(true)
        dismiss(animated: true)
    }
    
    func loginGoogle(configuration: GIDConfiguration) {
        GIDSignIn.sharedInstance.signIn(
            with: configuration,
            presenting: self
        ) { [unowned self] user, error in
            self.viewModel.prepareLoginGoogle(
                user: user,
                error: error
            )
        }
    }
}

//MARK: - UITextField Delegate

extension LoginViewController: UITextFieldDelegate {
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

