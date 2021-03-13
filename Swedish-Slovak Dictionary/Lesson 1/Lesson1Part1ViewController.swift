import UIKit
import AVFoundation

class Lesson1Part1ViewController: UIViewController {
    
    //declare local count variables
    var SlovakDataCount = 0
    var SwedishDataCount = 0
    var PhotoViewCount = 1
    var SoundSampleCount = 0.0
    
    //declare local lib. variables
    var SlovakData: [String] = []
    var SwedishData: [String] = []

    //declare IB Outlets
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var roundViewBox: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var swipeIcon: UIImageView!
    @IBOutlet weak var wordCount: UILabel!
    @IBOutlet weak var playSoundButton: UIButton!
    @IBOutlet weak var animationLabel: UILabel!
    
    //declare SoundUI var
    var SwipeNextSound = AVAudioPlayer()
    var SwipeBackSound = AVAudioPlayer()
    var Lesson1Sound1 = AVAudioPlayer()
    var Lesson1Sound2 = AVAudioPlayer()
    var Lesson1Sound3 = AVAudioPlayer()
    var Lesson1Sound4 = AVAudioPlayer()
    var Lesson1Sound5 = AVAudioPlayer()
    var Lesson1Sound6 = AVAudioPlayer()
    var Lesson1Sound7 = AVAudioPlayer()
    var Lesson1Sound8 = AVAudioPlayer()
    var Lesson1Sound9 = AVAudioPlayer()
    var Lesson1Sound10 = AVAudioPlayer()
    var SuccessSoundEffect = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeAnimation()
        textAnimation()
        editPlaySoundButton()
        
        //declare animation initial phase
        self.photoView.alpha = 1.0
        self.label1.alpha = 1.0
        self.label2.alpha = 1.0
        self.swipeIcon.alpha = 0.0
        self.animationLabel.alpha = 0.0
        
