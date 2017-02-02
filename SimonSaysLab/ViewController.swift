//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.isHidden = true
    }
    @IBAction func buttonRed(_ sender: Any) {
        simonSaysGame.guessRed()
        click()
        print("The \(buttonsClicked) button clicked is Red")
        
    }
    
    @IBAction func buttonGreen(_ sender: Any) {
        simonSaysGame.guessGreen()
        click()
        print("The \(buttonsClicked) button clicked is Green")
    }
    
    @IBAction func buttonYellow(_ sender: Any) {
        simonSaysGame.guessYellow()
        click()
        print("The \(buttonsClicked) button clicked is Yellow")
    }
   
    @IBAction func buttonBlue(_ sender: Any) {
        simonSaysGame.guessBlue()
        click()
        print("The \(buttonsClicked) button clicked is Blue")
    }
    
    func win() {
        if simonSaysGame.wonGame() {
            winLabel.text = "Congratulations! You've Won!"
        } else {
            winLabel.text = "Sorry, better luck next time!"
        }
    }
    
    func click() {
        
        buttonsClicked += 1
        
        if buttonsClicked == 5{
            if simonSaysGame.wonGame() {
                winLabel.text = "Congratulations! You've Won!"
                winLabel.isHidden = false
            } else {
                winLabel.text = "Sorry, better luck next time!"
                winLabel.isHidden = false
            }
        }
        
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(_ sender: UIButton) {
        UIView.transition(with: startGameButton, duration: 0.9, options: .transitionFlipFromBottom , animations: {
            self.startGameButton.isHidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    fileprivate func displayTheColors() {
        self.view.isUserInteractionEnabled = false
        UIView.transition(with: displayColorView, duration: 1.5, options: .transitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.isUserInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
