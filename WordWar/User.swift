//
//  User.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 31.05.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation

class User {
    
    var id:String?
    var name:String?
    var win:Int?
    var lose:Int?
    var email:String?
    var nickName:String?
    var image:String?
    var enemy:String?
    
    
    static var nesneUser:User?=nil
    init(id:String?,name:String?,email:String?,nickName:String?,image:String?,win:Int?,lose:Int?,enemy:String?) {
        self.id=id
        self.name=name
        self.email=email
        self.nickName=nickName
        self.image=image
        self.win=win
        self.lose=lose
        self.enemy=enemy
    }
    static func getUserNesne() -> User{
        if nesneUser==nil{
            nesneUser=User(id: "", name: "", email: "", nickName: "", image: "", win: 0, lose: 0,enemy:"bos")
        }
        return nesneUser!
        
    }
}

