//
//  Kullanicilar.swift
//  WordWar
//
//  Created by Ömer Köroğlu on 13.06.2019.
//  Copyright © 2019 Ömer Köroğlu. All rights reserved.
//

import Foundation

protocol Kullanicilar {
    var id:String {get}
    var win:Int {get}
    var lose:Int {get}
    var nickName:String {get}
    var image:String {get}
}
