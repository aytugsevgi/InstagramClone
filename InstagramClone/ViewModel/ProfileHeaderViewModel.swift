//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by aytug on 6.01.2021.
//

import Foundation


struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    
    init(user: User) {
        self.user = user
    }
}
