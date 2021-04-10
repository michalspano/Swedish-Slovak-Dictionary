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
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var roundViewBox: UIView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var swipeIcon: UIImageView!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var playSoundButton: UIButton!
    @IBOutlet weak var animationLabel: UILabel!
    @IBOutlet var loaderView: UIView!
    
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
    
    var soundSampleDuration = Double()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMode()
        initilDisplacement()
        editLoadingBar()
        editElements()
        editPlaySoundButton()
        
        //to update elements
        updateElemntsInGestureRecognizer()
        
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
            SuccessSoundEffect.prepareToPlay()
        } catch {
            print(error)
        }
    }
    func checkMode() {
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }
    //to move to EndViewController
    func moveToEndViewController() {
        performSegue(withIdentifier: "finishLesson1", sender: (Any).self)
    }
    func initilDisplacement() {
        self.mainLabel.alpha = 0.0
        self.mainLabel.transform = CGAffineTransform(translationX: -50, y: 0)
        
        self.photoView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        self.roundViewBox.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        self.photoView.alpha = 0.0
        self.roundViewBox.alpha = 0.0
        self.label1.alpha = 0.0
        self.label2.alpha = 0.0
        
        self.wordCountLabel.alpha = 0.0
        self.wordCountLabel.transform = CGAffineTransform(translationX: 0, y: -30)
        
        self.playSoundButton.alpha = 0.0
        self.playSoundButton.transform = CGAffineTransform(translationX: 0, y: -50)
        
        //to continue with animation for View
        self.animateElements()
        
    }
    func animateElements() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            UILabel.animate(withDuration: 0.8, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.mainLabel.alpha = 1.0
                self.mainLabel.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
            })
            UIView.animate(withDuration: 1.2, delay: 0.3, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.photoView.alpha = 1.0
            })
            UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.photoView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                
                self.roundViewBox.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.roundViewBox.alpha = 1.0
                
            }, completion: {
                Void in UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseIn, animations: {
                    
                    self.photoView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    
                    self.roundViewBox.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: {
                    Void in  self.displayLabels()
                    self.displayWordCount()
                    self.displayPlaySoundButton()
                })
            })
        }
    }
    func displayLabels() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            UILabel.animate(withDuration: 0.5, animations: {
                self.label1.alpha = 1.0
                self.label2.alpha = 1.0
            })
        }
        
    }
    func displayPlaySoundButton() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            UIButton.animate(withDuration: 0.8, delay: 0.3, options: UIButton.AnimationOptions.curveEaseOut, animations: {
                self.playSoundButton.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
                self.playSoundButton.alpha = 1.0
            }, completion: {_ in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                    self.swipeAnimation()
                }
            })
        }
        
    }
    func displayWordCount() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            UILabel.animate(withDuration: 0.5, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.wordCountLabel.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
                self.wordCountLabel.alpha = 1.0
            })
        }
    }
    func rightSwipeAnimation() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            UIView.animate(withDuration: 0.1, animations: {
                self.roundViewBox.transform = CGAffineTransform(translationX: -10, y: 0)
                self.photoView.transform = CGAffineTransform(translationX: -10, y: 0)
                self.label1.transform = CGAffineTransform(translationX: -10, y: 0)
                self.label2.transform = CGAffineTransform(translationX: -10, y: 0)
            }, completion: {
                Void in UIView.animate(withDuration: 0.5, animations: {
                    self.roundViewBox.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.photoView.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.label1.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.label2.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            })
        }
    }
    func leftSwipeAnimation(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            UIView.animate(withDuration: 0.3, animations: {
            
                self.roundViewBox.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                self.photoView.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                self.label1.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                self.label2.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
                
            }, completion: {
                Void in UIView.animate(withDuration: 0.4, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self.roundViewBox.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.photoView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.label1.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.label2.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            })
        }
    }
    func editLoadingBar() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            self.loaderView.alpha = 0.0
            self.loaderView.layer.cornerRadius = 7.0
            self.loaderView.backgroundColor = UIColor(red: 0.01, green: 0.01, blue: 0.9, alpha: 1.0)
            
        })
    }
    func editElements() {
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
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(wordCountLabel)
        view.addSubview(swipeIcon)
        view.addSubview(animationLabel)
        
    }
    
    func editPlaySoundButton(){
        //edit playSoundButton
        playSoundButton.layer.shadowColor = UIColor.black.cgColor
        playSoundButton.layer.shadowOpacity = 0.35
        playSoundButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        playSoundButton.layer.shadowRadius = 5.0
        
    }
    func animateDidSwipeRight() {
        UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseOut, animations: {
            self.photoView.alpha = 0.5
            self.label1.alpha = 0.5
            self.label2.alpha = 0.5
        })
        if self.photoView.alpha == 0.5 && self.label1.alpha == 0.5 && self.label2.alpha == 0.5 {
            UIView.animate(withDuration: 1.0, delay: 0.2, options: .transitionCrossDissolve, animations: {
                self.photoView.alpha = 1.0
                self.label1.alpha = 1.0
                self.label2.alpha = 1.0
            })
        }
    }
    func animateDidSwipeLeft() {
        UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseOut, animations: {
            self.photoView.alpha = 0.5
        })
        UILabel.animate(withDuration: 0.5, delay: 0.2, options: .transitionCurlUp, animations: {
            self.label1.alpha = 0.5
            self.label2.alpha = 0.5
        })
        if self.photoView.alpha == 0.5 && self.label1.alpha == 0.5 && self.label2.alpha == 0.5 {
            UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
                self.photoView.alpha = 1.0
            })
            UILabel.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
                self.label1.alpha = 1.0
                self.label2.alpha = 1.0
            })
        }
        
    }
    //declare swipe recognizer swicth for sender: pre-made swipes
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                SlovakDataCount -= 1
                SwedishDataCount -= 1
                PhotoViewCount -= 1
                SoundSampleCount -= 1
                SwipeBackSound.play()
                rightSwipeAnimation()
                animateDidSwipeRight()
            
            case .left:
                SlovakDataCount += 1
                SwedishDataCount += 1
                PhotoViewCount += 1
                SoundSampleCount += 1
                SwipeNextSound.play()
                leftSwipeAnimation()
                animateDidSwipeLeft()
                
            default:
                break
            }
            if SlovakDataCount <= 0 && SwedishDataCount <= 0 && PhotoViewCount <= 1 {
                SlovakDataCount = 0
                SwedishDataCount = 0
                PhotoViewCount = 1
            }
            
            if SlovakDataCount >= 10 && SwedishDataCount >= 10 && PhotoViewCount >= 11 {
                SlovakDataCount = 9
                SwedishDataCount = 9
                PhotoViewCount = 10
                
                //to disable previos UI elements
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCurlUp, animations: {
                    self.roundViewBox.alpha = 0.0
                    self.photoView.alpha = 0.0
                    self.label1.alpha = 0.0
                    self.label2.alpha = 0.0
                    self.playSoundButton.alpha = 0.0
                    self.wordCountLabel.alpha = 0.0
                    
                })
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.2, execute: {
                    self.SuccessSoundEffect.play()
                })
                moveToEndViewController()
            }
        }
        
        updateElemntsInGestureRecognizer()
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
        wordCountLabel.text = ("Word \(SwedishDataCount+1)")
        
    }
    //declare IBOutlet action for playSoundButton
    @IBAction func didTapPlaySoundButton(_ sender: Any) {
        switch SoundSampleCount {
        case 0:
            Lesson1Sound1.play()
            soundSampleDuration = Lesson1Sound1.duration
            animateDurationForSoundSample()
        case 1:
            Lesson1Sound2.play()
            soundSampleDuration = Lesson1Sound2.duration
            animateDurationForSoundSample()
        case 2:
            Lesson1Sound3.play()
            soundSampleDuration = Lesson1Sound3.duration
            animateDurationForSoundSample()
        case 3:
            Lesson1Sound4.play()
            soundSampleDuration = Lesson1Sound4.duration
            animateDurationForSoundSample()
        case 4:
            Lesson1Sound5.play()
            soundSampleDuration = Lesson1Sound5.duration
            animateDurationForSoundSample()
        case 5:
            Lesson1Sound6.play()
            soundSampleDuration = Lesson1Sound6.duration
            animateDurationForSoundSample()
        case 6:
            Lesson1Sound7.play()
            soundSampleDuration = Lesson1Sound7.duration
            animateDurationForSoundSample()
        case 7:
            Lesson1Sound8.play()
            soundSampleDuration = Lesson1Sound8.duration
            animateDurationForSoundSample()
        case 8:
            Lesson1Sound9.play()
            soundSampleDuration = Lesson1Sound9.duration
            animateDurationForSoundSample()
        case 9:
            Lesson1Sound10.play()
            soundSampleDuration = Lesson1Sound10.duration
            animateDurationForSoundSample()
        default:
            break
        }
    }
    func animateDurationForSoundSample() {
        loaderView.frame.size.width = 0.0
        loaderView.alpha = 0.5
        UIButton.animate(withDuration: soundSampleDuration, delay: 0.5, animations: {
            self.playSoundButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        })
        UIView.animate(withDuration: soundSampleDuration,delay: 0.2, animations: {
            self.loaderView.frame.size.width = 200
            self.loaderView.backgroundColor = UIColor(red: 0.01, green: 0.01, blue: 0.1, alpha: 1.0)
        }, completion: {
            Void in UIView.animate(withDuration: 0.7, animations: {
                self.loaderView.alpha = 0.0
                self.playSoundButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: {_ in
                self.loaderView.frame.size.width = 0.0
                self.loaderView.backgroundColor = UIColor(red: 0.01, green: 0.01, blue: 0.9, alpha: 1.0)
            })
        })
    }
    
    
    //declare animation for swipe Icon
    func swipeAnimation(){
        if SlovakDataCount <= 0 {
            UIImageView.animate(withDuration: 1.5, delay: 0.2, animations: {
                self.swipeIcon.transform = CGAffineTransform(
                    translationX: -50,
                    y: 0)
                self.swipeIcon.alpha = 0.5
                
                //text animation
                self.animationLabel.transform = CGAffineTransform(
                    translationX: -5,
                    y: 0)
                self.animationLabel.alpha = 0.5
            }, completion: {
                Void in UIImageView.animate(withDuration: 1.5, delay: 0.2, animations: {
                    self.swipeIcon.transform = CGAffineTransform(
                        translationX: 50,
                        y: 0)
                    self.swipeIcon.alpha = 0.0
                    
                    //text animation
                    self.animationLabel.transform = CGAffineTransform(
                        translationX: 5,
                        y: 0)
                    self.animationLabel.alpha = 0.0
                }, completion: {
                    Void in self.swipeAnimation()
                })
            })
            if SlovakDataCount > 0 {
                UIImageView.animate(withDuration: 0.5, delay: 0.5, options: UIImageView.AnimationOptions.curveEaseIn,  animations: {
                    self.swipeIcon.alpha = 0.0
                })
            }
        }
    }
    @IBAction func didSwipeRetreat(_ sender: Any) {
        performSegue(withIdentifier: "retreatFromLesson1InitialToLesson1", sender: (Any).self)
    }
}
