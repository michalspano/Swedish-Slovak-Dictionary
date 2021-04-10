import UIKit
import AVFoundation

class Lesson4Part1ViewController: UIViewController {
    //declare local count variables
    var SlovakDataCount = 0
    var SwedishDataCount = 0
    var PhotoViewCount = 1
    var SoundSampleCount = 0.0
    
    //declare local lib. variables
    var SlovakData: [String] = []
    var SwedishData: [String] = []
    
    //lesson identifier from previous VC method
    var lessonIdentifier2 = String()
    
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
    
    //declare undefined AVAudioPlayers;
    var SwipeNextSound = AVAudioPlayer()
    var SwipeBackSound = AVAudioPlayer()
    var LessonSound1 = AVAudioPlayer()
    var LessonSound2 = AVAudioPlayer()
    var LessonSound3 = AVAudioPlayer()
    var LessonSound4 = AVAudioPlayer()
    var LessonSound5 = AVAudioPlayer()
    var LessonSound6 = AVAudioPlayer()
    var LessonSound7 = AVAudioPlayer()
    var LessonSound8 = AVAudioPlayer()
    var LessonSound9 = AVAudioPlayer()
    var LessonSound10 = AVAudioPlayer()
    var SuccessSoundEffect = AVAudioPlayer()
    
    var soundSampleDuration = Double()
    var lessonID = Int()
    
    //Declare SoundUI var(s)

    override func viewDidLoad() {
        super.viewDidLoad()
        checkMode()
        lessonAssets()
        
        initilDisplacement()
        editLoadingBar()
        editElements()
        editPlaySoundButton()
        
        //to update elements
        updateElemntsInGestureRecognizer()
        
        self.swipeIcon.alpha = 0.0
        self.animationLabel.alpha = 0.0
        
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
    func moveToEndViewController() {
        performSegue(withIdentifier: "finishLesson", sender: (Any).self)
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
    func leftSwipeAnimation() {
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
    func editPlaySoundButton() {
        //edit playSoundButton
        playSoundButton.layer.shadowColor = UIColor.black.cgColor
        playSoundButton.layer.shadowOpacity = 0.35
        playSoundButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        playSoundButton.layer.shadowRadius = 5.0
        
    }
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
    func lessonAssets() {
        switch lessonIdentifier2 {
        case "Lesson 4":
            lessonID = 4
            mainLabel.text = "Lesson \(lessonID)"
            do {
                LessonSound1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "får", ofType: "m4a")!))
                LessonSound2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "gris", ofType: "m4a")!))
                LessonSound3 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "ko", ofType: "m4a")!))
                LessonSound4 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "spindel", ofType: "m4a")!))
                LessonSound5 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "katt", ofType: "m4a")!))
                LessonSound6 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "hund", ofType: "m4a")!))
                LessonSound7 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "fisk", ofType: "m4a")!))
                LessonSound8 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "fågel", ofType: "m4a")!))
                LessonSound9 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "häst", ofType: "m4a")!))
                LessonSound10 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "varg", ofType: "m4a")!))
                LessonSound1.prepareToPlay()
                LessonSound2.prepareToPlay()
                LessonSound3.prepareToPlay()
                LessonSound4.prepareToPlay()
                LessonSound5.prepareToPlay()
                LessonSound6.prepareToPlay()
                LessonSound7.prepareToPlay()
                LessonSound8.prepareToPlay()
                LessonSound9.prepareToPlay()
                LessonSound10.prepareToPlay()
            } catch {
                print(NSError.self)
            }
        case "Lesson 5":
            lessonID = 5
            mainLabel.text = "Lesson \(lessonID)"
            do {
                LessonSound1 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Djurpark", ofType: "m4a")!))
                LessonSound2 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Skola", ofType: "m4a")!))
                LessonSound3 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Polisstation", ofType: "m4a")!))
                LessonSound4 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Tågstation", ofType: "m4a")!))
                LessonSound5 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Bibliotek", ofType: "m4a")!))
                LessonSound6 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Sjukhus", ofType: "m4a")!))
                LessonSound7 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Strand", ofType: "m4a")!))
                LessonSound8 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Kyrka", ofType: "m4a")!))
                LessonSound9 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Posten", ofType: "m4a")!))
                LessonSound10 = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Mataffär", ofType: "m4a")!))
                LessonSound1.prepareToPlay()
                LessonSound2.prepareToPlay()
                LessonSound3.prepareToPlay()
                LessonSound4.prepareToPlay()
                LessonSound5.prepareToPlay()
                LessonSound6.prepareToPlay()
                LessonSound7.prepareToPlay()
                LessonSound8.prepareToPlay()
                LessonSound9.prepareToPlay()
                LessonSound10.prepareToPlay()
            } catch {
                print(NSError.self)
            }
        default:
            break
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
    func updateElemntsInGestureRecognizer() {
        //read from text files to access Lesson data from DataStructure
        do {
            let directory1: String = Bundle.main.path(forResource: "Lesson\(lessonID)SlovakData", ofType: "txt")!
            let file1 = try String(contentsOfFile: directory1)
            SlovakData = file1.components(separatedBy: "\n")
            
            let directory2: String = Bundle.main.path(forResource: "Lesson\(lessonID)SwedishData", ofType: "txt")!
            let file2 = try String(contentsOfFile: directory2)
            SwedishData = file2.components(separatedBy: "\n")
            
        } catch {}
        //change elements based on gesture recognizer
        label1.text = SwedishData[SwedishDataCount]
        label2.text = SlovakData[SlovakDataCount]
        photoView.image = UIImage(named: "Lesson\(lessonID)Photo\(PhotoViewCount)")
        wordCountLabel.text = ("Word \(SwedishDataCount+1)")
    }
    @IBAction func didTapPlaySoundButton(_ sender: Any) {
        switch SoundSampleCount {
        case 0:
            LessonSound1.play()
            soundSampleDuration = LessonSound1.duration
            animateDurationForSoundSample()
        case 1:
            LessonSound2.play()
            soundSampleDuration = LessonSound2.duration
            animateDurationForSoundSample()
        case 2:
            LessonSound3.play()
            soundSampleDuration = LessonSound3.duration
            animateDurationForSoundSample()
        case 3:
            LessonSound4.play()
            soundSampleDuration = LessonSound4.duration
            animateDurationForSoundSample()
        case 4:
            LessonSound5.play()
            soundSampleDuration = LessonSound5.duration
            animateDurationForSoundSample()
        case 5:
            LessonSound6.play()
            soundSampleDuration = LessonSound6.duration
            animateDurationForSoundSample()
        case 6:
            LessonSound7.play()
            soundSampleDuration = LessonSound7.duration
            animateDurationForSoundSample()
        case 7:
            LessonSound8.play()
            soundSampleDuration = LessonSound8.duration
            animateDurationForSoundSample()
        case 8:
            LessonSound9.play()
            soundSampleDuration = LessonSound9.duration
            animateDurationForSoundSample()
        case 9:
            LessonSound10.play()
            soundSampleDuration = LessonSound10.duration
            animateDurationForSoundSample()
        default:
            break
        }
    }
    func animateDurationForSoundSample(){
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
    func swipeAnimation() {
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
        performSegue(withIdentifier: "retreatFromLessonInitialToLesson", sender: (Any).self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "retreatFromLessonInitialToLesson") {
            let retreatVC = segue.destination as! Lesson4ViewController
            retreatVC.lessonIdentifier = lessonIdentifier2
        }
        else {
            let endVC = segue.destination as! Lesson4EndViewController
            endVC.lessonIdentifier3 = lessonIdentifier2
        }
    }
}
