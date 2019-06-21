//
//  RakipAraniyorController.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 1.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit
import Firebase
class RakipAraniyorController: UIViewController {

    @IBOutlet weak var rankImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        Database.database().reference().child("users").child(User.getUserNesne().id).child("status").setValue("araniyor")
        
        let kd:Double=Double(User.getUserNesne().win)/(Double(User.getUserNesne().lose+1)/2)
        print(kd)
        switch kd {
        case 10...30:
            rankImage.image=UIImage(named: "5")
        case 5...10:
            rankImage.image=UIImage(named: "4")
        case 3...5:
            rankImage.image=UIImage(named: "3")
        case 2...3:
            rankImage.image=UIImage(named: "2")
        case 1...2:
            rankImage.image=UIImage(named: "1")
        default:
            rankImage.image=UIImage(named: "0")
        }
        RakipBul.RakipAra(fonk: self.ekranGecis)
    }
    
    func ekranGecis(){
        let ekranGecis = EkranGecis()
        ekranGecis.gecisYap(storyboardId: "VersusScreen", viewCont: self)
    }
    

}
