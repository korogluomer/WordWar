//
//  Rakip.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 9.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation


class Rakip:Kullanicilar {
    var id: String
    
    var win: Int
    
    var lose: Int
    
    var nickName: String
    
    var image: String
    
    static var nesneRakip:Rakip?=nil
    
    init(id:String?,nickName:String?,image:String?,win:Int?,lose:Int?) {
        self.id=id!
        self.nickName=nickName!
        self.image=image!
        self.win=win!
        self.lose=lose!
    }
    static func getRakipNesne() -> Rakip{
        if nesneRakip==nil{
            nesneRakip=Rakip(id: "", nickName: "", image: "", win: 0, lose: 0)
        }
        return nesneRakip!
        
    }
}
