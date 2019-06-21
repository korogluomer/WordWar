//
//  ProfilController.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 8.05.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit
import Firebase


class ProfilController: UIViewController {

    var window: UIWindow?
    var ref:DatabaseReference!
    var user:User!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var resim: UIImageView!
    @IBOutlet weak var adSoyadText: UILabel!
    @IBOutlet weak var loseText: UILabel!
    @IBOutlet weak var winText: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var uid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        user=User.getUserNesne()
        
        adSoyadText.text="\(user.name!)"
        email.text=user.email!
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: URL(string: self.user.image)!){
                let image = UIImage(data: data)
                self.resim.image = image
                return
            }
        }
        loseText.text=String(user.lose)
        winText.text=String(user.win)
        nickname.text=String(user.nickName)
        
    }
    
    
    @IBAction func CikisYap(_ sender: Any) {
        do{
            self.ref.child("users").child((Auth.auth().currentUser?.uid)!).child("status").setValue("offline")
            try Auth.auth().signOut()        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
