import UIKit

class instructionsViewController: UIViewController {

    @IBOutlet var instructions1View: UIImageView!
    @IBOutlet var instructions1StackView: UIStackView!
    
    @IBOutlet var instructions2View: UIImageView!
    @IBOutlet var instructions2Label: UILabel!
    
    @IBOutlet var instructions3View: UIImageView!
    @IBOutlet var instructions3Label: UIStackView!
    
    @IBOutlet var instructions4View: UIImageView!
    @IBOutlet var instructions4Label: UILabel!
    
    @IBOutlet var instructions5View: UIImageView!
    @IBOutlet var instructions5Label: UIStackView!
    
    @IBOutlet var instructions6View: UIImageView!
    @IBOutlet var instructions6Label: UIStackView!
    
    @IBOutlet var instructions7View: UIImageView!
    @IBOutlet var instructions7Label: UIStackView!
    
    @IBOutlet var instructions8View: UIImageView!
    @IBOutlet var instructions8Label: UIStackView!
    
    @IBOutlet var scrollView: UIScrollView!
    
    //Persistent IBOutlets
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var secondaryLabel: UILabel!
    @IBOutlet var instructions1Title: UILabel!
    @IBOutlet var instructions2Title: UILabel!
    
    @IBOutlet var instructions3Title: UILabel!
    @IBOutlet var instructions4Title: UILabel!
    
    @IBOutlet var instructions5Title: UILabel!
    @IBOutlet var instructions6Title: UILabel!
    
    @IBOutlet var instructions7Title: UILabel!
    @IBOutlet var instructions8Title: UILabel!
    
    var scrollSwitch = Bool()
    var endSwitch = Bool()
    var y = Int()
    
