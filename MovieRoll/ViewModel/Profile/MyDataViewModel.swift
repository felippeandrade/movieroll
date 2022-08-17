//
//  MeusDadosViewModel.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 06/06/22.
//

import Foundation
import FirebaseAuth

protocol MyDataViewModelDelegate {
    func dismissModal()
    func authenticationAlertError(message: String)
    func securePasswordTextField()
    func notSecurePasswordTextField()
}

class MeusDadosViewModel {
    
    //MARK: - Public Properties
    
    let serviceAuth: ServiceAuth = .init()
    var delegate: MyDataViewModelDelegate?
    
    var getUserName: String {
        return ServiceAuth.userProfile.name
    }
    
    var getUserEmail: String {
        return ServiceAuth.userProfile.email
    }
    
    var getUserImage: Data {
        return ServiceAuth.userProfile.image
    }
    
    //MARK: - Public Methods
    
    func setUserName(nome: String?) {
        guard let nome = nome else { return }
        ServiceAuth.userProfile.name = nome
    }
    
    func setUserImage(image: Data) {
        ServiceAuth.userProfile.image = image
    }
    
    func saveButtonAction(nome: String?, email: String?, password: String?) {
        guard let nome = nome else { return }
        guard let email = email else { return }
        guard let password = password else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            let error = error as? NSError
            
            if error?.code == 17034 {
                self.delegate?.authenticationAlertError(message: "Entre com um e-mail e tente novamente.")
                return
            }
            
            if error?.code == 17007 {
                self.delegate?.authenticationAlertError(message: "E-mail já cadastrado, tente novamente.")
                return
            }
            
            if error?.code == 17026 {
                self.delegate?.authenticationAlertError(message: "Senha precisa conter pelo menos 6 caracteres, tente novamente.")
                return
            }
            
            if error?.code == 17008 {
                self.delegate?.authenticationAlertError(message: "E-mail não está no formato correto, tente novamente.")
                return
            }
            self.changeUserName(nome: nome)
            
            Auth.auth().currentUser?.sendEmailVerification { error in

            }
        }
    }
    
    private func changeUserName(nome: String) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = nome
        changeRequest?.commitChanges { _ in
            self.serviceAuth.userInfo()
            self.delegate?.dismissModal()
        }
    }
    
    func eyeButtonPressed(visivel: Bool) {
        if visivel {
            delegate?.notSecurePasswordTextField()
        } else {
            delegate?.securePasswordTextField()
        }
    }
}
