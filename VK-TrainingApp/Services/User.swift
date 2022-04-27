//
//  User.swift
//  VK-TrainingApp
//
//  Created by mac on 27.04.2022.
//

import Foundation

final class User {
    
    private init() {}
    
    static let shared = User() // лежит в глобальной памяти, существует всё приложение и можно в любом месте вызвать
    
    var userID: String = ""
    var token: String = ""
    var expiresIn: String = ""
}
