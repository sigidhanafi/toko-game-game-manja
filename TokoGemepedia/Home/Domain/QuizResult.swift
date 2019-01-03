//
//  QuizResult.swift
//  TokoGemepedia
//
//  Created by Digital Khrisna on 03/01/19.
//  Copyright © 2019 TokoGemepedia. All rights reserved.
//

import Foundation

struct QuizResult: Codable {
    let quizes: [Quize]
}

struct Quize: Codable {
    let title, image: String
    let resultArray: [ResultArray]
    var questions: [Question]
    
    enum CodingKeys: String, CodingKey {
        case title, image
        case resultArray = "result_array"
        case questions
    }
}

struct Question: Codable {
    let image, name: String
    let options: [Option]
}

struct Option: Codable {
    let answer: String
    let value: Int
    let keyword: [String]
}

struct ResultArray: Codable {
    let min, max: Int
    let result, desc: String
}

