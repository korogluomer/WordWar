//
//  TabBarGecis.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 13.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation
import UIKit

class TabBarGecis: EkranGecis {
    override func gecisYap(storyboardId:String,viewCont:UIViewController){
        
        let myTabBar = viewCont.storyboard?.instantiateViewController(withIdentifier: storyboardId) as! UITabBarController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = myTabBar
        appDelegate.window?.makeKeyAndVisible()
    }
}
