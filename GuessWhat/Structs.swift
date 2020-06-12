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
    static var selectedImage: UIImage = UIImage(named: "")!
    static var selectedName: String = ""
}

struct wordAnswered {
    var word: String
    var correct: Bool
}
