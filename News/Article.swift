//
//  Article.swift
//  News
//
//  Created by Истина on 09/05/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit

struct Root : Decodable {
    let status : String
    let articles : [Article]
}

struct Article : Decodable {
    let source: Source
    let author, title, description: String?
    let urlToImage: String?
}

struct Source: Decodable {
    let id, name: String
}
