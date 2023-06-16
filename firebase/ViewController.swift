//
//  ViewController.swift
//  firebase
//
//  Created by Çağdaş Sarıgil on 16.06.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var ref: DatabaseReference?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        //kisiEkle()
        //kisiSil()
        //kisiGuncelle()
        //verileriAl()
        kisiGetWhere()
    }


    func kisiEkle() {
        
        let kisi = Kisiler(kisi_ad: "Deniz", kisi_yas: 28)
        
        let dictionary: [String: Any] = ["kisi_ad": kisi.kisi_ad, "kisi_yas": kisi.kisi_yas]
        
        let newRef = ref?.child("kisiler").childByAutoId()

        newRef?.setValue(dictionary)
    }
    
    func kisiSil() {
        ref?.child("kisiler").child("-NY2ujULllSO_g8ljEXm").removeValue()
        // Kişi silmek için kisiler tablosundaki silmek istediğimiz verinin ID'sini kullanarak bu şekilde silebiliriz.
    }
    
    func kisiGuncelle() {
        
        let dictionary: [String: Any] = ["kisi_ad": "Deniz", "kisi_yas": 28]

        ref?.child("kisiler").child("-NY2ujULllSO_g8ljEXm").updateChildValues(dictionary
        )
        // Kişi silmek için kisiler tablosundaki güncellemek istediğimiz verinin ID'sini kullanarak bu şekilde güncelleyebiliriz.
    }
    
    func verileriAl() {
        
        ref?.child("kisiler").observe(.value, with: { snapshot in
            
            guard let veriler = snapshot.value as? [String: AnyObject] else { return }
            
            for veri in veriler {
                
                guard let json = veri.value as? NSDictionary else { return }
                
                let key = veri.key
                let kisi_ad = json["kisi_ad"] as? String ?? "Boş"
                let kisi_yas = json["kisi_yas"] as? Int ?? -1
                
                print("DEGUB PRINT ==>> \(key)")
                print("DEGUB PRINT ==>> \(kisi_ad)")
                print("DEGUB PRINT ==>> \(kisi_yas)")
            }
        })
    }
    
    func kisiGetWhere() {
        
        //select * from kisiler where kisi_ad = 'Çağdaş'
        let sorgu = ref?.child("kisiler").queryOrdered(byChild: "kisi_ad").queryEqual(toValue: "Çağdaş")
        
        sorgu?.observe(.value, with: { snapshot in
            
            guard let veriler = snapshot.value as? [String: AnyObject] else { return }
            
            for veri in veriler {
                
                guard let json = veri.value as? NSDictionary else { return }
                
                let key = veri.key
                let kisi_ad = json["kisi_ad"] as? String ?? "Boş"
                let kisi_yas = json["kisi_yas"] as? Int ?? -1
                
                print("DEGUB PRINT ==>> \(key)")
                print("DEGUB PRINT ==>> \(kisi_ad)")
                print("DEGUB PRINT ==>> \(kisi_yas)")
            }
        })
    }
}

