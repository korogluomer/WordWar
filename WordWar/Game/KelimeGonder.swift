//
//  KelimeGonder.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 13.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation

class KelimeGonder: Game {
    func kelimeEkle(durum:Bool)  {
        if durum && kelime.prefix(1) == String(homeCharText.text!).lowercased() && !homeWords.contains(kelime) && !awayWords.contains(kelime) {
            let keyTime:Int = Int(NSDate().timeIntervalSince1970 * 1000.rounded())
            homeRef.getRefWords().child(String(keyTime)).setValue(kelime)
            
            turDegis()
        }
        else{
            print("Kelime yanlış veya daha önceden girilmiş!")
        }
    }
}
