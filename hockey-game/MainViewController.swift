//
//  ViewController.swift
//  hockey-game
//
//  Created by eleves on 2017-12-04.
//  Copyright © 2017 com.henrique. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var textFieldPlayer1: UITextField!
    @IBOutlet weak var textFieldPlayer2: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    //MARK: Outlets
    
    var selectedPrize: Int!
    
    private let prizes = [(0, "Choississez un pari"),
                          (1, "Une grosse poutine"),
                          (2, "Des billets pour le prochain match de hockey"),
                          (3, "3 Semaines de Pizza-Pizza")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldPlayer1.delegate = self
        textFieldPlayer2.delegate = self
        
        selectedPrize = 0
        picker.selectedRow(inComponent: 0)
        
        playButton.layer.cornerRadius = 5
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.black.cgColor
        
        picker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedPrize = 0
        picker.selectedRow(inComponent: 0)
        textFieldPlayer1.text = ""
        textFieldPlayer2.text = ""
        textFieldPlayer1.becomeFirstResponder()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func play(_ sender: UIButton) {
        if textFieldPlayer1.text!.isEmpty || textFieldPlayer2.text!.isEmpty {
            let alert = UIAlertController(title: NSLocalizedString("Attention", comment: ""),
                                          message: NSLocalizedString("Veuillez remplir les noms des joueurs correctement!", comment: ""),
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if selectedPrize == 0 {
            let alert = UIAlertController(title: NSLocalizedString("Attention", comment: ""),
                                          message: NSLocalizedString("Veuillez choisir le pari correctement!", comment: ""),
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: "stadiumSegue", sender: sender)
        }
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let stadiumViewController = segue.destination as! StadiumViewController
        stadiumViewController.player1 = textFieldPlayer1.text
        stadiumViewController.player2 = textFieldPlayer2.text
        stadiumViewController.prize = prizes[selectedPrize].1
        
    }
    // MARK: Prepare for segue
    
}

extension MainViewController: UITextFieldDelegate {    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

//MARK: Extension Picker
extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return prizes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return prizes[row].1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPrize = prizes[row].0
    }
    
    //# MARK: - pickerView
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.white
        pickerLabel.text = prizes[row].1
        pickerLabel.font = UIFont(name: "Arial", size: 30)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
}

