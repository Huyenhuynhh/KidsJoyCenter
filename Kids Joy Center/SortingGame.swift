//
//  SortingGame.swift
//  Kids Joy Center
//
//  Created by Huyen on 27/03/2022.
//

import UIKit

class SortingGame:UIViewController {
    var totalImages:Int = 8
    var images:[String] = [String]()
    var imageNames:[String] = ["l1","l2","l3","l4","l5","s1","s2","s3","s4","s5","w1","w2","w3","w4","w5"]
    var buttonSeq:[String] = [String]() //This will store images for each box
        
    var timer:Timer = Timer()
    var counter = 60
    var totalTime = 0
    var timeLab = UILabel()
    var scoreLab = UILabel()
    var timeStart: Int = 0
    //    let systemSoundID: SystemSoundID = 1016
    var imagesShown:Int = 0
    var loseFlag:Bool = false
    var beginningPosition: CGPoint = .zero
    var initialMovableViewPosition: CGPoint = .zero
    var skyView:UIView = UIView()
    var waterView1:UIView = UIView()
    var waterView2:UIView = UIView()
    var landView1:UIView = UIView()
    var landView2:UIView = UIView()
    var horizontalSv = UIStackView()
    var temp:Int = 0
    func getImages(){
        timeStart = totalTime
        imagesShown = totalImages
        for _ in 0...totalImages-1 {
            let val = Int.random(in: 0..<imageNames.count)
            images.append(imageNames[val])
            imageNames.remove(at: val)
        }
        
    }
    
    func getScore(time: Int)->Int{
        if time <= 2{
            return 5
        }
        else if time > 2 && time <= 4{
            return 4
        }
        return 3 //More than 4 seconds
        
    }
    
    @objc private func touched(_ gestureRecognizer: UIGestureRecognizer) {
        if let touchedView = gestureRecognizer.view {
            if gestureRecognizer.state == .began {
                beginningPosition = gestureRecognizer.location(in: touchedView)
                initialMovableViewPosition = touchedView.frame.origin
            }
            else if gestureRecognizer.state == .ended {
                if(touchedView.tag == 1 && touchedView.frame.intersects(skyView.frame)
                    && !touchedView.frame.intersects(waterView1.frame)
                    && !touchedView.frame.intersects(landView1.frame)

                ){
                    let score:Int = Int(scoreLab.text ?? "") ?? 0
                    if score != 0{
                        let time = timeStart - counter
                        var currScore:Int = Int(scoreLab.text ?? "") ?? 0
                        currScore += getScore(time:time)
                        scoreLab.text = String(currScore)
                        print(time)
                    }
                    else{
                        let time = timeStart - counter
                        timeStart = counter
                        scoreLab.text = String(getScore(time:time))
                        print(time)

                    }
                    imagesShown -= 1
                }
                else if(touchedView.tag == 2 && (touchedView.frame.intersects(waterView1.frame) || touchedView.frame.intersects(waterView2.frame))

                ){
                    let score:Int = Int(scoreLab.text ?? "") ?? 0
                    if score != 0{
                        let time = timeStart - counter
                        var currScore:Int = Int(scoreLab.text ?? "") ?? 0
                        currScore += getScore(time:time)
                        scoreLab.text = String(currScore)
                        print(time)
                    }
                    else{
                        let time = timeStart - counter
                        timeStart = counter
                        scoreLab.text = String(getScore(time:time))
                        print(time)

                    }
                    imagesShown -= 1
                }
                else if(touchedView.tag == 3 && (touchedView.frame.intersects(landView1.frame) || touchedView.frame.intersects(landView2.frame))
                ){
                    let score:Int = Int(scoreLab.text ?? "") ?? 0
                    if score != 0{
                        let time = timeStart - counter
                        var currScore:Int = Int(scoreLab.text ?? "") ?? 0
                        currScore += getScore(time:time)
                        scoreLab.text = String(currScore)
                        print(time)
                    }
                    else{
                        let time = timeStart - counter
                        timeStart = counter
                        scoreLab.text = String(getScore(time:time))
                        print(time)

                    }
                    imagesShown -= 1
                }
                else{
                    
                    UIView.animate(withDuration: 1.0) {
                        touchedView.frame.origin = self.initialMovableViewPosition
                    }
                    
         
                }
            }
            else if gestureRecognizer.state == .changed {
                let locationInView = gestureRecognizer.location(in: touchedView)
                touchedView.frame.origin = CGPoint(x: touchedView.frame.origin.x + locationInView.x - beginningPosition.x, y: touchedView.frame.origin.y + locationInView.y - beginningPosition.y)
              
            }
        }
    }
    
    
    func setImagesonTop(){
        horizontalSv.isUserInteractionEnabled = true
        horizontalSv.axis = .horizontal
        horizontalSv.alignment = .fill
        horizontalSv.distribution = .fillEqually
        horizontalSv.spacing = 10.0
        horizontalSv.backgroundColor = UIColor.systemBlue
        
        for i in 0 ..< totalImages {
            let image = UIImageView()
            image.image = UIImage(named: images[i])
            if images[i].first == "s"{
                image.tag = 1
            }
            else if images[i].first == "w"{
                image.tag = 2
            }
            else if images[i].first == "l"{
                image.tag = 3
            }
            image.isUserInteractionEnabled = true
            horizontalSv.addArrangedSubview(image)
            let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(touched(_:)))
            image.addGestureRecognizer(gestureRecognizer)
        }
        
        
        self.view.addSubview(horizontalSv)
        
