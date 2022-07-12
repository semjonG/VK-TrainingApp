//
//  PostCellModel.swift
//  VK-TrainingApp
//
//  Created by mac on 12.07.2022.
//

import Foundation

//Cell Model - это модель подготовленная под ячейки (финальная модель для ячейки)
struct PostCellModel {
    
    var authorImageUrl: String //подсовываем profile.image, group.image
    var authorName: String
    var text: String
    var photoUrl: String
    var likesCount: Int
}
