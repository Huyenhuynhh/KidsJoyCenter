//
//  ViewController.swift
//  Kids Joy Center
//
//  Created by Huyen on 23/03/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var MemoryIcon: UIImageView!

    @IBOutlet weak var sortingIcon: UIImageView!
    @IBOutlet weak var balloonIcon: UIImageView!
    @IBOutlet weak var wasy: UIImageView!
    @IBOutlet weak var medium: UIImageView!
    @IBOutlet weak var hard: UIImageView!
    @IBOutlet weak var play: UIImageView!
    
    var gameSelected: Int = -1
    var difficultySelected: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.hidesBackButton = true

        MemoryIcon.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleMemoryTap(_:)))
        MemoryIcon.addGestureRecognizer(tap)
        
        sortingIcon.isUserInteractionEnabled = true
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.handleSortTap(_:)))
        sortingIcon.addGestureRecognizer(tap3)
        
        balloonIcon.isUserInteractionEnabled = true
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleBalloonTap(_:)))
        balloonIcon.addGestureRecognizer(tap2)
        
        wasy.isUserInteractionEnabled = true
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.handleEasy(_:)))
        wasy.addGestureRecognizer(tap4)
        
        medium.isUserInteractionEnabled = true
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(self.handleMedium(_:)))
        medium.addGestureRecognizer(tap5)
        
        hard.isUserInteractionEnabled = true
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(self.handleHard(_:)))
        hard.addGestureRecognizer(tap6)
        
        play.isUserInteractionEnabled = true
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(self.handlePlay(_:)))
        play.addGestureRecognizer(tap7)
       
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(back))
            self.navigationItem.leftBarButtonItem = backButton
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//        let navigationController = UINavigationController(rootViewController: vc)
//        self.present(navigationController, animated: true, completion: nil)
      
    }
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func handleMemoryTap(_ sender: UITapGestureRecognizer? = nil) {
        sortingIcon.layer.borderColor = UIColor.clear.cgColor
        balloonIcon.layer.borderColor = UIColor.clear.cgColor

        MemoryIcon.layer.borderColor = UIColor.red.cgColor
        MemoryIcon.layer.borderWidth = 5
        gameSelected = 1;
    }
    @objc func handleSortTap(_ sender: UITapGestureRecognizer? = nil) {
        MemoryIcon.layer.borderColor = UIColor.clear.cgColor
        balloonIcon.layer.borderColor = UIColor.clear.cgColor
        
        sortingIcon.layer.borderColor = UIColor.red.cgColor
        sortingIcon.layer.borderWidth = 5
        gameSelected = 2
    }
    @objc func handleBalloonTap(_ sender: UITapGestureRecognizer? = nil) {
        MemoryIcon.layer.borderColor = UIColor.clear.cgColor
        sortingIcon.layer.borderColor = UIColor.clear.cgColor
        
        balloonIcon.layer.borderColor = UIColor.red.cgColor
        balloonIcon.layer.borderWidth = 5
        gameSelected = 3
    }
    
    @objc func handleEasy(_ sender: UITapGestureRecognizer? = nil) {
        medium.layer.borderColor = UIColor.clear.cgColor
        hard.layer.borderColor = UIColor.clear.cgColor
        
        wasy.layer.borderColor = UIColor.red.cgColor
        wasy.layer.borderWidth = 5
        difficultySelected = 1
    }
    @objc func handleMedium(_ sender: UITapGestureRecognizer? = nil) {
        wasy.layer.borderColor = UIColor.clear.cgColor
        hard.layer.borderColor = UIColor.clear.cgColor
        
        medium.layer.borderColor = UIColor.red.cgColor
        medium.layer.borderWidth = 5
        difficultySelected = 2
    }
    @objc func handleHard(_ sender: UITapGestureRecognizer? = nil) {
        medium.layer.borderColor = UIColor.clear.cgColor
        wasy.layer.borderColor = UIColor.clear.cgColor
        
        hard.layer.borderColor = UIColor.red.cgColor
        hard.layer.borderWidth = 5
        difficultySelected = 3
    }
    @objc func handlePlay(_ sender: UITapGestureRecognizer? = nil) {
        if gameSelected == 1{

            
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "MemoryGame") as! MemoryGame
            
            if difficultySelected == 1{
                secondViewController.row = 4
                secondViewController.col = 3
                secondViewController.counter = 120
                secondViewController.totalTime = 120
                
            }
            else if difficultySelected == 2{
                secondViewController.row = 4
                secondViewController.col = 4
                secondViewController.counter = 105
                secondViewController.totalTime = 105

            }
            else if difficultySelected == 3{
                secondViewController.row = 4
                secondViewController.col = 5
                secondViewController.counter = 90
                secondViewController.totalTime = 90

            }
            
            
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
     }
       else if gameSelected == 2{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SortingGame") as! SortingGame
            
            if difficultySelected == 1{
                secondViewController.totalImages = 8
                secondViewController.counter = 60
                secondViewController.totalTime = 60
                
            }
            else if difficultySelected == 2{
                secondViewController.totalImages = 10
                secondViewController.counter = 45
                secondViewController.totalTime = 45

            }
            else if difficultySelected == 3{
                secondViewController.totalImages = 12
                secondViewController.counter = 30
                secondViewController.totalTime = 30

            }
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
     }
       else if gameSelected == 3{
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "BalloonGame") as! BalloonGame
            
            if difficultySelected == 1{
                secondViewController.speedValue = 20
                secondViewController.numBallons = 10
                secondViewController.totalTime = 60
                secondViewController.counter = 60

            }
            else if difficultySelected == 2{
                secondViewController.speedValue = 20
                secondViewController.numBallons = 10
                secondViewController.totalTime = 45
                secondViewController.counter = 45
            }
            else if difficultySelected == 3{
                secondViewController.speedValue = 15
                secondViewController.numBallons = 10
                secondViewController.totalTime = 30
                secondViewController.counter = 30
            }
            
            self.navigationController?.pushViewController(secondViewController, animated: true)
            
     }
    }
    
}

