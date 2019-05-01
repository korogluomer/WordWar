//
//  KayitOlController.swift
//
//
//  Created by Ömer Köroğlu on 30.04.2019.
//

import UIKit
import FirebaseAuth
class KayitOlController: UIViewController {
    
    @IBOutlet weak var kullaniciAdi: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var sifre: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func KayitOl(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: sifre.text!) { authResult, error in
            if error != nil{
                print("*******************")
            }
            else{
                print(authResult?.user.email! ?? "Email Yok")
            }
        }
    }
    
}
