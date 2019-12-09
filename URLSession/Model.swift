//
//  MODEL.swift
//  URLSession
//
//  Created by Дмитрий Тараканов on 08.12.2019.
//  Copyright © 2019 Dmitry Angarsky. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    let userId: Int
    let id:     Int
    let title:  String
    let body:   String
}
