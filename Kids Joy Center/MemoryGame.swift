//
//  MemoryGame.swift
//  Kids Joy Center
//
//  Created by Huyen on 24/03/2022.
//

import Foundation
import UIKit
import AVFoundation

class MemoryGame:UIViewController {
    let mySpacing:CGFloat = 10.0
    var row:Int = 0
    var col:Int = 0
    var images:[String] = [String]()
    var imageNames:[String] = ["1","2","3","4","5","6","7","8","9","10"]
    var buttonSeq:[String] = [String]() //This will store images for each box
    
    var isTapped:Bool = false
    var isClickable:Bool = true
    
    var clickedButton: UIImageView = UIImageView()
    var timer:Timer = Timer()
    var counter = 30
    var totalTime = 0
    let timeLab = UILabel()
    let scoreLab = UILabel()
    var timeStart: Int = 0
    let systemSoundID: SystemSoundID = 1016
    var imagesShown:Int = 0
    var loseFlag:Bool = false
    func getImages(){
        let totalImgs = (row*col)/2
        imagesShown = totalImgs
        for _ in 0...totalImgs-1 {
            let val = Int.random(in: 0..<imageNames.count)
            images.append(imageNames[val])
            imageNames.remove(at: val)
        }
        
        
        
        let totalImgs2 = (row*col)
        buttonSeq = [String](repeating: "nil",count: totalImgs2)
        
        for i in 0...totalImgs-1 {
            
            var flag:Bool = false
            while flag == false{
                let pos1 = Int.random(in: 0..<totalImgs2)
                let pos2 = Int.random(in: 0..<totalImgs2)
                if(buttonSeq[pos1] == "nil" && buttonSeq[pos2] == "nil" && pos1 != pos2){
                    buttonSeq[pos1] = images[i]
                    buttonSeq[pos2] = images[i]
                    flag = true
                }
            }
        }
        
      
    }
    
    func stackedGrid(rows: Int, columns: Int, rootView: UIView){
        // Init StackView
        getImages()
        let stackView = UIStackView()
        stackView.tag = -1
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = mySpacing
        var counter:Int = 0;
        for _ in 0 ..< rows {
            
            let horizontalSv = UIStackView()
            horizontalSv.isUserInteractionEnabled = true
            horizontalSv.axis = .horizontal
            horizontalSv.alignment = .fill
            horizontalSv.distribution = .fillEqually
            horizontalSv.spacing = mySpacing
            
            for _ in 0 ..< columns {
                let image = UIImageView()
                image.image = UIImage(named: "question")
                image.tag = Int(buttonSeq[counter]) ?? 0
                image.layer.cornerRadius = 6
                
                image.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                image.addGestureRecognizer(tap)
                horizontalSv.addArrangedSubview(image)
                counter += 1
            }
            stackView.addArrangedSubview(horizontalSv)
        }
        rootView.addSubview(stackView)
        
        // add constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: rootView.topAnchor, constant: mySpacing + 120).isActive = true
        stackView.leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: mySpacing + 140).isActive = true
        stackView.rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: -mySpacing - 140).isActive = true
        stackView.bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: -mySpacing - 100).isActive = true
    }
    override func viewDidLoad() {
        
        //Adding Image
        let backgroundImageName = "background"
        let image = UIImage(named: backgroundImageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        view.addSubview(imageView)
        
        
        let timerImage = "time"
        let image2 = UIImage(named: timerImage)
        let imageView2 = UIImageView(image: image2!)
        imageView2.frame = CGRect(x: 0, y: 75, width: imageView2.bounds.width/2.0, height: imageView2.bounds.height/2.0)
        view.addSubview(imageView2)
        
        timeLab.font = UIFont.systemFont(ofSize: 50.0)
        timeLab.frame = CGRect(x: (imageView2.bounds.width) + 5.0, y: 75, width: imageView2.bounds.width, height: imageView2.bounds.height)
        view.addSubview(timeLab)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

        
        
        let scoreImage = "score"
        let image3 = UIImage(named: scoreImage)
        let imageView3 = UIImageView(image: image3!)
        imageView3.frame = CGRect(x: self.view.bounds.width - imageView3.bounds.width + 100, y: 75, width: imageView3.bounds.width/2.0, height: imageView3.bounds.height/2.0)
        view.addSubview(imageView3)
        
        scoreLab.font = UIFont.systemFont(ofSize: 50.0)
        scoreLab.text = "0"
        scoreLab.frame = CGRect(x: self.view.bounds.width - 85, y: 75, width: imageView3.bounds.width, height: imageView3.bounds.height)
        view.addSubview(scoreLab)

        stackedGrid(rows: row, columns: col, rootView: self.view)
        
        
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @objc func updateCounter() {
        if counter == 1{
            loseFlag = true
            checkWin()
        }
        let (m, s) = secondsToHoursMinutesSeconds(counter)

        if counter > 0 {
            if(m == 0){
                timeLab.text = String("00:\(s)")
            }
            else if(s == 0){
                timeLab.text = String("\(m):00")
            }
            else{
            timeLab.text = String("\(m):\(s)")
            }
            counter -= 1
        }
    }
    
    func getScore(time: Int)->Int{
        if time <= 3{
            return 5
        }
        else if time > 3 && time <= 7{
            return 4
        }
        return 3 //More than 7 seconds
        
    }
    
    func reload(){
        if let viewWithTag = self.view.viewWithTag(-1) {
                viewWithTag.removeFromSuperview()
        }
        
        clickedButton = UIImageView()
        timer = Timer()
        imagesShown = 0
        scoreLab.text = String("0")
        counter = totalTime
        imageNames = ["1","2","3","4","5","6","7","8","9","10"]
        stackedGrid(rows: row, columns: col, rootView: self.view)
    }
    
    func checkWin(){
        if imagesShown == 0 || loseFlag == true{
            let alert = UIAlertController(title: "Alert", message: "Do you want to play again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                switch action.style{
                    case .default:
                        self.reload()
                        
                    case .cancel:
                    print("cancel")
                        
                    case .destructive:
                        print("destructive")

                }
            }))
         
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { action in
                switch action.style{
                    case .default:
                        self.navigationController?.popToRootViewController(animated: true)

                    case .cancel:
                    print("cancel")
                        
                    case .destructive:
                        print("destructive")

                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        if isClickable == true{
            let imageView = sender?.view as! UIImageView
            if(isTapped == false){
                isTapped = true
                clickedButton = imageView
                guard let getTag = sender?.view?.tag else { return }
                imageView.image = UIImage(named: String(getTag))
            }
            
            else{
                isClickable = false
                guard let getTag = sender?.view?.tag else { return }
                imageView.image = UIImage(named: String(getTag))
                
                if(imageView.image == clickedButton.image){
                    print("Same")
                    imagesShown -= 1
                    AudioServicesPlaySystemSound(systemSoundID)
                    self.isClickable = true
                    self.isTapped = false
                    let score:Int = Int(scoreLab.text ?? "") ?? 0
                    if score != 0{
                        let time = timeStart - counter
                        var currScore:Int = Int(scoreLab.text ?? "") ?? 0
                        currScore += getScore(time:time)
                        scoreLab.text = String(currScore)
                        print(time)
                    }
                    else{
                        let time = totalTime - counter
                        timeStart = counter
                        scoreLab.text = String(getScore(time:time))
                        print(time)

                    }
                    checkWin()
                }
                else{
                    let seconds = 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                        self.clickedButton.image = UIImage(named:"question")
                        imageView.image =  UIImage(named:"question")
                        self.isTapped = false
                        self.isClickable = true
                    }
                    
                    
                    
                }
            }
        }
    }
    
}
