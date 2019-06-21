//
//  TurKontrol.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 13.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation
class TurKontrol: Game {
    let homeRef=RefGetir(uid: User.getUserNesne().id)
    func turKontrol() {
        homeRef.getRefTurn().observe(.value, with: {(snapshot) in
            self.btnSend.isEnabled = ((snapshot.value as? Bool)!)
            if (snapshot.value as? Bool)!{
                if !self.kelimeGeldiMi {
                    self.homeCharText.text = self.alfabe[Int.random(in: 0 ..< self.alfabe.count)].uppercased()
                    self.rakipCanKontrol()
                }
                self.timerProgress.progress = 1.0
                self.progressTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(GameController.updateProgressView), userInfo: nil, repeats: true)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                self.homeTableView.reloadData()
                self.awayTableView.reloadData()
            }
        })
    }
}