        horizontalSv.translatesAutoresizingMaskIntoConstraints = false
        horizontalSv.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70).isActive = true
        horizontalSv.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        horizontalSv.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        horizontalSv.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -self.view.bounds.height + 150).isActive = true
        
    }
    
    func createSkyView(){
        skyView.alpha = 0.2
        skyView.frame = CGRect(x: 0, y: 150, width: self.view.bounds.width, height: self.view.bounds.height-480)
        view.addSubview(skyView)
        
    }
    
    func createSeaView(){
        waterView1.alpha = 0.2
        waterView1.frame = CGRect(x: 0, y: self.view.bounds.height-330, width: self.view.bounds.width-260, height: 180)
        view.addSubview(waterView1)
        
        waterView2.alpha = 0.2
        waterView2.frame = CGRect(x: 0, y: self.view.bounds.height-150, width: self.view.bounds.width-530, height: 150)
        view.addSubview(waterView2)
        
    }
    
    func createLandView(){
        landView1.alpha = 0.2
        landView1.frame = CGRect(x: self.view.bounds.width-260, y: self.view.bounds.height-330, width: 250, height: 180)
        view.addSubview(landView1)
        
        landView2.alpha = 0.8
        landView2.frame = CGRect(x: self.view.bounds.width-530, y: self.view.bounds.height-150, width: 550, height: 150)
        view.addSubview(landView2)
        
    }
    
    func reload(){
        
        images = [String]()
        imageNames = ["l1","l2","l3","l4","l5","s1","s2","s3","s4","s5","w1","w2","w3","w4","w5"]
        buttonSeq = [String]() //This will store images for each box
        
        timer = Timer()
       
        timeLab = UILabel()
        scoreLab = UILabel()
        timeStart = totalTime

        //let systemSoundID: SystemSoundID = 1016
        imagesShown = 0
        counter = totalTime
        loseFlag = false
        beginningPosition = .zero
        initialMovableViewPosition = .zero
        skyView     = UIView()
        waterView1  = UIView()
        waterView2  = UIView()
        landView1 = UIView()
        landView2 = UIView()
        horizontalSv = UIStackView()
        temp = 0
        let parent = view.superview
        view.removeFromSuperview()
        view = nil
        parent?.addSubview(view) // This line causes the view to be reloaded
    }
    
    func checkWin(){
        if imagesShown == 0 || loseFlag == true{
            let alert = UIAlertController(title: "Game Over", message: "Do you want to play again?", preferredStyle: .alert)
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
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    @objc func updateCounter() {
        if imagesShown == 0 && temp == 0{
            temp += 1
            loseFlag = true
            checkWin()
        }
        else if counter == 1{
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
    
    
    override func viewDidLoad() {
        
        //Adding Image
        let backgroundImageName = "air-land-water"
        let image = UIImage(named: backgroundImageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        view.addSubview(imageView)
        
        let timerImage = "time"
        let image2 = UIImage(named: timerImage)
        let imageView2 = UIImageView(image: image2!)
        imageView2.frame = CGRect(x: 0, y: view.bounds.height-50, width: imageView2.bounds.width/2.0, height: imageView2.bounds.height/2.0)
        view.addSubview(imageView2)
        
        timeLab.font = UIFont.systemFont(ofSize: 50.0)
        timeLab.frame = CGRect(x: (imageView2.bounds.width) + 5.0, y: view.bounds.height-50, width: imageView2.bounds.width, height: imageView2.bounds.height)
        view.addSubview(timeLab)
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

        
        
        let scoreImage = "score"
        let image3 = UIImage(named: scoreImage)
        let imageView3 = UIImageView(image: image3!)
        imageView3.frame = CGRect(x: self.view.bounds.width - imageView3.bounds.width + 100, y: view.bounds.height-50, width: imageView3.bounds.width/2.0, height: imageView3.bounds.height/2.0)
        view.addSubview(imageView3)
        
        scoreLab.font = UIFont.systemFont(ofSize: 50.0)
        scoreLab.text = "0"
        scoreLab.frame = CGRect(x: self.view.bounds.width - 85, y: view.bounds.height-50, width: imageView3.bounds.width, height: imageView3.bounds.height)
        view.addSubview(scoreLab)

        
        getImages()
        setImagesonTop()
        createSkyView()
        createSeaView()
        createLandView()
    }
    
    
}
