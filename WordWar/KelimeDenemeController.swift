//
//  KelimeDenemeController.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 30.04.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit
import FirebaseDatabase
class KelimeDenemeController: UIViewController {

    @IBOutlet weak var kelimeOnay: UILabel!
    @IBOutlet weak var kelime: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    var ref: DatabaseReference!
    
    
    
    @IBAction func Dene(_ sender: Any) {
        ref = Database.database().reference()
        var sozcuk:String = kelime.text!
        sozcuk = String(sozcuk.prefix(1))
        ref.child("words").child(sozcuk.lowercased()).child((kelime.text?.lowercased())!).observeSingleEvent(of: .value, with: {(data)	in
            let word = data.value as? String
            if word != nil{
                self.kelimeOnay.text = word ?? "kelime yok"
                self.kelimeOnay.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            }
            else{
                self.kelimeOnay.text = self.kelime.text!
                self.kelimeOnay.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            }
        })
    }
}
