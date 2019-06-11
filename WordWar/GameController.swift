//
//  GameController.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 2.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import UIKit
import Firebase

class GameController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView==homeTableView{
            return homeWords.count
        }
        else{
            return awayWords.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "tablecell")
        if tableView==homeTableView{
            var homeWordsReversed = homeWords
            homeWordsReversed.reverse()
            cell.textLabel?.text = homeWordsReversed[indexPath.row]
            cell.detailTextLabel?.text = String((cell.textLabel?.text?.count)!)
        }
        if tableView==awayTableView {
            var awayWordsReversed = awayWords
            awayWordsReversed.reverse()
            cell.textLabel?.text = awayWordsReversed[indexPath.row]
            cell.detailTextLabel?.text = String((cell.textLabel?.text?.count)!)
        }
        cell.backgroundColor = #colorLiteral(red: 0.8620520618, green: 0.9143202728, blue: 0.8873466035, alpha: 0.3)
        cell.selectionStyle = .none
        
        return cell
    }
    var homeScorePoint=0
    var awayScorePoint=0
    var kelime:String! = ""
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var timerProgress: UIProgressView!
    @IBOutlet weak var awayTableView: UITableView!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var awayUserName: UILabel!
    @IBOutlet weak var homeUserName: UILabel!
    @IBOutlet weak var btnSend: UIButton!
    var awayWords = [String]()
    var homeWords = [String]()
    var tur:Bool!
    var alfabe:[String]! = ["a","b","c","ç","d","e","f","g","h","i","j","k","l","m","n","o","ö","p","r","s","ş","t","u","ü","v","y","z"]
    var kelimeGeldiMi:Bool! = false
    var can:Int = 3
    
    
    @IBOutlet weak var awayCharText: UILabel!
    @IBOutlet weak var homeCharText: UILabel!
    
    @IBOutlet weak var bgHome: UILabel!
    @IBOutlet weak var bgAway: UILabel!
    
    
    @IBAction func button(_ sender: Any) {
        kelime=textField.text!
        let k=KelimeKontrol()
        k.kelimeKontrolEt(kelime: kelime, fonksiyon: kelimeEkle)
        textField.text = nil
    }
    let ref=Database.database().reference().child("users")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        turKontrol()
        homeTableView.delegate = self
        homeTableView.dataSource = self
        awayTableView.delegate = self
        awayTableView.dataSource = self
        
        timerProgress.transform = timerProgress.transform.scaledBy(x: 1, y: 3)
        timerProgress.progress = 1.0
        
        homeCharText.text = alfabe[Int.random(in: 0 ..< alfabe.count)].uppercased()
        awayCharText.text = nil
        
        homeUserName.text = User.getUserNesne().id
        awayUserName.text = User.getUserNesne().enemy
        kelimeDoldur()
    }
    
    func kelimeEkle(durum:Bool)  {
        if durum && kelime.prefix(1) == String(homeCharText.text!).lowercased() && !homeWords.contains(kelime) && !awayWords.contains(kelime) {
            let keyTime:Int = Int(NSDate().timeIntervalSince1970 * 1000.rounded())
            ref.child(User.getUserNesne().id!).child("words").child(String(keyTime)).setValue(kelime)
            
            turDegis()
        }
        else{
            print("kelime yanlış")
        }
    }

    func kelimeDoldur() {
        homeWords.removeAll()
        awayWords.removeAll()
        ref.child(User.getUserNesne().id!).child("words").observe(.childAdded, with: {(snapshot) in
            self.homeWords.append(snapshot.value as! String)
            self.homeScorePoint+=((snapshot.value as? String)?.count)!
            self.ref.child(User.getUserNesne().id!).child("score").setValue(self.homeScorePoint)
            self.homeScore.text = String(self.homeScorePoint)
            self.homeTableView.reloadData()
            self.awayCharText.text = String((self.kelime?.suffix(1))!).uppercased()
            self.skorKontrol()
        })
        
        ref.child(User.getUserNesne().enemy!).child("words").observe(.childAdded, with: {(snaphot) in
            self.awayWords.append(snaphot.value as! String)
            self.awayScorePoint+=((snaphot.value as? String)?.count)!
            self.awayScore.text = String(self.awayScorePoint)
            self.awayTableView.reloadData()
            self.homeCharText.text = String((snaphot.value as! String).suffix(1)).uppercased()
            self.kelimeGeldiMi = true
            self.skorKontrol()
        })
    }
    
    
    func turKontrol() {
        ref.child(User.getUserNesne().id!).child("turn").observe(.value, with: {(snapshot) in
            self.btnSend.isEnabled = ((snapshot.value as? Bool)!)
            if (snapshot.value as? Bool)!{
                if !self.kelimeGeldiMi {
                    self.homeCharText.text = self.alfabe[Int.random(in: 0 ..< self.alfabe.count)].uppercased()
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
    
    func turDegis() {
        ref.child(User.getUserNesne().enemy!).child("turn").setValue(true)
        ref.child(User.getUserNesne().id!).child("turn").setValue(false)
        btnSend.isEnabled = false
        kelimeGeldiMi = false
        progressTimer.invalidate()
        progressTimer = nil
    }
    
    var progressTimer:Timer!
    
    @objc func updateProgressView(){
        timerProgress.progress -= 0.03
        timerProgress.setProgress(timerProgress.progress, animated: true)
        if(timerProgress.progress == 0.0){
            can -= 1
            ref.child(User.getUserNesne().id!).child("health").setValue(can)
            canKontrol()
            turDegis()
        }
    }
    
    func skorKontrol() {
        if Int(homeScore.text!)! >= 100{
            oyunuBitir()
        }
        else if Int(awayScore.text!)! >= 100{
            oyunuBitir()
        }
    }
    
    func canKontrol() {
        ref.child(User.getUserNesne().id!).child("health").observeSingleEvent(of: .value, with: {(snapshot) in
            self.can = ((snapshot.value as? Int)!)
            if self.can == 0{
                print("oyun bitti")
            }
        })
    }
    
    func oyunuBitir() {
        ref.child(User.getUserNesne().id!).child("turn").removeAllObservers()
        ref.child(User.getUserNesne().id!).child("words").removeAllObservers()
        ref.child(User.getUserNesne().enemy!).child("words").removeAllObservers()
        progressTimer.invalidate()
        let mySonucScreen = self.storyboard?.instantiateViewController(withIdentifier: "SonucScreen")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.makeKeyAndVisible()
        appDelegate.window?.rootViewController = mySonucScreen
    }
}
