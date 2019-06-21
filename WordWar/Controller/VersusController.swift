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
    var user:User=User.getUserNesne()
    var rakip:Rakip=Rakip.getRakipNesne()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: URL(string: self.user.image)!){
                let image = UIImage(data: data)
                self.homeImage.image = image
            }
            if self.rakip.image != "" {
                if let data = try? Data(contentsOf: URL(string: self.rakip.image)!){
                    let image = UIImage(data: data)
                    self.awayImage.image = image
                    return
                }
            }
        }
        homeID.text=User.getUserNesne().nickName
        awayID.text=Rakip.getRakipNesne().nickName
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5.0){
            let ekranGecis = EkranGecis()
            ekranGecis.gecisYap(storyboardId: "GameScreen", viewCont: self)
        }
    }

}
