//
//  GirisYapController.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 8.05.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class GirisYapController: UIViewController {
    
    var ref:DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var sifre: UITextField!
    @IBAction func GirisYap(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: sifre.text!){
            user,error in
            if user != nil {
                
                let ekranGecis = TabBarGecis()
                ekranGecis.gecisYap(storyboardId: "TabBar", viewCont: self)
                self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("status").setValue("online")
            }
            else {
                print("Şifre hatalı")
            }
        }
        
    }
}
