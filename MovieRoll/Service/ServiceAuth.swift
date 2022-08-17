//
//  ServiceAuth.swift
//  MovieRoll
//
//  Created by Renato Yoshinari on 14/07/22.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FacebookLogin

class ServiceAuth: UIViewController {
    
    static var userProfile = User(
        name: "",
        email: "",
        image: Data()
    )
    
    func userInfo() {
        let currentUser = Auth.auth().currentUser
        
        ServiceAuth.userProfile.image = Data()
        if let photo = currentUser?.photoURL {
            guard let imageData =  try? Data(contentsOf: photo) else { return }
            ServiceAuth.userProfile.image = imageData
        }
        ServiceAuth.userProfile.name = currentUser?.displayName ?? ""
        ServiceAuth.userProfile.email = currentUser?.email ?? ""
    }
    
    func saveInFirebase(com credencial: AuthCredential, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(with: credencial) { authResult, error in
            if let error = error {
                print(error)
            }
            self.userInfo()
            completion(true)
            return
        }
    }
    
    func getGoogleCredential(de user: GIDGoogleUser?) -> AuthCredential? {
        guard
            let authentication = user?.authentication,
            let idToken = authentication.idToken
        else {
            return nil
        }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: authentication.accessToken
        )
        
        return credential
    }
    
    func getGoogleConfiguration() -> GIDConfiguration? {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return nil }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        return config
    }
    
    func treatFacebookLoginResult(result: LoginManagerLoginResult?, error: Error?, completion: @escaping (Bool) -> Void) {
        switch result {
            
        case .none:
            print("Um erro aconteceu")
        case .some(let loginResult):
            
            guard let token = loginResult.token?.tokenString else {
                return
            }
            
            let credential = getFacebookConfiguration(
                token: token
            )
            
            saveInFirebase(com: credential, completion: completion)
        }
    }
    
    private func getFacebookConfiguration(token: String) -> AuthCredential {
            return FacebookAuthProvider.credential(
                withAccessToken: token
            )
        }
}
