//
//  Structs.swift
//  GuessWhat
//
//  Created by Jacob Andrean on 11/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

struct Categories {
    let categoryImage: UIImage
    let categoryName: String
}

struct GlobalVariables {
    static var selectedCategory: String = ""
    static var answerIsTrue = [Bool]()
    static var trueAnswer = 0
    static var mainMenuAudioPlayer : AVAudioPlayer!
    static var mainMenuSoundPlayed : Bool!
}


