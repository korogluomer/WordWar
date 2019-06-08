//
//  KelimeDenemeController.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 30.04.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit
class KelimeDenemeController: UIViewController {

    @IBOutlet weak var kelimeOnay: UILabel!
    @IBOutlet weak var kelime: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func Dene(_ sender: Any) {
        let kelimeKontrol = KelimeKontrol()
        kelimeKontrol.kelimeKontrolEt(kelime: kelime.text!, fonksiyon: kontrolFunc)
        
    }
    func kontrolFunc(durum:Bool){
        if durum{
            kelimeOnay.textColor=#colorLiteral(red: 0, green: 0.8230092005, blue: 0.09701581118, alpha: 1)
            kelimeOnay.text=kelime.text
        }
        else{
            kelimeOnay.textColor=#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            kelimeOnay.text=kelime.text
        }
        print(durum)
    }
}
