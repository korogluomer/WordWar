//
//  ViewController.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 30.04.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Use Firebase library to configure APIs
        FirebaseApp.configure()
    }
    
}

