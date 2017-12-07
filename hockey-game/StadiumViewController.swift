//
//  StadiumViewController.swift
//  hockey-game
//
//  Created by Henrique Nascimento on 2017-12-04.
//  Copyright © 2017 com.henrique. All rights reserved.
//

import UIKit

// ViewController that represents the stadium
class StadiumViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var labelPlayer1: UILabel!
    @IBOutlet weak var labelPlayer2: UILabel!
    @IBOutlet weak var labelPrize: UILabel!
    @IBOutlet weak var buttonPlayer1: UIButton!
    @IBOutlet weak var buttonPlayer2: UIButton!
    @IBOutlet weak var imageDisk: UIImageView!
    @IBOutlet weak var imageHockeyField: UIImageView!
    //MARK: Outlets
    
    var player1: String!
    var player2: String!
    var prize: String!
    
    var selectedPlayer: Int!
    
    // Disk control
    var degrees: Double!
    var cos: Double!
    var sin: Double!
    var aTimer: Timer!
    var distance = 0.0
    // Disk control
    
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
            buttonPlayer2.alpha = 0.3
        } else {
            buttonPlayer1.isEnabled = false
            buttonPlayer1.alpha = 0.3
        }
        starDisk()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func choosePlayer() {
        selectedPlayer = Int(arc4random_uniform(2))
    }
    
    func starDisk() {
        imageDisk.layer.cornerRadius = 12.5        
    }
    
    @IBAction func endGame(_ sender: UIButton) {
        let alert = UIAlertController(title: NSLocalizedString("Attention", comment: ""),
                                      message: NSLocalizedString("Voulez-vous terminer le match?", comment: ""),
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: ""), style: UIAlertActionStyle.default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: ""), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    var counter = 0
    @IBAction func play(_ sender: UIButton) {
        if aTimer == nil {
            if buttonPlayer1.isEnabled {
                degrees = Double(Int.random(lowerBound: (315 + counter), upperBound: (375 - counter)))
                cos = __cospi(-degrees/180)
                sin = __sinpi(-degrees/180)
            } else {
                degrees = Double(Int.random(lowerBound: (135 + counter), upperBound: (225 - counter)))
                cos = __cospi(-degrees/180)
                sin = __sinpi(-degrees/180)
            }
            
            aTimer = Timer.scheduledTimer(timeInterval: 0.003, target: self, selector: #selector(doAnimation), userInfo: nil, repeats: true)
            counter += 2
        }
    }
    
    @objc func doAnimation() {
        distance += 1
        
        if distance >= Double(imageHockeyField.bounds.width/1.8) {
            aTimer.invalidate()
            if ((degrees <= 363 && degrees >= 357) || (degrees <= 183 && degrees >= 177))  {
                let winner: String
                let looser: String
                
                if buttonPlayer2.isEnabled {
                    winner = player2
                    looser = player1
                } else {
                    winner = player1
                    looser = player2
                }
                
                let alert = UIAlertController(title: NSLocalizedString("Fin de Jeux!", comment: ""),
                                              message: NSLocalizedString("\(looser) doit payer \(prize!.lowercased()) à \(winner)", comment: ""),
                                              preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertActionStyle.default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            } else {
                aTimer = nil
                distance = 0
                
                imageDisk.center.x = UIScreen.main.bounds.width/2
                imageDisk.center.y = ((imageHockeyField.frame.size.height / 2) + imageHockeyField.frame.origin.y)
                
                if buttonPlayer1.isEnabled {
                    buttonPlayer1.isEnabled = false
                    buttonPlayer1.alpha = 0.3
                    buttonPlayer2.isEnabled = true
                    buttonPlayer2.alpha = 1.0
                } else {
                    buttonPlayer2.isEnabled = false
                    buttonPlayer2.alpha = 0.3
                    buttonPlayer1.isEnabled = true
                    buttonPlayer1.alpha = 1.0
                }
            }
            
            aTimer = nil
        }
        imageDisk.center.x += CGFloat(Double(cos))
        imageDisk.center.y += CGFloat(Double(sin))
    }
}

// Generate random number in range
extension Int {
    static func random(lowerBound: Int, upperBound: Int) -> Int {
        var offset = 0
        
        if lowerBound < 0
        {
            offset = abs(lowerBound)
        }
        
        let mini = UInt32(lowerBound + offset)
        let maxi = UInt32(upperBound + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}
