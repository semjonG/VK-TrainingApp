//
//  User.swift
//  VK-TrainingApp
//
//  Created by mac on 27.04.2022.
//

import Foundation

final class Session {
    
    private init() {} // закрытый инициализатор
    
    static let shared = Session() // лежит в глобальной памяти, существует всё приложение и можно в любом месте вызвать
    
    var userID: Int = 0
    var token: String = ""
    var expiresIn: Int = 0 // unix time
    
    #warning("изучить юникстайм в свифт")
}
