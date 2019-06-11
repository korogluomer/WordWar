//
//  UserResimCek.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 9.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation
import Firebase

class UserResimCek {
    var resim:UIImage!
    let ref=Database.database().reference().child("users")
    func resimCek(uid:String!) -> UIImage {
        ref.child(uid).child("image").observeSingleEvent(of: .value, with: {(snapshot) in
            print(((snapshot.value as? String)!))
            /*if let data = try? Data(contentsOf: URL(string: (snapshot.value as? String)!)!){
                self.resim = UIImage(data:data )
            }*/
        })
        if resim != nil {
            return resim
        }else{
            
            return UIImage(named: "User")!
        }
    }
}
