//
//  VersusController.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 1.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit

class VersusController: UIViewController {

    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var awayImage: UIImageView!
    @IBOutlet weak var homeID: UILabel!
    @IBOutlet weak var awayID: UILabel!
    var user:User!
    var rakip:Rakip!
    override func viewDidLoad() {
        super.viewDidLoad()
        user=User.getUserNesne()
        rakip=Rakip.getRakipNesne()
        

        homeID.text=RakipBul.homeUID!
        awayID.text=RakipBul.awayUID!
        
        /*DispatchQueue.main.async {
            if let data = try? Data(contentsOf: URL(string: self.user.image!)!){
                let image = UIImage(data: data)
                self.homeImage.image = image
            }
        }*/
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5.0){
            let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "GameScreen")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.makeKeyAndVisible()
            appDelegate.window?.rootViewController = myTabBar
        }
    }

}
