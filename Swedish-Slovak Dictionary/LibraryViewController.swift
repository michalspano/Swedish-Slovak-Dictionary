import UIKit
import AVFoundation

class LibraryViewController: UIViewController {

    @IBOutlet weak var libraryLabel: UILabel!
    @IBOutlet weak var lessonButtonsStackView: UIStackView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var videoLayer: UIView! //videoLayer IBOutlter reference did load
    @IBOutlet weak var lesson1Button: UIButton!
    @IBOutlet weak var lesson2Button: UIButton!
    @IBOutlet weak var lesson3Button: UIButton!
    @IBOutlet weak var lesson4Button: UIButton!
    @IBOutlet weak var lesson5Button: UIButton!
    @IBOutlet weak var lesson1Label: UILabel!
    @IBOutlet weak var lesson2Label: UILabel!
    @IBOutlet weak var lesson3Label: UILabel!
    @IBOutlet weak var lesson4Label: UILabel!
    @IBOutlet weak var lesson5Label: UILabel!
    @IBOutlet var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialDisplacement()
        playVideo()
        editButtons()
        editlessonLabel()
    }
    func editButtons(){
        //editButton1
        lesson1Button.layer.shadowColor = UIColor.black.cgColor
        lesson1Button.layer.shadowOpacity = 0.35
        lesson1Button.layer.shadowOffset = CGSize(width: -1, height: 1)
        lesson1Button.layer.shadowRadius = 3.0
        
        //editButton2
        lesson2Button.layer.shadowColor = UIColor.black.cgColor
        lesson2Button.layer.shadowOpacity = 0.35
        lesson2Button.layer.shadowOffset = CGSize(width: -1, height: 1)
        lesson2Button.layer.shadowRadius = 3.0
        
        //editButton3
        lesson3Button.layer.shadowColor = UIColor.black.cgColor
        lesson3Button.layer.shadowOpacity = 0.35
        lesson3Button.layer.shadowOffset = CGSize(width: -1, height: 1)
        lesson3Button.layer.shadowRadius = 3.0
        
        //editButton4
        lesson4Button.layer.shadowColor = UIColor.black.cgColor
        lesson4Button.layer.shadowOpacity = 0.35
        lesson4Button.layer.shadowOffset = CGSize(width: -1, height: 1)
        lesson4Button.layer.shadowRadius = 3.0
        
        //editButton5
        lesson5Button.layer.shadowColor = UIColor.black.cgColor
        lesson5Button.layer.shadowOpacity = 0.35
        lesson5Button.layer.shadowOffset = CGSize(width: -1, height: 1)
        lesson5Button.layer.shadowRadius = 3.0

    }
    func editlessonLabel(){
        
        //edit lesson1Label
        lesson1Label.layer.shadowColor = UIColor.black.cgColor
        lesson1Label.layer.shadowOpacity = 0.2
        lesson1Label.layer.shadowOffset = CGSize(width: -1, height: 1)
        lesson1Label.layer.shadowRadius = 3.0
        
        //edit lesson2Label
        lesson2Label.layer.shadowColor = UIColor.black.cgColor
        lesson2Label.layer.shadowOpacity = 0.2
        lesson2Label.layer.shadowOffset = CGSize(width: -1, height: 1)
        lesson2Label.layer.shadowRadius = 3.0
        
        //edit lesson3Label
        lesson3Label.layer.shadowColor = UIColor.black.cgColor
        lesson3Label.layer.shadowOpacity = 0.2
        lesson3Label.layer.shadowOffset = CGSize(width: -1, height: 1)
        lesson3Label.layer.shadowRadius = 3.0
        
        //edit lesson4Label
        lesson4Label.layer.shadowColor = UIColor.black.cgColor
        lesson4Label.layer.shadowOpacity = 0.2
        lesson4Label.layer.shadowOffset = CGSize(width: -1, height: 1)
        lesson4Label.layer.shadowRadius = 3.0
        
        //edit lesson5Label
        lesson5Label.layer.shadowColor = UIColor.black.cgColor
        lesson5Label.layer.shadowOpacity = 0.2
        lesson5Label.layer.shadowOffset = CGSize(width: -1, height: 1)
        lesson5Label.layer.shadowRadius = 3.0
        
        
    }

    func playVideo(){
        guard let path = Bundle.main.path(forResource: "VideoBG", ofType: "mp4") else {
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = self.view.bounds
        self.videoLayer.layer.addSublayer(playerLayer)
        
        player.play()
        loadVideoView()
        
        //to view elements
        videoLayer.bringSubviewToFront(libraryLabel)
        videoLayer.bringSubviewToFront(lessonButtonsStackView)
        videoLayer.bringSubviewToFront(homeButton)
        videoLayer.bringSubviewToFront(dimView)
            
    }
    
    func loadVideoView() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UIView.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.videoLayer.alpha = 1.0
            })
        })
    }
    func initialDisplacement(){
        
        videoLayer.alpha = 0.0
        self.lessonButtonsStackView.transform = CGAffineTransform(translationX: -90, y: 0)
        self.lessonButtonsStackView.alpha = 0.0
        
        self.libraryLabel.transform = CGAffineTransform(translationX: 0, y: -30)
        self.libraryLabel.alpha = 0.0
        
        //initials for lesson1Label
        self.lesson1Label.alpha = 0.0
        self.lesson1Label.transform = CGAffineTransform(
            translationX: 50,
            y: 0)
        
        //initials for lesson2Label
        self.lesson2Label.alpha = 0.0
        self.lesson2Label.transform = CGAffineTransform(
            translationX: 50,
            y: 0)
        
        //initials for lesson3Label
        self.lesson3Label.alpha = 0.0
        self.lesson3Label.transform = CGAffineTransform(
            translationX: 50,
            y: 0)
        
        //initials for lesson4Label
        self.lesson4Label.alpha = 0.0
        self.lesson4Label.transform = CGAffineTransform(
            translationX: 50,
            y: 0)
        
        //initials for lesson5Label
        self.lesson5Label.alpha = 0.0
        self.lesson5Label.transform = CGAffineTransform(
            translationX: 50,
            y: 0)

        animate()
    }
    
    func animate(){
        let s = 0.25
        let toDelay = DispatchTime.now() + s
        
        //instantiate delay for UIAnimation with DispatchQueue
        DispatchQueue.main.asyncAfter(deadline: toDelay) {
            UIStackView.animate(withDuration: 1.0, delay: 0.3, options: UIStackView.AnimationOptions.curveEaseOut, animations: {
                self.lessonButtonsStackView.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
                self.lessonButtonsStackView.alpha = 1.0
                
            })
            UILabel.animate(withDuration: 1.0, delay: 0.2, options: UIStackView.AnimationOptions.curveEaseOut, animations: {
                self.libraryLabel.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
                self.libraryLabel.alpha = 1.0
                
            })
            UILabel.animate(withDuration: 1.0, delay: 0.4, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.lesson1Label.alpha = 1.0
                self.lesson1Label.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
            })
            UILabel.animate(withDuration: 1.0, delay: 0.5, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.lesson2Label.alpha = 1.0
                self.lesson2Label.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
            })
            UILabel.animate(withDuration: 1.0, delay: 0.6, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.lesson3Label.alpha = 1.0
                self.lesson3Label.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
            })
            
            UILabel.animate(withDuration: 1.0, delay: 0.7, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.lesson4Label.alpha = 1.0
                self.lesson4Label.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
            })
            UILabel.animate(withDuration: 1.0, delay: 0.8, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.lesson5Label.alpha = 1.0
                self.lesson5Label.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
            })
        }
    }
    
    //to do when lesson1Button is pressed (Button-action)
    @IBAction func didTapLesson1Button(_ sender: Any) {
        
        //animate Button
        UIButton.animate(withDuration: 0.1, animations: {
            self.lesson1Button.transform = CGAffineTransform(
                scaleX: 1.2,
                y: 1.2)
        }, completion: {
            Void in UIButton.animate(withDuration: 0.1, animations: {
                self.lesson1Button.transform = CGAffineTransform(
                    scaleX: 1.0,
                    y: 1.0)
            })
        })
        
        //animate Label
        UILabel.animate(withDuration: 0.5, animations: {
            self.lesson1Label.alpha = 0.8
            self.lesson1Label.transform = CGAffineTransform(
                scaleX: 1.5,
                y: 1.5)
            self.lesson1Label.transform = CGAffineTransform(
                translationX: 20,
                y: 0)
        })
    }
    
    //to do when lesson2Button is pressed (Button-action)
    @IBAction func didTapLesson2BUtton(_ sender: Any) {
        UILabel.animate(withDuration: 0.5, animations: {
            
            //animate Button
            UIButton.animate(withDuration: 0.1, animations: {
                self.lesson2Button.transform = CGAffineTransform(
                    scaleX: 1.2,
                    y: 1.2)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.1, animations: {
                    self.lesson2Button.transform = CGAffineTransform(
                        scaleX: 1.0,
                        y: 1.0)
                })
            })
            
            self.lesson2Label.transform = CGAffineTransform(
                scaleX: 1.5,
                y: 1.5)
            self.lesson2Label.transform = CGAffineTransform(
                translationX: 20,
                y: 0)
        })
        
    }
    
    //to do when lesson3Button is pressed (Button-action)
    @IBAction func didTapLesson3Button(_ sender: Any) {
        UILabel.animate(withDuration: 0.5, animations: {
            
            //animate Button
            UIButton.animate(withDuration: 0.1, animations: {
                self.lesson3Button.transform = CGAffineTransform(
                    scaleX: 1.2,
                    y: 1.2)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.1, animations: {
                    self.lesson3Button.transform = CGAffineTransform(
                        scaleX: 1.0,
                        y: 1.0)
                })
            })
            
            self.lesson3Label.transform = CGAffineTransform(
                scaleX: 1.5,
                y: 1.5)
            self.lesson3Label.transform = CGAffineTransform(
                translationX: 20,
                y: 0)
        })
        
    }
    //to do when lesson4Button is pressed (Button-action)
    @IBAction func didTapLesson4Button(_ sender: Any) {
        UILabel.animate(withDuration: 0.5, animations: {
            
            //animate Button
            UIButton.animate(withDuration: 0.1, animations: {
                self.lesson4Button.transform = CGAffineTransform(
                    scaleX: 1.2,
                    y: 1.2)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.1, animations: {
                    self.lesson4Button.transform = CGAffineTransform(
                        scaleX: 1.0,
                        y: 1.0)
                })
            })
            
            self.lesson4Label.transform = CGAffineTransform(
                scaleX: 1.5,
                y: 1.5)
            self.lesson4Label.transform = CGAffineTransform(
                translationX: 20,
                y: 0)
        })
    }
    
    //to do when lesson5Button is pressed (Button-action)
    @IBAction func didTapLesson5Button(_ sender: Any) {
        UILabel.animate(withDuration: 0.5, animations: {
            
            //animate Button
            UIButton.animate(withDuration: 0.1, animations: {
                self.lesson5Button.transform = CGAffineTransform(
                    scaleX: 1.2,
                    y: 1.2)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.1, animations: {
                    self.lesson5Button.transform = CGAffineTransform(
                        scaleX: 1.0,
                        y: 1.0)
                })
            })
            
            self.lesson5Label.transform = CGAffineTransform(
                scaleX: 1.5,
                y: 1.5)
            self.lesson5Label.transform = CGAffineTransform(
                translationX: 20,
                y: 0)
        })
    }
}
