//
//  ScoreboardViewCell.swift
//  GuessWhat
//
//  Created by Alnodi Adnan on 12/06/20.
//  Copyright © 2020 Jacob Andrean. All rights reserved.
//

import UIKit

class ScoreboardViewCell: UITableViewCell {

    @IBOutlet weak var wordAnsweredLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with answer: wordAnswered){
        wordAnsweredLabel.text = answer.word
        if answer.correct {
            wordAnsweredLabel.textColor = .white
        }
        else {
            wordAnsweredLabel.textColor = .darkGray
        }
    }
    
}