        //swipe recognizers
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:))) //right recognizer
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:))) //left swipe
        
        //func for non-default recognizer
        leftSwipe.direction = .left
        
        //Add recognizers to view
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(leftSwipe)

        //edit elements
        roundViewBox.layer.cornerRadius = 25.0
        photoView.layer.cornerRadius = 5.0
        roundViewBox.layer.shadowColor = UIColor.black.cgColor
        roundViewBox.layer.shadowOpacity = 0.5
        roundViewBox.layer.shadowOffset = CGSize(width: -1, height: 1)
        roundViewBox.layer.shadowRadius = 7.5
        
        roundViewBox.layer.rasterizationScale = UIScreen.main.scale
        view.addSubview(roundViewBox)
        view.addSubview(photoView)
            
        //photo view
        photoView.image = UIImage(named: "Lesson1Photo\(PhotoViewCount)")
        
        //label texts default
        updateElemntsInGestureRecognizer()
        
        //show text in view
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(wordCount)
        view.addSubview(swipeIcon)
        view.addSubview(animationLabel)
        
        //Declare Audio sample Swipe recognition
        do {
            SwipeNextSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "SwipeNextSoundEffect", ofType: "mp3")!))
            SwipeBackSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "SwipeBackSoundEffect", ofType: "mp3")!))
            Lesson1Sound1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "GodMorgon!", ofType: "m4a")!))
            Lesson1Sound2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "GodDag!", ofType: "m4a")!))
            Lesson1Sound3 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "GodAfton!", ofType: "m4a")!))
            Lesson1Sound4 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "GodNatt!", ofType: "m4a")!))
            Lesson1Sound5 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Hej!", ofType: "m4a")!))
            Lesson1Sound6 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Tjäna!", ofType: "m4a")!))
            Lesson1Sound7 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Tack!", ofType: "m4a")!))
            Lesson1Sound8 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Varsagod", ofType: "m4a")!))
            Lesson1Sound9 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Hejda!", ofType: "m4a")!))
            Lesson1Sound10 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Adjo!", ofType: "m4a")!))
            SuccessSoundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "SuccessSoundEffect", ofType: "mp3")!))
            
            //ready to play sounds
            SwipeNextSound.prepareToPlay()
            SwipeBackSound.prepareToPlay()
            Lesson1Sound1.prepareToPlay()
            Lesson1Sound2.prepareToPlay()
            Lesson1Sound3.prepareToPlay()
            Lesson1Sound4.prepareToPlay()
            Lesson1Sound5.prepareToPlay()
            Lesson1Sound6.prepareToPlay()
            Lesson1Sound7.prepareToPlay()
            Lesson1Sound8.prepareToPlay()
            Lesson1Sound9.prepareToPlay()
            Lesson1Sound10.prepareToPlay()
            //SuccessSoundEffect.prepareToPlay()
        } catch {
            print(error)
        }
        
    }
    
    func editPlaySoundButton(){
        //edit playSoundButton
        playSoundButton.layer.shadowColor = UIColor.black.cgColor
        playSoundButton.layer.shadowOpacity = 0.35
        playSoundButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        playSoundButton.layer.shadowRadius = 5.0
        
    }
    //declare swipe recognizer swicth for sender: pre-made swipes
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            //did swipe right
            case .right:
                print("swiped rigt")
                SlovakDataCount -= 1
                SwedishDataCount -= 1
                PhotoViewCount -= 1
                SoundSampleCount -= 1
                SwipeBackSound.play()
                
                //animation for swipe if View self.alpha = 1 and direction = right
                if self.photoView.alpha == 1.0 && self.label1.alpha == 1.0 && self.label2.alpha == 1.0 {
                    UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseOut, animations: {
                                    self.photoView.alpha = 0.5})
                    UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
                                    self.label1.alpha = 0.5})
                    UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseOut, animations: {
                                    self.label2.alpha = 0.5})
                    if self.photoView.alpha == 0.5 && self.label1.alpha == 0.5 && self.label2.alpha == 0.5{
                        UIView.animate(withDuration: 1.0, delay: 0.2, options: .transitionCrossDissolve, animations: {
                                        self.photoView.alpha = 1.0})
                        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
                                        self.label1.alpha = 1.0})
                        UIView.animate(withDuration: 0.5, delay: 0.2, options: .curveEaseIn, animations: {
                                        self.label2.alpha = 1.0})
                    }
                }
            //did swipe left
            case .left:
                print("swiped left")
                SlovakDataCount += 1
                SwedishDataCount += 1
                PhotoViewCount += 1
                SoundSampleCount += 1
                SwipeNextSound.play()
                
                //animation for swipe if self.alpha = 1 and direction = left
                if self.photoView.alpha == 1.0 && self.label1.alpha == 1.0 && self.label2.alpha == 1.0 {
                    UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseOut, animations: {
                                    self.photoView.alpha = 0.5})
                    UIView.animate(withDuration: 0.5, delay: 0.2, options: .transitionCurlUp, animations: {
                                    self.label1.alpha = 0.5})
                    UIView.animate(withDuration: 0.5, delay: 0.2, options: .transitionCurlUp, animations: {
                                    self.label2.alpha = 0.5})
                    if self.photoView.alpha == 0.5 && self.label1.alpha == 0.5 && self.label2.alpha == 0.5 {
                        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                                        self.photoView.alpha = 1.0})
                        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
                                        self.label1.alpha = 1.0})
                        UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
                                        self.label2.alpha = 1.0})
                    }
                }
            default:
                break
            } //declare min range
            updateElemntsInGestureRecognizer()
            if SlovakDataCount <= 0 && SwedishDataCount <= 0 && PhotoViewCount <= 1{
                SlovakDataCount = 0
                SwedishDataCount = 0
                PhotoViewCount = 1
                
            }
            //declare pass to new VC
            if SlovakDataCount >= 10 && SwedishDataCount >= 10 && PhotoViewCount >= 11{
                print("You passed Lesson 1.")
                SlovakDataCount = 9
                SwedishDataCount = 9
                PhotoViewCount = 10
                
                //declare sound delay in seconds
                let seconds = 1.2
                let when = DispatchTime.now() + seconds
                
                //to delay sound of delay seconds
                DispatchQueue.main.asyncAfter(deadline: when) {
                    self.SuccessSoundEffect.play()
                }
                
                //to disable previos UI elements
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCurlUp, animations: {
                    self.roundViewBox.alpha = 0.0
                    self.photoView.alpha = 0.0
                    self.label1.alpha = 0.0
                    self.label2.alpha = 0.0
                    self.playSoundButton.alpha = 0.0
                    self.wordCount.alpha = 0.0
                    
                })
                
                //declare end VC reference
                guard let endViewController = storyboard?.instantiateViewController(identifier: "Lesson1EndView") as? Lesson1EndViewController else {
                    return
                }
                //edit transition styles
                endViewController.modalPresentationStyle = .fullScreen
                endViewController.modalTransitionStyle = .crossDissolve
                present(endViewController, animated: true, completion: nil)
            }
            
        }
        
    }
    func updateElemntsInGestureRecognizer(){
        //read from text files to access Lesson data from DataStructure
        do {
            let directory1: String = Bundle.main.path(forResource: "Lesson1SlovakData", ofType: "txt")!
            let file1 = try String(contentsOfFile: directory1)
            SlovakData = file1.components(separatedBy: "\n")
            
            let directory2: String = Bundle.main.path(forResource: "Lesson1SwedishData", ofType: "txt")!
            let file2 = try String(contentsOfFile: directory2)
            SwedishData = file2.components(separatedBy: "\n")
            
        } catch {}
        //change elements based on gesture recognizer
        label1.text = SwedishData[SwedishDataCount]
        label2.text = SlovakData[SlovakDataCount]
        photoView.image = UIImage(named: "Lesson1Photo\(PhotoViewCount)")
        wordCount.text = ("Word \(SwedishDataCount+1)")
        
    }
    //declare IBOutlet action for playSoundButton
    @IBAction func didTapPlaySoundButton(_ sender: Any) {
        switch SoundSampleCount {
        case 0:
            Lesson1Sound1.play()
        case 1:
            Lesson1Sound2.play()
        case 2:
            Lesson1Sound3.play()
        case 3:
            Lesson1Sound4.play()
        case 4:
            Lesson1Sound5.play()
        case 5:
            Lesson1Sound6.play()
        case 6:
            Lesson1Sound7.play()
        case 7:
            Lesson1Sound8.play()
        case 8:
            Lesson1Sound9.play()
        case 9:
            Lesson1Sound10.play()
        default:
            break
        }
        print("Did tap playSoundButton")
    }
    
    //declare animation for swipe Icon
    func swipeAnimation(){
        if SlovakDataCount <= 0 {
            UIView.animate(withDuration: 1.5, delay: 0.5, animations: {
                            self.swipeIcon.transform = CGAffineTransform(translationX: -50, y: 0)
                            self.swipeIcon.alpha = 0.0}, completion: { (completed: Bool) ->
                                Void in UIView.animate(withDuration: 1.5, delay: 0.2, options: UIView.AnimationOptions.transitionCurlUp,
                                        animations: { self.swipeIcon.transform = CGAffineTransform(translationX: 50, y: 0)
                                            self.swipeIcon.alpha = 0.5 }, completion: { (completed: Bool) ->
                                        Void in self.swipeAnimation()})
                                
                            })
            
        }
        //if swiped to next View - disable swipe Icon animation
        if SlovakDataCount > 0 {
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .transitionCurlUp, animations: {
                            self.swipeIcon.alpha = 0.0})
        }
        
        
    }
    
    //declare animation for swipe Icon's text
    func textAnimation(){
        if SlovakDataCount <= 0 {
            UIView.animate(withDuration: 1.5, delay: 0.5, animations: {
                            self.animationLabel.transform = CGAffineTransform(translationX: -5, y: 0)
                            self.animationLabel.alpha = 0.0}, completion: { (completed: Bool) ->
                                Void in UIView.animate(withDuration: 1.5, delay: 0.2, options: UIView.AnimationOptions.transitionCurlUp,
                                        animations: { self.animationLabel.transform = CGAffineTransform(translationX: 5, y: 0)
                                            self.animationLabel.alpha = 0.5 }, completion: { (completed: Bool) ->
                                        Void in self.textAnimation()})
                                
                            })
            
        }
        if SlovakDataCount > 0 {
            UIView.animate(withDuration: 0.5, delay: 0.2, options: .transitionCurlUp, animations: {
                            self.animationLabel.alpha = 0.0})
        }
        
    }


}
