//
//  BalloonGame.swift
//  Kids Joy Center
//
//  Created by Huyen on 30/03/2022.
//

import UIKit



class BalloonGame:UIViewController {

    var numBallons: Int = 9
    var totalBallons: Int = 0
    var numArray:[Int] = [Int]()
    
    var timer:Timer = Timer()
    var counter = 60
    var totalTime = 0
    var timeLab = UILabel()
    var scoreLab = UILabel()
    var addedBalloons: [UIImageView] = [UIImageView]()
    var nums:[Int] = [Int]()
    var backgroundImageView = UIImageView()
    var view2: UIView = UIView()
    var speedValue: TimeInterval = 2.0
    var loseFlag:Bool = false
    var showSkull:Int = 0
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self.view)
        for subview in self.view.subviews {
            if subview.tag >= 0 && subview.tag<10 && subview.layer.presentation()?.hitTest(touchLocation) != nil {
                
                if(subview.tag != -10){
                    subview.isHidden = true
                    totalBallons -= 1
                    let scr1 = Int(scoreLab.text ?? "")
                    let lab1 = subview.subviews[0] as? UILabel
                    let scr2 = Int(lab1?.text ?? "")
                   
                    if let s1 = scr1, let s2 = scr2{
                        let scr3 = s1 + s2
                        scoreLab.text = String(scr3)
                    }

                    }

            }
            else if subview.tag == -99 && subview.layer.presentation()?.hitTest(touchLocation) != nil {
                loseFlag = true
            }
        }

    }
    
    override func viewDidLoad() {
        totalBallons = numBallons
        
        for _ in 0..<numBallons+1{
            var flag:Bool = false
            while(flag == false){
                let val = Int.random(in: 0..<numBallons+1) //total Balloons used in the game
                if (!nums.contains(val)){
                    nums.append(val)
                    flag = true
                }
            }
        }
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateBalloons), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

        
        
        for _ in 0..<numBallons{
            
            var boolean:Bool = false
            while(boolean == false){
                let val = Int.random(in: 1..<numBallons+1) //total Balloons used in the game
                if(!numArray.contains(val)){
                    numArray.append(val)
                    boolean = true
                }
            }
        }
        
        var i = 1
        let distance = (self.view.bounds.width - 50.0) / CGFloat(numBallons)
        var xVal = 0.0
        while (i <= numBallons){
            var ballonName:String = "color"
            ballonName = ballonName + String(i)
            let image = UIImage(named: ballonName)
            let imageView = UIImageView(image: image!)
            imageView.frame = CGRect(x: CGFloat(xVal), y: self.view.bounds.height+10, width: imageView.frame.width/1.50, height: imageView.frame.height/1.50)
            imageView.tag = i
            let labelVal:String = String(numArray[i-1])
            let label = UILabel()
            label.text = labelVal
            label.font = UIFont.systemFont(ofSize: 30.0)
            label.frame = CGRect(x: 40, y: 0, width: imageView.frame.width/1.50, height: imageView.frame.height/1.50)
            label.isUserInteractionEnabled = true
            imageView.addSubview(label)
            view.addSubview(imageView)
            
            imageView.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touched(_:)))
            imageView.addGestureRecognizer(gestureRecognizer)
            view.bringSubviewToFront(imageView)
            i += 1
            xVal += Double((distance))
        }
        
        let randomDistance = (self.view.bounds.width - 50.0) / CGFloat(Int.random(in: 0..<numBallons))

        let image = UIImage(named: "skull")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: randomDistance, y: self.view.bounds.height+10, width: imageView.frame.width/1.50, height: imageView.frame.height/1.50)
        imageView.tag = -99
        view.addSubview(imageView)
        
        let timerImage = "time"
        let image2 = UIImage(named: timerImage)
        let imageView2 = UIImageView(image: image2!)
        imageView2.frame = CGRect(x: 0, y: 75, width: imageView2.bounds.width/2.0, height: imageView2.bounds.height/2.0)
        view.addSubview(imageView2)
        
        timeLab.font = UIFont.systemFont(ofSize: 50.0)
        timeLab.frame = CGRect(x: (imageView2.bounds.width) + 5.0, y: 75, width: imageView2.bounds.width, height: imageView2.bounds.height)
        view.addSubview(timeLab)
        
        
        
        let scoreImage = "score"
        let image3 = UIImage(named: scoreImage)
        let imageView3 = UIImageView(image: image3!)
        imageView3.frame = CGRect(x: self.view.bounds.width - imageView3.bounds.width + 100, y: 75, width: imageView3.bounds.width/2.0, height: imageView3.bounds.height/2.0)
        view.addSubview(imageView3)
        
        scoreLab.font = UIFont.systemFont(ofSize: 50.0)
        scoreLab.text = "0"
        scoreLab.frame = CGRect(x: self.view.bounds.width - 85, y: 75, width: imageView3.bounds.width, height: imageView3.bounds.height)
        view.addSubview(scoreLab)
        

        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "sky-background")?.draw(in: self.view.bounds)

        if let image = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
         }
    
    }
    
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int) {
        return ((seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func startAnimation(){

        if addedBalloons.count == 1{
            let img = addedBalloons[0]
            
            while(img.frame.origin.y > 5){

                let img1 = addedBalloons[0]
                UIView.animate(withDuration: speedValue, delay: 0.0,options: [.allowUserInteraction]){
                    img1.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
                }
            }
            
            
        }
        else if addedBalloons.count == 2{

            let img1 = addedBalloons[1]
            UIView.animate(withDuration: speedValue, delay: 0.0,options: [.allowUserInteraction]){
                img1.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
            }
        }
        else if addedBalloons.count == 3{

            let img2 = addedBalloons[2]
            UIView.animate(withDuration: speedValue, delay: 0.0,options: [.allowUserInteraction]){
                img2.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
            }
        }
        else if addedBalloons.count == 4{

            let img3 = addedBalloons[3]
            UIView.animate(withDuration: speedValue, delay: 0.0,options: [.allowUserInteraction]){
                img3.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
            }
        }
        else if addedBalloons.count == 5{

            let img4 = addedBalloons[4]
            UIView.animate(withDuration: speedValue, delay: 0.0,options: [.allowUserInteraction]){
                img4.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
            }
        }
        else if addedBalloons.count == 6{

            let img5 = addedBalloons[5]
            UIView.animate(withDuration: speedValue, delay: 0.0,options: [.allowUserInteraction]){
                img5.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
            }
        }
        else if addedBalloons.count == 7{

            let img6 = addedBalloons[6]
            UIView.animate(withDuration: speedValue, delay: 0.0,options: [.allowUserInteraction]){
                img6.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
            }
        }
        else if addedBalloons.count == 8{

            let img7 = addedBalloons[7]
            UIView.animate(withDuration: speedValue, delay: 0.0,options: [.allowUserInteraction]){
                img7.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
            }
        }
        else if addedBalloons.count == 9{

            let img8 = addedBalloons[8]
            UIView.animate(withDuration: speedValue, delay: 0.0,options: [.allowUserInteraction]){
                img8.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
            }
        }
        else if addedBalloons.count == 10{

            let img8 = addedBalloons[9]
            UIView.animate(withDuration: speedValue, delay: 0.0,options: [.allowUserInteraction]){
                img8.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
            }
        }
        
    
    }
    
        @objc func updateBalloons() {
            startAnimation()
        }
    @objc func updateCounter() {
        if totalBallons == 0{
            checkWin()

        }
        else if(counter == 0){
            loseFlag = true
            checkWin()
        }
        else if(loseFlag == true){
            checkWin()
        }
        if counter == totalTime-18{
            showSkull = 1
            let img8 = addedBalloons[10]
            UIView.animate(withDuration: speedValue/2.0, delay: 0.0,options: [.allowUserInteraction]){
                    img8.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height-200)
            }
            
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
        
        
        
        
        var flag:Bool = false
        
        if !nums.isEmpty{
            
            if let imgView = self.view.subviews[nums.first ?? 0] as? UIImageView{
                self.addedBalloons.append(imgView)
                nums.removeFirst()
                print(imgView.tag)
        }
            
        }
        
    }

    @objc func touched(_ gesture: UITapGestureRecognizer) {
        if let touchedView = gesture.view {
            //print("Popped")
            
        }
    }
   
    func reload(){
        
    }
    
    func checkWin(){
        self.view.layer.removeAllAnimations()
           self.view.layer.removeAllAnimations()
           self.view.layoutIfNeeded()
        
        if totalBallons == 0 || loseFlag == true{
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
    
}
