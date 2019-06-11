//
//  UserBilgileriAl.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 1.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation
import Firebase

class UserBilgiler {
    static func bilgileriAl() {
        let ref=Database.database().reference()
       
        ref.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of:.value, with: {(snapshot) in
            let userObject = snapshot.value as? [String: AnyObject]
            let name = userObject?["name"]
            let nickname = userObject?["nickname"]
            let winScore = userObject?["win"]
            let loseScore = userObject?["lose"]
            let enemy = userObject? ["enemy"]
            let image = userObject? ["image"]
            User.getUserNesne().id=Auth.auth().currentUser?.uid
            User.getUserNesne().name=(name as? String)!
            User.getUserNesne().nickName=(nickname as? String)!
            User.getUserNesne().win=(winScore as? Int)!
            User.getUserNesne().lose=(loseScore as? Int)!
            User.getUserNesne().email=Auth.auth().currentUser?.email
            User.getUserNesne().enemy=(enemy as? String)!
            User.getUserNesne().image=(image as? String)!
        })
    }
}
