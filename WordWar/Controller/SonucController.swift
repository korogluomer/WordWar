//
//  SonucController.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 11.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit
import Firebase

class SonucController: UIViewController {

    @IBOutlet weak var awayImage: UIImageView!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayNickname: UILabel!
    @IBOutlet weak var awayWinRate: UILabel!
    @IBOutlet weak var awayRank: UIImageView!
    @IBOutlet weak var awayResult: UILabel!
    @IBOutlet weak var homeResult: UILabel!
    @IBOutlet weak var homeRank: UIImageView!
    @IBOutlet weak var homeWinRate: UILabel!
    @IBOutlet weak var homeNickname: UILabel!
    let ref=Database.database().reference().child("users")
    let user:User=User.getUserNesne()
    let rakip:Rakip = Rakip.getRakipNesne()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: URL(string: self.user.image)!){
                let image = UIImage(data: data)
                self.homeImage.image = image
            }
            if let data = try? Data(contentsOf: URL(string: self.rakip.image)!){
                let image = UIImage(data: data)
                self.awayImage.image = image
                return
            }
        }
        nicknameGetir()
        winRateGetir()
        rankGetir()
        sonucGetir()
    }
    
    func nicknameGetir() -> Void {
        homeNickname.text=user.nickName
        awayNickname.text=rakip.nickName
    }
    func winRateGetir() -> Void {
        homeWinRate.text="\(user.win)/\(user.lose)"
        awayWinRate.text="\(rakip.win)/\(rakip.lose)"
    }
    func rankGetir() -> Void {
        
        var kd:Double=Double(user.win)/(Double(user.lose+1)/2)
        switch kd {
        case 10...30:
            homeRank.image=UIImage(named: "5")
        case 5...10:
            homeRank.image=UIImage(named: "4")
        case 3...5:
            homeRank.image=UIImage(named: "3")
        case 2...3:
            homeRank.image=UIImage(named: "2")
        case 1...2:
            homeRank.image=UIImage(named: "1")
        default:
            homeRank.image=UIImage(named: "0")
        }
        
        kd=Double(rakip.win)/(Double(rakip.lose+1)/2)
        switch kd {
        case 10...30:
            awayRank.image=UIImage(named: "5")
        case 5...10:
            awayRank.image=UIImage(named: "4")
        case 3...5:
            awayRank.image=UIImage(named: "3")
        case 2...3:
            awayRank.image=UIImage(named: "2")
        case 1...2:
            awayRank.image=UIImage(named: "1")
        default:
            awayRank.image=UIImage(named: "0")
        }
    }
    
    func sonucGetir() -> Void {
        skorGetir(uid: user.id,scoreText: homeScore)
        skorGetir(uid: rakip.id,scoreText: awayScore)
    }
    func skorGetir(uid:String,scoreText:UILabel) {
        ref.child(uid).child("score").observeSingleEvent(of: .value, with: {(snapshot) in
            scoreText.text=String(snapshot.value as! Int)
            self.ref.child(User.getUserNesne().id).child("health").removeValue()
            self.ref.child(User.getUserNesne().id).child("turn").removeValue()
            self.ref.child(User.getUserNesne().id).child("words").removeValue()
            self.ref.child(User.getUserNesne().id).child("enemy").setValue("bos")
            User.getUserNesne().enemy="bos"
        })
        
        
        
    }
    @IBAction func geriDon(_ sender: Any) {
        self.ref.child(User.getUserNesne().id).child("score").removeValue()
        
        let ekranGecis = TabBarGecis()
        ekranGecis.gecisYap(storyboardId: "TabBar", viewCont: self)
    }
    
}
