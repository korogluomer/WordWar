//
//  Rakip.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 9.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation


class Rakip {
    
    var id:String?
    var adi:String?
    var soyadi:String?
    var win:Int?
    var lose:Int?
    var email:String?
    var nickName:String?
    var image:String?
    var enemy:String?
    
    
    static var nesneRakip:Rakip?=nil
    init(id:String?,adi:String?,soyadi:String?,email:String?,nickName:String?,image:String?,win:Int?,lose:Int?,enemy:String?) {
        self.id=id
        self.adi=adi
        self.soyadi=soyadi
        self.email=email
        self.nickName=nickName
        self.image=image
        self.win=win
        self.lose=lose
        self.enemy=enemy
    }
    static func getRakipNesne() -> Rakip{
        if nesneRakip==nil{
            nesneRakip=Rakip(id: "", adi: "", soyadi: "", email: "", nickName: "", image: "", win: 0, lose: 0,enemy:"bos")
        }
        return nesneRakip!
        
    }
}
