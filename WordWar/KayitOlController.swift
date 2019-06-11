//
//  KayitOlController.swift
//
//
//  Created by Ömer Köroğlu on 30.04.2019.
//

import UIKit
import Firebase
class KayitOlController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var resim: UIImageView!
    @IBOutlet weak var adSoyad: UITextField!
    @IBOutlet weak var kullaniciAdi: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var sifre: UITextField!
    var ref: DatabaseReference!
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference().child("users")
    }
    @IBAction func KayitOl(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: sifre.text!) { authResult, error in
            if error == nil{
                self.ref.child((authResult?.user.uid)!).child("status").setValue("online")
                self.ref.child((authResult?.user.uid)!).child("enemy").setValue("bos")
                self.ref.child((authResult?.user.uid)!).child("win").setValue(0)
                self.ref.child((authResult?.user.uid)!).child("lose").setValue(0)
                self.ref.child((authResult?.user.uid)!).child("name").setValue(self.adSoyad.text!)
                self.ref.child((authResult?.user.uid)!).child("nickname").setValue(self.kullaniciAdi.text!)
                
                var data = Data()
                data = (self.resim.image?.jpegData(compressionQuality: 0.75))!
                
                let imageRef=Storage.storage().reference().child("images/\(authResult!.user.uid).jpg")
                
                imageRef.putData(data, metadata: nil){(metadata,error) in
                    guard metadata != nil else{
                        
                        let alert = UIAlertController(title: "Uyarı!", message: "Hata Oluştu", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "TAMAM", style: .default, handler: nil))
                        
                        self.present(alert, animated: true)
                        return
                    }
                    imageRef.downloadURL { (url, error) in
                        guard url != nil else {
                            // Uh-oh, an error occurred!
                            return
                        }
                        self.ref.child((authResult?.user.uid)!).child("image").setValue(url!.absoluteString)
                        
                        let myTabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")    as! UITabBarController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = myTabBar
                        appDelegate.window?.makeKeyAndVisible()
                    }
                }
                
                
                
            }
            else{
                let alert = UIAlertController(title: "Uyarı!", message: "E-Posta'ya ait hesap bulunmaktadır.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "TAMAM", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
        }
    }
    @IBAction func ResimSec(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        resim.image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
        dismiss(animated: true, completion: nil)
    }
    
    
}
