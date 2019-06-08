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
    static func RakipAra(fonk:@escaping ()->Void) {
        
        let ref=Database.database().reference().child("users").queryOrdered(byChild: "status").queryEqual(toValue: "araniyor")
        
        self.homeUID=Auth.auth().currentUser?.uid
        var arr = [String]()
        if User.getUserNesne().enemy == "bos"{
            ref.observe(.value, with: {(snapshot:DataSnapshot) in
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
                        Database.database().reference().child("users").child(homeUID).child("status").setValue("oyunda")
                        Database.database().reference().child("users").child(awayUID).child("status").setValue("oyunda")
                        Database.database().reference().child("users").child(homeUID).child("enemy").setValue(awayUID)
                        Database.database().reference().child("users").child(awayUID).child("enemy").setValue(homeUID)
                        User.getUserNesne().enemy = awayUID
                        
                        Database.database().reference().child("users").child(homeUID).child("score").setValue(0)
                        Database.database().reference().child("users").child(homeUID).child("health").setValue(3)
                        //Database.database().reference().child("users").child(homeUID).child("words").removeValue()
                        
                        fonk()
                    }
                }
                
            })
        }
        else{
            ref.removeAllObservers()
            awayUID = User.getUserNesne().enemy
            if awayUID != nil{
                fonk()
            }
        }
        
        
    }
}
