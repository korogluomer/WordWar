//
//  RakipBul.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 1.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation
import Firebase
class RakipBul:Game {
    
    static func RakipAra(fonk:@escaping ()->Void) {
        
        
        let homeRef=RefGetir(uid: (Auth.auth().currentUser?.uid)!)
        var awayRef:RefGetir!
        var arr = [String]()
        if User.getUserNesne().enemy == "bos"{
            homeRef.getRef().queryOrdered(byChild: "status").queryEqual(toValue: "araniyor").observe(.value, with: {(snapshot:DataSnapshot) in
                if snapshot.childrenCount-1 > 0{
                    
                    for snap in snapshot.children{
                        if ((snap as? DataSnapshot)?.key)! != homeRef.getUID(){
                            arr.append(((snap as? DataSnapshot)?.key)!)
                        }
                    }
                    let number=Int.random(in: 0 ..< arr.count)
                    awayRef=RefGetir(uid: arr[number])
                    homeRef.getRef().removeAllObservers()
                    if awayRef != nil{
                        RakipBilgileriAl.bilgileriAl(uid: awayRef.getUID())
                        homeRef.getRefStatus().setValue("oyunda")
                        awayRef.getRefStatus().setValue("oyunda")
                        homeRef.getRefEnemy().setValue(awayRef.getUID())
                        awayRef.getRefEnemy().setValue(homeRef.getUID())
                        User.getUserNesne().enemy = awayRef.getUID()
                        
                        homeRef.getRefScore().setValue(0)
                        homeRef.getRefHealth().setValue(3)
                        awayRef.getRefScore().setValue(0)
                        awayRef.getRefHealth().setValue(3)
                        homeRef.getRefTurn().setValue(true)
                        awayRef.getRefTurn().setValue(false)
                        fonk()
                    }
                }
                
            })
        }
        else{
            homeRef.getRefUID().removeAllObservers()
            awayRef=RefGetir(uid: User.getUserNesne().enemy!)
            RakipBilgileriAl.bilgileriAl(uid: User.getUserNesne().enemy!)
            if User.getUserNesne().enemy != "bos"{
                fonk()
            }
        }
        
        
    }
}
