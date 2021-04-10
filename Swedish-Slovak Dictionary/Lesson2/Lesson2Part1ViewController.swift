import UIKit
import AVFoundation

class Lesson2Part1ViewController: UIViewController {
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
    @IBOutlet weak var playSoundButton: UIButton!
    @IBOutlet weak var animationLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet var mainScene: GradientViewLesson2!
    
    //declare SoundUI var
    var SwipeNextSound = AVAudioPlayer()
    var SwipeBackSound = AVAudioPlayer()
    var Lesson2Sound1 = AVAudioPlayer()
    var Lesson2Sound2 = AVAudioPlayer()
    var Lesson2Sound3 = AVAudioPlayer()
    var Lesson2Sound4 = AVAudioPlayer()
    var Lesson2Sound5 = AVAudioPlayer()
    var Lesson2Sound6 = AVAudioPlayer()
    var Lesson2Sound7 = AVAudioPlayer()
    var Lesson2Sound8 = AVAudioPlayer()
    var Lesson2Sound9 = AVAudioPlayer()
    var Lesson2Sound10 = AVAudioPlayer()
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
        
        do {
            SwipeNextSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "SwipeNextSoundEffect", ofType: "mp3")!))
            SwipeBackSound = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "SwipeBackSoundEffect", ofType: "mp3")!))
            SuccessSoundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "SuccessSoundEffect", ofType: "mp3")!))
            
            SwipeNextSound.prepareToPlay()
            SwipeBackSound.prepareToPlay()
            SuccessSoundEffect.prepareToPlay()
            
            Lesson2Sound1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Sverige", ofType: "m4a")!))
            Lesson2Sound2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Slovakien", ofType: "m4a")!))
            Lesson2Sound3 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Norge", ofType: "m4a")!))
            Lesson2Sound4 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Tjeckien", ofType: "m4a")!))
            Lesson2Sound5 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Tyskland", ofType: "m4a")!))
            Lesson2Sound6 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ryssland", ofType: "m4a")!))
            Lesson2Sound7 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Ungern", ofType: "m4a")!))
            Lesson2Sound8 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Frankrike", ofType: "m4a")!))
            Lesson2Sound9 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Polen", ofType: "m4a")!))
            Lesson2Sound10 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Finland", ofType: "m4a")!))
            Lesson2Sound1.prepareToPlay()
            Lesson2Sound2.prepareToPlay()
            Lesson2Sound3.prepareToPlay()
            Lesson2Sound4.prepareToPlay()
            Lesson2Sound5.prepareToPlay()
            Lesson2Sound6.prepareToPlay()
            Lesson2Sound7.prepareToPlay()
            Lesson2Sound8.prepareToPlay()
            Lesson2Sound9.prepareToPlay()
            Lesson2Sound10.prepareToPlay()
        } catch {}
    
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
    func moveToEndViewController(){
        guard let endViewController = storyboard?.instantiateViewController(identifier: "Lesson2EndView") as? Lesson2EndViewController else {
            return
        }
        endViewController.modalPresentationStyle = .fullScreen
        endViewController.modalTransitionStyle = .crossDissolve
        present(endViewController, animated: true, completion: nil)
    }
    func initilDisplacement(){
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
    func animateElements(){
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
    func displayLabels(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            UILabel.animate(withDuration: 0.5, animations: {
                self.label1.alpha = 1.0
                self.label2.alpha = 1.0
            })
        }
    }
    func displayPlaySoundButton(){
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
    func displayWordCount(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            UILabel.animate(withDuration: 0.5, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.wordCountLabel.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
                self.wordCountLabel.alpha = 1.0
            })
        }
        
    }
    func rightSwipeanimation(){
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
    
    func leftSwipeanimation(){
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
    func editElements(){
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
    //to animate for RightSwipe
    func animateDidSwipeRight(){
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
    //to animate for LeftSwipe
    func animateDidSwipeLeft(){
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
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            switch sender.direction {
            case .right:
                SlovakDataCount -= 1
                SwedishDataCount -= 1
                PhotoViewCount -= 1
                SoundSampleCount -= 1
                SwipeBackSound.play()
                rightSwipeanimation()
                animateDidSwipeRight()
            
            case .left:
                SlovakDataCount += 1
                SwedishDataCount += 1
                PhotoViewCount += 1
                SoundSampleCount += 1
                SwipeNextSound.play()
                leftSwipeanimation()
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
            let directory1: String = Bundle.main.path(forResource: "Lesson2SlovakData", ofType: "txt")!
            let file1 = try String(contentsOfFile: directory1)
            SlovakData = file1.components(separatedBy: "\n")
            
            let directory2: String = Bundle.main.path(forResource: "Lesson2SwedishData", ofType: "txt")!
            let file2 = try String(contentsOfFile: directory2)
            SwedishData = file2.components(separatedBy: "\n")
            
        } catch {}
        //change elements based on gesture recognizer
        label1.text = SwedishData[SwedishDataCount]
        label2.text = SlovakData[SlovakDataCount]
        photoView.image = UIImage(named: "Lesson2Photo\(PhotoViewCount)")
        wordCountLabel.text = ("Word \(SwedishDataCount+1)")
        
    }
    @IBAction func didTapPlaySoundButton(_ sender: Any) {
        switch SoundSampleCount {
        case 0:
            Lesson2Sound1.play()
            soundSampleDuration = Lesson2Sound1.duration
            animateDurationForSoundSample()
        case 1:
            Lesson2Sound2.play()
            soundSampleDuration = Lesson2Sound2.duration
            animateDurationForSoundSample()
        case 2:
            Lesson2Sound3.play()
            soundSampleDuration = Lesson2Sound3.duration
            animateDurationForSoundSample()
        case 3:
            Lesson2Sound4.play()
            soundSampleDuration = Lesson2Sound4.duration
            animateDurationForSoundSample()
        case 4:
            Lesson2Sound5.play()
            soundSampleDuration = Lesson2Sound5.duration
            animateDurationForSoundSample()
        case 5:
            Lesson2Sound6.play()
            soundSampleDuration = Lesson2Sound6.duration
            animateDurationForSoundSample()
        case 6:
            Lesson2Sound7.play()
            soundSampleDuration = Lesson2Sound7.duration
            animateDurationForSoundSample()
        case 7:
            Lesson2Sound8.play()
            soundSampleDuration = Lesson2Sound8.duration
            animateDurationForSoundSample()
        case 8:
            Lesson2Sound9.play()
            soundSampleDuration = Lesson2Sound9.duration
            animateDurationForSoundSample()
        case 9:
            Lesson2Sound10.play()
            soundSampleDuration = Lesson2Sound10.duration
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
        performSegue(withIdentifier: "retreatFromLesson2InitialToLesson2", sender: Any?.self)
    }
    
}
