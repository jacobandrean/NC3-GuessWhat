//
//  Structs.swift
//  GuessWhat
//
//  Created by Jacob Andrean on 11/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import Foundation
import UIKit

struct Categories {
    let categoryImage: UIImage
    let categoryName: String
}

struct GlobalVariables {
    static var selectedCategory: String = ""
    static var answerList = [Bool]()
    static var trueAnswer = 0
}

struct wordAnswered {
    var word: String
    var correct: Bool
}
