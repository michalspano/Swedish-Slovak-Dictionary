import UIKit

class QuizLibraryViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var lessonInfoLabel: UILabel!
    @IBOutlet var lessonLabel: UILabel!
    @IBOutlet var lessonIconView: UIImageView!
    @IBOutlet var mainScene: UIView!
    @IBOutlet var lessonButton: UIButton!
    @IBOutlet var backButton: UIButton!
    
    var swipeCount = 1
    var colorChange = UIColor()
    var modeSwitch = Bool()
    var landscapeSwitch = Bool()
    
    let toDisableSound: Bool = true
    let gradientLayer = CAGradientLayer()
    var lessonInfo = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMode()
        detectOrientation()
        editElements()
        initialDisplacement()
        
        if traitCollection.userInterfaceStyle == .light {
            modeSwitch = true
        }
        else {
            modeSwitch = false
        }
        updateBG()
    }
    func checkMode() {
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    func editElements() {
        lessonButton.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
        lessonButton.layer.shadowOpacity = 0.4
        lessonButton.layer.shadowOffset = CGSize(width: -2, height: 2)
        lessonButton.layer.shadowRadius = 7.5
        lessonButton.layer.cornerRadius = 30.0
        
        lessonIconView.layer.shadowOpacity = 0.15
        lessonIconView.layer.shadowOffset = CGSize(width: -1, height: 1)
        lessonIconView.layer.shadowRadius = 10
        
        backButton.backgroundColor = #colorLiteral(red: 0, green: 0.5293415846, blue: 0.9026508524, alpha: 1)
        backButton.layer.shadowOpacity = 0.4
        backButton.layer.shadowOffset = CGSize(width: -2, height: 2)
        backButton.layer.shadowRadius = 7.5
        backButton.layer.cornerRadius = 15.0
        
    }
    func initialDisplacement() {
        mainLabel.alpha = 0.0
        mainLabel.transform = CGAffineTransform(translationX: 0, y: -30)
        lessonIconView.alpha = 0.0
        lessonIconView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        lessonLabel.alpha = 0.0
        lessonLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        lessonButton.alpha = 0.0
        lessonButton.transform = CGAffineTransform(translationX: 0, y: -35)
        backButton.alpha = 0.0
        backButton.transform = CGAffineTransform(translationX: 0, y: -15)
        animateElements()
    }
    
    func animateElements() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UILabel.animate(withDuration: 0.6, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.mainLabel.alpha = 1.0
                self.mainLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            UIImageView.animate(withDuration: 0.5, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.lessonIconView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.lessonIconView.alpha = 1.0
                self.lessonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.lessonLabel.alpha = 1.0
            }, completion: {
                Void in UIButton.animate(withDuration: 0.5, delay: 0.2, options: UIButton.AnimationOptions.curveEaseOut, animations: {
                    self.lessonButton.alpha = 1.0
                    self.lessonButton.transform = CGAffineTransform(translationX: 0, y: 0)
                }, completion: {
                    Void in UIButton.animate(withDuration: 0.4, animations: {
                        self.backButton.alpha = 1.0
                        self.backButton.transform = CGAffineTransform(translationX: 0, y: 0)
                    })
                })
            })
        })
        
    }
    func setGradientBackground() {
        let colorTop =  colorChange.cgColor
        var modeColor = Int()
        if traitCollection.userInterfaceStyle == .light {
            modeColor = 255
        }
        else {
            modeColor = 0
        }
        let colorBottom = UIColor(red: CGFloat(modeColor/255), green: CGFloat(modeColor/255), blue: CGFloat(modeColor/255), alpha: 1.0).cgColor
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.5]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    func check() {
        detectOrientation()
        lessonInfoLabel.alpha = 0.0
        lessonButton.transform = CGAffineTransform(translationX: 0, y: 0)
        if swipeCount > 5 {
            swipeCount = 5
        }
        if swipeCount < 1 {
            swipeCount = 1
        }
    }
    func updateBG() {
        if swipeCount > 0 && swipeCount <= 5 {
            switch swipeCount {
            case 1:
                lessonInfo = "Lesson 1 content: \n 'Greetings!'"
                if modeSwitch {
                    colorChange = #colorLiteral(red: 0.1333333333, green: 0.4980392157, blue: 0.9490196078, alpha: 1)
                }
                else {
                    colorChange = #colorLiteral(red: 0.1333333333, green: 0.1843137255, blue: 0.9490196078, alpha: 1)
                }
            case 2:
                lessonInfo = "Lesson 2 content: \n 'Countries'"
                if modeSwitch {
                    colorChange = #colorLiteral(red: 0.1333333333, green: 0.5764705882, blue: 0.9490196078, alpha: 1)
                }
                else {
                    colorChange = #colorLiteral(red: 0.1333333333, green: 0.262745098, blue: 0.9490196078, alpha: 1)
                }
            case 3:
                lessonInfo = "Lesson 3 content: \n 'Colours'"
                if modeSwitch {
                    colorChange = #colorLiteral(red: 0.1333333333, green: 0.6549019608, blue: 0.9490196078, alpha: 1)
                }
                else {
                    colorChange = #colorLiteral(red: 0.1333333333, green: 0.3411764706, blue: 0.9490196078, alpha: 1)
                }
            case 4:
                lessonInfo = "Lesson 4 content: \n 'Animals'"
                if modeSwitch {
                    colorChange = #colorLiteral(red: 0.1333333333, green: 0.7333333333, blue: 0.9490196078, alpha: 1)
                }
                else {
                    colorChange = #colorLiteral(red: 0.1333333333, green: 0.4196078431, blue: 0.9490196078, alpha: 1)
                }
            case 5:
                lessonInfo = "Lesson 5 content: \n 'Places'"
                if modeSwitch {
                    colorChange = #colorLiteral(red: 0.1333333333, green: 0.7725490196, blue: 0.9490196078, alpha: 1)
                }
                else {
                    colorChange = #colorLiteral(red: 0.1333333333, green: 0.4980392157, blue: 0.9490196078, alpha: 1)
                }
            default:
                break
            }
            UIButton.animate(withDuration: 0.5, delay: 0.2, animations: {
                
                //Updates button text
                self.lessonButton.setTitle("Lesson \(String(self.swipeCount))", for: .normal)
                
            })
            
            UIImageView.animate(withDuration: 0.4, animations: {
                self.lessonIconView.alpha = 0
                self.lessonLabel.alpha = 0
                self.lessonIconView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.lessonLabel.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                
            }, completion: {
                Void in UIImageView.animate(withDuration: 0.4, animations: {
                    
                    //Updates image icon
                    self.lessonIconView.image = UIImage(named: "Lesson\(self.swipeCount)Icon")
                    self.lessonIconView.alpha = 1.0
                    
                    //Updates Lesson label
                    self.lessonLabel.text = ("L\(self.swipeCount)")
                    self.lessonLabel.alpha = 1.0
                    
                    self.lessonIconView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.lessonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            })
            //Updates BG color
            setGradientBackground()
        }
    }
    func detectOrientation() {
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            landscapeSwitch = true
        case .portrait, .portraitUpsideDown:
            landscapeSwitch = false
        default:
            break
        }
        
    }
    func didSwipe() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.02, execute: {
            UILabel.animate(withDuration: 0.5, delay: 0.2, options: UILabel.AnimationOptions.curveEaseIn, animations: {
                self.lessonIconView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.lessonLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: {
                Void in UILabel.animate(withDuration: 0.5, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                    self.lessonIconView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.lessonLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            })
        })
    }
    func dismissInfoElements() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.5, execute: {
            UIImageView.animate(withDuration: 0.5, animations: {
                self.lessonInfoLabel.alpha = 0.0
                self.lessonIconView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                if self.landscapeSwitch {
                    self.backButton.transform = CGAffineTransform(translationX: 0, y: 0)
                }
                else {
                    self.lessonButton.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            }, completion: {
                Void in UILabel.animate(withDuration: 0.5, animations: {
                    self.lessonLabel.alpha = 1.0
                })
            })
        })
    }
    @IBAction func didSwipeLeft(_ sender: Any) {
        swipeCount += 1
        check()
        updateBG()
    }
    @IBAction func didSwipeRight(_ sender: Any) {
        swipeCount -= 1
        check()
        updateBG()
    }
    @IBAction func didTapLessonButton(_ sender: Any) {
        performSegue(withIdentifier: "QuizLesson\(swipeCount)", sender: (Any).self)
    }

    @IBAction func didTapInfo(_ sender: UITapGestureRecognizer) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UIImageView.animate(withDuration: 0.5, animations: {
                self.lessonIconView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
                self.lessonLabel.alpha = 0.0
                if self.landscapeSwitch {
                    self.backButton.transform = CGAffineTransform(translationX: 0, y: 20)
                }
                else {
                    self.lessonButton.transform = CGAffineTransform(translationX: 0, y: 20)
                }
            }, completion: {
                Void in UILabel.animate(withDuration: 0.5, animations: {
                    self.lessonInfoLabel.text = self.lessonInfo
                    self.lessonInfoLabel.alpha = 1.0
                }, completion: {
                    Void in self.dismissInfoElements()
                })
            })
        })
    }
    //Modular dif.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "QuizLesson1":
            let quizType1 = segue.destination as! Lesson1Quiz
            quizType1.lessonIdentifier = "Lesson1"
        case "QuizLesson2":
            let quizType2 = segue.destination as! Lesson2Quiz
            quizType2.lessonIdentifier = "Lesson2"
        case "QuizLesson3":
            let quizType1 = segue.destination as!
            Lesson1Quiz
            quizType1.lessonIdentifier = "Lesson3"
        case "QuizLesson4":
            let quizType2 = segue.destination as! Lesson2Quiz
            quizType2.lessonIdentifier = "Lesson4"
        case "QuizLesson5":
            let quizType1 = segue.destination as! Lesson1Quiz
            quizType1.lessonIdentifier = "Lesson5"
        default:
            break
        }
    }
}
