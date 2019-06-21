//
//  RakipBilgileriAl.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 9.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation
import Firebase

class RakipBilgileriAl:BilgileriAl {
    static func bilgileriAl() {
        
    }
    
    static func bilgileriAl(uid: String) {
        let ref=Database.database().reference()
        
        ref.child("users").child(uid).observeSingleEvent(of:.value, with: {(snapshot) in
            let userObject = snapshot.value as? [String: AnyObject]
            let winScore = userObject?["win"]
            let loseScore = userObject?["lose"]
            let image = userObject? ["image"]
            let nickname = userObject? ["nickname"]
            Rakip.getRakipNesne().id=snapshot.key
            Rakip.getRakipNesne().win=(winScore as? Int)!
            Rakip.getRakipNesne().lose=(loseScore as? Int)!
            Rakip.getRakipNesne().image=(image as? String)!
            Rakip.getRakipNesne().nickName=(nickname as? String)!
        })
    }
}
