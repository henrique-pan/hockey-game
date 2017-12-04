//
//  StadiumViewController.swift
//  hockey-game
//
//  Created by eleves on 2017-12-04.
//  Copyright © 2017 com.henrique. All rights reserved.
//

import UIKit

class StadiumViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var labelPlayer1: UILabel!
    @IBOutlet weak var labelPlayer2: UILabel!
    @IBOutlet weak var labelPrize: UILabel!
    @IBOutlet weak var buttonPlayer1: UIButton!
    @IBOutlet weak var buttonPlayer2: UIButton!
    //MARK: Outlets
    
    var player1: String!
    var player2: String!
    var prize: String!
    
    var selectedPlayer: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelPlayer1.text = player1
        labelPlayer2.text = player2
        labelPrize.text = prize
        
        buttonPlayer1.layer.cornerRadius = 5
        buttonPlayer1.layer.borderWidth = 1
        buttonPlayer1.layer.borderColor = UIColor.black.cgColor
        
        buttonPlayer2.layer.cornerRadius = 5
        buttonPlayer2.layer.borderWidth = 1
        buttonPlayer2.layer.borderColor = UIColor.black.cgColor
        
        choosePlayer()
        if selectedPlayer == 0 {
            buttonPlayer2.isEnabled = false
        } else {
            buttonPlayer1.isEnabled = false
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func choosePlayer() {
        selectedPlayer = Int(arc4random_uniform(2))
    }
    
    @IBAction func play(_ sender: UIButton) {
        if buttonPlayer1.isEnabled {
            buttonPlayer1.isEnabled = false
            buttonPlayer2.isEnabled = true
        } else {
            buttonPlayer2.isEnabled = false
            buttonPlayer1.isEnabled = true
        }
    }
}
