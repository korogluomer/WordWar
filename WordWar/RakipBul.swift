//
//  RakipBul.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 1.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation
import Firebase
class RakipBul {
    
    static var homeUID:String!
    static var awayUID:String!
    static var ref=Database.database().reference().child("users")
    static func RakipAra(fonk:@escaping ()->Void) {
        
        
        self.homeUID=Auth.auth().currentUser?.uid
        var arr = [String]()
        if User.getUserNesne().enemy == "bos"{
            self.ref.queryOrdered(byChild: "status").queryEqual(toValue: "araniyor").observe(.value, with: {(snapshot:DataSnapshot) in
                if snapshot.childrenCount-1 > 0{
                    
                    for snap in snapshot.children{
                        if ((snap as? DataSnapshot)?.key)! != homeUID{
                            arr.append(((snap as? DataSnapshot)?.key)!)
                        }
                    }
                    let number=Int.random(in: 0 ..< arr.count)
                    self.awayUID=arr[number]
                    ref.removeAllObservers()
                    if awayUID != nil{
                        RakipBilgileriAl.bilgileriAl(uid: awayUID!)
                        self.ref.child(homeUID).child("status").setValue("oyunda")
                        self.ref.child(awayUID).child("status").setValue("oyunda")
                        self.ref.child(homeUID).child("enemy").setValue(awayUID)
                        self.ref.child(awayUID).child("enemy").setValue(homeUID)
                        User.getUserNesne().enemy = awayUID
                        
                        self.ref.child(homeUID).child("score").setValue(0)
                        self.ref.child(homeUID).child("health").setValue(3)
                        self.ref.child(awayUID).child("score").setValue(0)
                        self.ref.child(awayUID).child("health").setValue(3)
                        self.ref.child(homeUID).child("turn").setValue(true)
                        self.ref.child(awayUID).child("turn").setValue(false)
                        
                        //Database.database().reference().child("users").child(homeUID).child("words").removeValue()
                        
                        fonk()
                    }
                }
                
            })
        }
        else{
            ref.removeAllObservers()
            awayUID = User.getUserNesne().enemy
            RakipBilgileriAl.bilgileriAl(uid: awayUID!)
            if awayUID != nil{
                fonk()
            }
        }
        
        
    }
}
