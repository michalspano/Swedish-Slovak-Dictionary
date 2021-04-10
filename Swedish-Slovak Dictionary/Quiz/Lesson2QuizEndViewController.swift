import UIKit
import AVFoundation

class Lesson2QuizEndViewController: UIViewController {
    
    @IBOutlet weak var successGifImageView: UIImageView!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var wellDoneLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var lessonButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    var finalScore = String()
    var finalScoreTextLabel = String()
    var identifier = Int()
    
    var popSoundEffect = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMode()
        
        updateLessonButton()
        animateSuccessView()
        editRetryButton()
        editWellDoneLabel()
        editLesson2Button()
        editMenuButton()
        initialDisplacement()
        
        do {
            popSoundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "popSoundEffect", ofType: "wav")!))
            popSoundEffect.prepareToPlay()
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
    func updateLessonButton() {
        lessonButton.setTitle("Lesson \(identifier)", for: .normal)
        
    }
    
    //Previous Core Data Model, implemeted Dec 2020, depricated as of March 2021
    
    /* override func viewDidAppear(_ animated: Bool) {
        if let text = UserDefaults.standard.object(forKey: "lesson2Completion") as? String {
            print("Lesson \(text) was completed.")
            
        } else {}
    } */
    func editWellDoneLabel(){
        
        //editWellDoneLabel
        wellDoneLabel.layer.shadowColor = UIColor.black.cgColor
        wellDoneLabel.layer.shadowOpacity = 0.35
        wellDoneLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        wellDoneLabel.layer.shadowRadius = 3.5
        
        //to instantiate initial displacement
        initialDisplacement()
    }
    func editRetryButton(){
        
        //to edit retryButton
        retryButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.3411764706, blue: 0.9490196078, alpha: 1)
        retryButton.layer.shadowColor = UIColor.black.cgColor
        retryButton.layer.shadowOpacity = 0.35
        retryButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        retryButton.layer.shadowRadius = 5.0
        retryButton.layer.cornerRadius = 20.0
    }
    func editLesson2Button(){
        
        //to edit lesson2Button
        lessonButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2823529412, blue: 0.9490196078, alpha: 1)
        lessonButton.layer.shadowColor = UIColor.black.cgColor
        lessonButton.layer.shadowOpacity = 0.35
        lessonButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        lessonButton.layer.shadowRadius = 5.0
        lessonButton.layer.cornerRadius = 20.0
    }
    func editMenuButton(){
        
        //to edit menuButton
        menuButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.2235294118, blue: 0.9490196078, alpha: 1)
        menuButton.layer.shadowColor = UIColor.black.cgColor
        menuButton.layer.shadowOpacity = 0.35
        menuButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        menuButton.layer.shadowRadius = 5.0
        menuButton.layer.cornerRadius = 20.0
        
        //edit ScoreView
        scoreView.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.3803921569, blue: 0.9490196078, alpha: 1)
        scoreView.layer.shadowColor = UIColor.black.cgColor
        scoreView.layer.shadowOpacity = 0.5
        scoreView.layer.shadowOffset = CGSize(width: -1, height: 1)
        scoreView.layer.shadowRadius = 7.5
        
    }
    func initialDisplacement(){
        //initial alpha phase
        self.wellDoneLabel.alpha = 0.0
        self.scoreView.alpha = 0.0
        self.finalScoreLabel.alpha = 0.0
        self.retryButton.alpha = 0.0
        self.lessonButton.alpha = 0.0
        self.menuButton.alpha = 0.0
        self.wellDoneLabel.transform = CGAffineTransform(
            translationX: 0,
            y: -30)
        self.retryButton.transform = CGAffineTransform(
            translationX: 0,
            y: 50)
        self.lessonButton.transform = CGAffineTransform(
            translationX: 0,
            y: 50)
        self.menuButton.transform = CGAffineTransform(
            translationX: 0,
            y: 50)
    }
    func animateSuccessView(){
        self.successGifImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        view.addSubview(successGifImageView)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            self.successGifImageView.loadGif(name: "successAnimation")
            UIImageView.animate(withDuration: 1.8, delay: 0.5, options: UIImageView.AnimationOptions.curveEaseOut, animations: {
                self.successGifImageView.alpha = 1.0
                self.successGifImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: {
                Void in UIImageView.animate(withDuration: 0.5, animations: {
                    self.successGifImageView.alpha = 0.0
                    self.showScore()
                })
            })
            
        })
        
    }
    func showScore(){
        updateScoreViewColor()
        let s = 0.30
        let toDelay = DispatchTime.now() + s
        
        //to delay sound of delay seconds
        DispatchQueue.main.asyncAfter(deadline: toDelay) {
            self.popSoundEffect.play()
            self.popSoundEffect.volume = 0.75
        }
        
        self.finalScoreLabel.text = String(finalScore) + "/10"
        self.wellDoneLabel.text = finalScoreTextLabel
        UIView.animate(withDuration: 0.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.scoreView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.scoreView.alpha = 1.0
            self.finalScoreLabel.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
            self.finalScoreLabel.alpha = 1.0
            
        })
        UIView.animate(withDuration: 0.2, animations: {
            self.scoreView.layer.cornerRadius = 50
        })
        UILabel.animate(withDuration: 0.3, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
            
            //animate wellDoneLabel
            self.wellDoneLabel.alpha = 1.0
            self.wellDoneLabel.transform = CGAffineTransform(
                translationX: 0,
                y: 30)
            
            //animate retryButton
            self.retryButton.alpha = 1.0
            self.retryButton.transform = CGAffineTransform(
                translationX: 0,
                y: -50)
            
            //animate Lesson2Button
            self.lessonButton.alpha = 1.0
            self.lessonButton.transform = CGAffineTransform(
                translationX: 0,
                y: -50)
            
            //animate menuButton
            self.menuButton.alpha = 1.0
            self.menuButton.transform = CGAffineTransform(
                translationX: 0,
                y: -50)
        })
        
    }
    func updateScoreViewColor(){
        self.scoreView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.15, alpha: 1.0)
        UIView.animate(withDuration: 3.0, animations: {
            self.scoreView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.75, alpha: 1.0)
        }, completion: {
            Void in UIView.animate(withDuration: 3.0, animations: {
                self.scoreView.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.15, alpha: 1.0)
            }, completion: {
                Void in self.updateScoreViewColor()
            })
        })
    }
    @IBAction func didTapLessonButton(_ sender: Any) {
        performSegue(withIdentifier: "fromLesson\(identifier-1)QuizToLesson\(identifier)", sender: (Any).self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromLesson4QuizToLesson5") {
            let targetVC = segue.destination as! Lesson4ViewController
            targetVC.lessonIdentifier = "Lesson 5"
        }
    }
    
}
