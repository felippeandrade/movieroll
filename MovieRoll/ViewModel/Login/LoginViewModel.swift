//
//  LoginViewModel.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 18/07/22.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FacebookLogin

protocol LoginViewModelDelegate {
    func loginGoogle(configuration: GIDConfiguration)
    func dismissModal()
    func loginFacebook(loginManager: LoginManager)
    func errorAlertLogin(message: String)
    func securePasswordTextField()
    func notSecurePasswordTextField()
}

class LoginViewModel{
    let serviceAuth: ServiceAuth = .init()
    var delegate: LoginViewModelDelegate?
    
    func concludeLoginEmailPassword(email: String?, password: String?) {
        guard let email = email else { return }
        guard let password = password else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            let error = error as? NSError
            
            if error?.code == 17011 {
                self.delegate?.errorAlertLogin(message: "E-mail não registrado, tente novamente.")
                return
            }
            
            if error?.code == 17009 {
                self.delegate?.errorAlertLogin(message: "Senha inválida, tente novamente.")
                return
            }
            
            if error?.code == 17008 {
                self.delegate?.errorAlertLogin(message: "E-mail não está no formato correto, tente novamente.")
                return
            }
            self.delegate?.dismissModal()
        }
    }
    
    func concludeLoginGoogle() {
        guard let configuration = serviceAuth.getGoogleConfiguration() else { return }
        
        delegate?.loginGoogle(configuration: configuration)
    }
    
    func prepareLoginGoogle(user: GIDGoogleUser?, error: Error?) {
        // tratativa de erro
        if let error = error {
            print(error)
            return
        }
        
        // login do google deu certo
        saveDataInFirebase(user: user) { _ in
            self.delegate?.dismissModal()
        }
        
        
    }
    
    func concludeLoginFacebook() {
        
        let loginManager = LoginManager()
        
        delegate?.loginFacebook(loginManager: loginManager)
    }
    
    func handleLoginFacebook(result:LoginManagerLoginResult?, error: Error?) {
        serviceAuth.treatFacebookLoginResult(result: result, error: error) { _ in
            self.delegate?.dismissModal()
        }
        
    }
    
    private func saveDataInFirebase(user: GIDGoogleUser?, completion: @escaping (Bool) -> Void) {
        guard let credential = serviceAuth.getGoogleCredential(de: user) else { return }

        serviceAuth.saveInFirebase(com: credential, completion: completion)
    }
    
    func eyeButtonPressed(visivel: Bool) {
        if visivel {
            delegate?.notSecurePasswordTextField()
        } else {
            delegate?.securePasswordTextField()
        }
    }
    
    func forgotMyPasswordPressedButton(email: String?) {
        guard let email = email else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            let error = error as? NSError
            
            if error?.code == 17011 {
                self.delegate?.errorAlertLogin(message: "E-mail não registrado, tente novamente.")
            }
            
            if error?.code == 17008 {
                self.delegate?.errorAlertLogin(message: "E-mail não está no formato correto, tente novamente.")
            }
            
            if error?.code == 17034 {
                self.delegate?.errorAlertLogin(message: "Entre com um e-mail e tente novamente.")
            }
        }
    }
}
