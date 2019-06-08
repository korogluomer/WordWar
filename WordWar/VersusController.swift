//
//  VersusController.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 1.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit

class VersusController: UIViewController {

    @IBOutlet weak var homeID: UILabel!
    @IBOutlet weak var awayID: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        homeID.text=RakipBul.homeUID!
        awayID.text=RakipBul.awayUID!
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0){
            let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "GameScreen")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.makeKeyAndVisible()
            appDelegate.window?.rootViewController = myTabBar
        }
    }

}