    var visualEffectView1 = UIVisualEffectView()
    var visualEffectView2 = UIVisualEffectView()
    var visualEffectView3 = UIVisualEffectView()
    var visualEffectView4 = UIVisualEffectView()
    var visualEffectView5 = UIVisualEffectView()
    var visualEffectView6 = UIVisualEffectView()
    var visualEffectView7 = UIVisualEffectView()
    var visualEffectView8 = UIVisualEffectView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detect()
        checkMode()
        editElements()
        initialDisplacement()
        createBlur()
    }
    func checkMode() {
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }
    func initialDisplacement() {
        
        mainLabel.alpha = 0.0
        secondaryLabel.alpha = 0.0
        secondaryLabel.transform = CGAffineTransform(translationX: 0, y: -20)
        
        //Blur effect InstructionsView1
        instructions1StackView.alpha = 0.0
        instructions1StackView.transform = CGAffineTransform(translationX: 0, y: -20)
        instructions1View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        //Blur effect InstructionsView2
        instructions2Label.alpha = 0.0
        instructions2Label.transform = CGAffineTransform(translationX: 0, y: -20)
        instructions2View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        //Blur effect InstructionsView3
        instructions3Label.alpha = 0.0
        instructions3Label.transform = CGAffineTransform(translationX: 0, y: -20)
        instructions3View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        //Blur effect InstructionsView4
        instructions4Label.alpha = 0.0
        instructions4Label.transform = CGAffineTransform(translationX: 0, y: -20)
        instructions4View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        //Blur effect InstructionsView5
        instructions5Label.alpha = 0.0
        instructions5Label.transform = CGAffineTransform(translationX: 0, y: -20)
        instructions5View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        //Blur effect InstructionsView6
        instructions6Label.alpha = 0.0
        instructions6Label.transform = CGAffineTransform(translationX: 0, y: -20)
        instructions6View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        //Blur effect InstructionsView7
        instructions7Label.alpha = 0.0
        instructions7Label.transform = CGAffineTransform(translationX: 0, y: -20)
        instructions7View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        //Blur effect InstructionsView8
        instructions8Label.alpha = 0.0
        instructions8Label.transform = CGAffineTransform(translationX: 0, y: -20)
        instructions8View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        //Block 1
        instructions1View.alpha = 0.0
        instructions2View.alpha = 0.0
        instructions1Title.alpha = 0.0
        instructions1Title.transform = CGAffineTransform(translationX: -20, y: 0)
        instructions2Title.alpha = 0.0
        instructions2Title.transform = CGAffineTransform(translationX: -20, y: 0)
        
        //Block 2
        instructions3View.alpha = 0.0
        instructions4View.alpha = 0.0
        instructions3Title.alpha = 0.0
        instructions3Title.transform = CGAffineTransform(translationX: -20, y: 0)
        instructions4Title.alpha = 0.0
        instructions4Title.transform = CGAffineTransform(translationX: -20, y: 0)
        
        //Block 3
        instructions5View.alpha = 0.0
        instructions6View.alpha = 0.0
        instructions5Title.alpha = 0.0
        instructions5Title.transform = CGAffineTransform(translationX: -20, y: 0)
        instructions6Title.alpha = 0.0
        instructions6Title.transform = CGAffineTransform(translationX: -20, y: 0)
        
        //Block 3
        instructions7View.alpha = 0.0
        instructions8View.alpha = 0.0
        instructions7Title.alpha = 0.0
        instructions7Title.transform = CGAffineTransform(translationX: -20, y: 0)
        instructions8Title.alpha = 0.0
        instructions8Title.transform = CGAffineTransform(translationX: -20, y: 0)
    }
    func editElements() {
        
        //Edit InstructionsView1
        instructions1View.layer.cornerRadius = 15.0
        instructions1View.layer.shadowColor = UIColor.black.cgColor
        instructions1View.layer.shadowOpacity = 0.75
        instructions1View.layer.shadowOffset = CGSize(width: -10, height: 10)
        instructions1View.layer.shadowRadius = 15.0
        
        //Edit InstructionsView2
        instructions2View.layer.cornerRadius = 15.0
        instructions2View.layer.shadowColor = UIColor.black.cgColor
        instructions2View.layer.shadowOpacity = 0.75
        instructions2View.layer.shadowOffset = CGSize(width: -10, height: 10)
        instructions2View.layer.shadowRadius = 15.0
        
        //Edit InstructionsView3
        instructions3View.layer.cornerRadius = 15.0
        instructions3View.layer.shadowColor = UIColor.black.cgColor
        instructions3View.layer.shadowOpacity = 0.75
        instructions3View.layer.shadowOffset = CGSize(width: -10, height: 10)
        instructions3View.layer.shadowRadius = 15.0
        
        //Edit InstructionsView4
        instructions4View.layer.cornerRadius = 15.0
        instructions4View.layer.shadowColor = UIColor.black.cgColor
        instructions4View.layer.shadowOpacity = 0.75
        instructions4View.layer.shadowOffset = CGSize(width: -10, height: 10)
        instructions4View.layer.shadowRadius = 15.0
        
        //Edit InstructionsView5
        instructions5View.layer.cornerRadius = 15.0
        instructions5View.layer.shadowColor = UIColor.black.cgColor
        instructions5View.layer.shadowOpacity = 0.75
        instructions5View.layer.shadowOffset = CGSize(width: -10, height: 10)
        instructions5View.layer.shadowRadius = 15.0
        
        //Edit InstructionsView6
        instructions6View.layer.cornerRadius = 15.0
        instructions6View.layer.shadowColor = UIColor.black.cgColor
        instructions6View.layer.shadowOpacity = 0.75
        instructions6View.layer.shadowOffset = CGSize(width: -10, height: 10)
        instructions6View.layer.shadowRadius = 15.0
        
        //Edit InstructionsView7
        instructions7View.layer.cornerRadius = 15.0
        instructions7View.layer.shadowColor = UIColor.black.cgColor
        instructions7View.layer.shadowOpacity = 0.75
        instructions7View.layer.shadowOffset = CGSize(width: -10, height: 10)
        instructions7View.layer.shadowRadius = 15.0
        
        //Edit InstructionsView8
        instructions8View.layer.cornerRadius = 15.0
        instructions8View.layer.shadowColor = UIColor.black.cgColor
        instructions8View.layer.shadowOpacity = 0.75
        instructions8View.layer.shadowOffset = CGSize(width: -10, height: 10)
        instructions8View.layer.shadowRadius = 15.0
    }
    
    func createBlur() {
        blurInstructionsView1()
        blurInstructionsView2()
        blurInstructionsView3()
        blurInstructionsView4()
        blurInstructionsView5()
        blurInstructionsView6()
        blurInstructionsView7()
        blurInstructionsView8()
    }
    func blurInstructionsView1() {
        visualEffectView1 = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView1.frame = instructions1View.bounds
        visualEffectView1.alpha = 0.75
        instructions1View.addSubview(visualEffectView1)
    }
    func blurInstructionsView2() {
        visualEffectView2 = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView2.frame = instructions2View.bounds
        visualEffectView2.alpha = 0.75
        instructions2View.addSubview(visualEffectView2)
    }
    func blurInstructionsView3() {
        visualEffectView3 = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView3.frame = instructions3View.bounds
        visualEffectView3.alpha = 0.75
        instructions3View.addSubview(visualEffectView3)
    }
    func blurInstructionsView4() {
        visualEffectView4 = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView4.frame = instructions4View.bounds
        visualEffectView4.alpha = 0.75
        instructions4View.addSubview(visualEffectView4)
    }
    func blurInstructionsView5() {
        visualEffectView5 = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView5.frame = instructions5View.bounds
        visualEffectView5.alpha = 0.75
        instructions5View.addSubview(visualEffectView5)
    }
    func blurInstructionsView6() {
        visualEffectView6 = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView6.frame = instructions6View.bounds
        visualEffectView6.alpha = 0.75
        instructions6View.addSubview(visualEffectView6)
    }
    func blurInstructionsView7() {
        visualEffectView7 = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView7.frame = instructions7View.bounds
        visualEffectView7.alpha = 0.75
        instructions7View.addSubview(visualEffectView7)
    }
    func blurInstructionsView8() {
        visualEffectView8 = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView8.frame = instructions8View.bounds
        visualEffectView8.alpha = 0.75
        instructions8View.addSubview(visualEffectView8)
    }
    
    @IBAction func didTapInstructionsView1(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.visualEffectView1.alpha = 0.0
                self.instructions1View.transform = .identity
                self.instructions1StackView.transform = .identity
                self.instructions1StackView.alpha = 1.0
            }, completion: {
                Void in DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.visualEffectView1.alpha = 0.75
                        self.instructions1View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.instructions1StackView.transform = CGAffineTransform(translationX: 0, y: -20)
                        self.instructions1StackView.alpha = 0.0
                    })
                })
            })
        })
    }
    @IBAction func didTapInstructionsView2(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.visualEffectView2.alpha = 0.0
                self.instructions2View.transform = .identity
                self.instructions2Label.transform = .identity
                self.instructions2Label.alpha = 1.0
            }, completion: {
                Void in DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.visualEffectView2.alpha = 0.75
                        self.instructions2View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.instructions2Label.transform = CGAffineTransform(translationX: 0, y: -20)
                        self.instructions2Label.alpha = 0.0
                    })
                })
            })
        })
    }
    @IBAction func didTapInstructionsView3(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.visualEffectView3.alpha = 0.0
                self.instructions3View.transform = .identity
                self.instructions3Label.transform = .identity
                self.instructions3Label.alpha = 1.0
            }, completion: {
                Void in DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.visualEffectView3.alpha = 0.75
                        self.instructions3View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.instructions3Label.transform = CGAffineTransform(translationX: 0, y: -20)
                        self.instructions3Label.alpha = 0.0
                    })
                })
            })
        })
    }
    @IBAction func didTapInstructionsView4(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.visualEffectView4.alpha = 0.0
                self.instructions4View.transform = .identity
                self.instructions4Label.transform = .identity
                self.instructions4Label.alpha = 1.0
            }, completion: {
                Void in DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.visualEffectView4.alpha = 0.75
                        self.instructions4View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.instructions4Label.transform = CGAffineTransform(translationX: 0, y: -20)
                        self.instructions4Label.alpha = 0.0
                    })
                })
            })
        })
    }
    @IBAction func didTapInstructionsView5(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.visualEffectView5.alpha = 0.0
                self.instructions5View.transform = .identity
                self.instructions5Label.transform = .identity
                self.instructions5Label.alpha = 1.0
            }, completion: {
                Void in DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.visualEffectView5.alpha = 0.75
                        self.instructions5View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.instructions5Label.transform = CGAffineTransform(translationX: 0, y: -20)
                        self.instructions5Label.alpha = 0.0
                    })
                })
            })
        })
    }
    @IBAction func didTapInstructionsView6(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.visualEffectView6.alpha = 0.0
                self.instructions6View.transform = .identity
                self.instructions6Label.transform = .identity
                self.instructions6Label.alpha = 1.0
            }, completion: {
                Void in DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.visualEffectView6.alpha = 0.75
                        self.instructions6View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.instructions6Label.transform = CGAffineTransform(translationX: 0, y: -20)
                        self.instructions6Label.alpha = 0.0
                    })
                })
            })
        })
    }
    @IBAction func didTapInstructionsView7(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.visualEffectView7.alpha = 0.0
                self.instructions7View.transform = .identity
                self.instructions7Label.transform = .identity
                self.instructions7Label.alpha = 1.0
            }, completion: {
                Void in DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.visualEffectView7.alpha = 0.75
                        self.instructions7View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.instructions7Label.transform = CGAffineTransform(translationX: 0, y: -20)
                        self.instructions7Label.alpha = 0.0
                    })
                })
            })
        })
    }
    @IBAction func didTapInstructionsView8(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UIView.animate(withDuration: 0.5, animations: {
                self.visualEffectView8.alpha = 0.0
                self.instructions8View.transform = .identity
                self.instructions8Label.transform = .identity
                self.instructions8Label.alpha = 1.0
            }, completion: {
                Void in DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.5, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.visualEffectView8.alpha = 0.75
                        self.instructions8View.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.instructions8Label.transform = CGAffineTransform(translationX: 0, y: -20)
                        self.instructions8Label.alpha = 0.0
                    })
                })
            })
        })
    }
    func detect() {
        if scrollView.isTracking {
            scrollSwitch = true
        }
        else {
            scrollSwitch = false
        }
        if endSwitch == false {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
                self.detect()
            })
            determinePosition()
        }
    }
    func determinePosition() {
        switch scrollSwitch {
        case true:
            let scrollPosition = scrollView.contentOffset
            y = Int(scrollPosition.y)
        default:
            break
        }
        detectAnimation()
    }
    func detectAnimation() {
        if y < 50 {
            animationBlock1()
        }
        else if y > 200 && y < 550 {
            animationBlock3()
        }
        else if y > 550 && y < 800 {
            animationBlock4()
        }
        else if y > 820 {
            endSwitch = true
        }
    }
    func animationBlock1() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            UILabel.animate(withDuration: 0.75, animations: {
                self.mainLabel.alpha = 1.0
            }, completion: {
                Void in UILabel.animate(withDuration: 0.5, animations: {
                    self.secondaryLabel.transform = .identity
                    self.secondaryLabel.alpha = 1.0
                })
            })
            UIImageView.animate(withDuration: 1.0, delay: 0.2, options: UIImageView.AnimationOptions.curveEaseOut, animations: {
                self.instructions1View.alpha = 1.0
                self.instructions2View.alpha = 1.0
                self.instructions1Title.alpha = 1.0
                self.instructions1Title.transform = .identity
                self.instructions2Title.alpha = 1.0
                self.instructions2Title.transform = .identity
            }, completion: {
                Void in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: {
                    self.animationBlock2()
                })
            })
        })
    }
    func animationBlock2() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            UIImageView.animate(withDuration: 1.0, delay: 0.2, options: UIImageView.AnimationOptions.curveEaseOut, animations: {
                self.instructions3View.alpha = 1.0
                self.instructions4View.alpha = 1.0
                self.instructions3Title.alpha = 1.0
                self.instructions3Title.transform = .identity
                self.instructions4Title.alpha = 1.0
                self.instructions4Title.transform = .identity
            })
        })
        
    }
    func animationBlock3() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            UIImageView.animate(withDuration: 1.0, delay: 0.2, options: UIImageView.AnimationOptions.curveEaseOut, animations: {
                self.instructions5View.alpha = 1.0
                self.instructions6View.alpha = 1.0
                self.instructions5Title.alpha = 1.0
                self.instructions5Title.transform = .identity
                self.instructions6Title.alpha = 1.0
                self.instructions6Title.transform = .identity
            })
        })
        
    }
    func animationBlock4() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2, execute: {
            UIImageView.animate(withDuration: 1.0, delay: 0.2, options: UIImageView.AnimationOptions.curveEaseOut, animations: {
                self.instructions7View.alpha = 1.0
                self.instructions8View.alpha = 1.0
                self.instructions7Title.alpha = 1.0
                self.instructions7Title.transform = .identity
                self.instructions8Title.alpha = 1.0
                self.instructions8Title.transform = .identity
            })
        })
        
    }
}
