//
//  RefGetir.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 13.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation
import Firebase

class RefGetir {
    private var ref:DatabaseReference!
    private var uid:String?
    
    init(uid:String) {
        self.uid=uid
    }
    
    func getUID() -> String {
        return uid!
    }
    
    func getRef() -> DatabaseReference {
        ref = Database.database().reference().child("users")
        return ref
    }
    
    func getRefUID() -> DatabaseReference {
        ref = Database.database().reference().child("users").child(uid!)
        return ref
    }
    func getRefTurn() -> DatabaseReference {
        ref = Database.database().reference().child("users").child(uid!).child("turn")
        return ref
    }
    func getRefScore() -> DatabaseReference {
        ref=Database.database().reference().child("users").child(uid!).child("score")
        return ref
    }
    func getRefWords() -> DatabaseReference {
        ref=Database.database().reference().child("users").child(uid!).child("words")
        return ref
    }
    func getRefHealth() -> DatabaseReference {
        ref=Database.database().reference().child("users").child(uid!).child("health")
        return ref
    }
    func getRefWin() -> DatabaseReference {
        ref=Database.database().reference().child("users").child(uid!).child("win")
        return ref
    }
    
    func getRefLose() -> DatabaseReference {
        ref=Database.database().reference().child("users").child(uid!).child("lose")
        return ref
    }
    func getRefStatus() -> DatabaseReference {
        ref=Database.database().reference().child("users").child(uid!).child("status")
        return ref
    }
    func getRefEnemy() -> DatabaseReference {
        ref=Database.database().reference().child("users").child(uid!).child("enemy")
        return ref
    }
}
