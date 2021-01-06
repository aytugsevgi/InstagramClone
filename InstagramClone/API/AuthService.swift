//
//  AuthService.swift
//  InstagramClone
//
//  Created by aytug on 20.12.2020.
//

import UIKit
import Firebase

struct AuthCredentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    static func registerUser(withCredential credential: AuthCredentials, completion: @escaping(Error?) -> Void) {
        
        ImageUploader.uploadImage(image: credential.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credential.email, password: credential.password) { (result, error) in
                
                if let error = error {
                    print("DEBUG: Failed is register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": credential.email, "fullname": credential.fullname, "profileImageUrl": imageUrl, "uid": uid, "username": credential.username]
                
                COLLECTION_USERS.document(uid).setData(data) { (error) in
                    if let error = error {
                        print("DEBUG: Failed is collection set data \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback? ) {
        Auth.auth().signIn(withEmail: email, password: password , completion: completion)
    }
}
