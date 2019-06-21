//
//  KelimeKontrol.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 29.05.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import FirebaseDatabase

class KelimeKontrol:Game {

    init(){}
    
    var ref:DatabaseReference!
    func kelimeKontrolEt(kelime:String,fonksiyon: @escaping (Bool)->Void) {
        ref=Database.database().reference()
        let harf:String = String(kelime.prefix(1)); ref.child("words").child(harf.lowercased()).child(kelime.lowercased()).observeSingleEvent(of: .value, with: {(data) in
            let word = data.value as? String
            if word != nil{
                fonksiyon(true)
            }
            else{
                fonksiyon(false)
            }
        })
        
    }
}
