import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //declare @IBOutlets here;
    @IBOutlet weak var thankYouLabel: UILabel!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var startNowButton: UIButton!
    @IBOutlet weak var instructionsButton: UIButton!
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var fadeOutView: UIView!
    @IBOutlet weak var fadeOutLogo: UIImageView!
    @IBOutlet weak var fadeOutLabel: UILabel!
    
    var startupSoundEffect = AVAudioPlayer()
    
    var toHandleSound = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fadeOutView.alpha = 1.0
        self.fadeOutLogo.alpha = 1.0
        self.fadeOutLabel.alpha = 1.0
        self.thankYouLabel.alpha = 0.0
        
        toPerfromFadeOut()
        
        editThankYouLabel()
        editStartNowButton()
        editInstructionsButton()
        editQuizButton()
        editNotesButton()
        editMainElemnt()
        
        initialDisplacement()
        
    }

    //start up animation from launchscreen
    func toPerfromFadeOut(){
        print(toHandleSound)
        do {
            startupSoundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "startupSoundEffect", ofType: "wav")!))
            startupSoundEffect.prepareToPlay()
        } catch {}
        
        //play startup Sound
        if toHandleSound == true {
            self.startupSoundEffect.play()
            startupSoundEffect.volume = 0.5
        }
        //proceed to animations
        UIView.animate(withDuration: 1.3, animations: {
            self.fadeOutView.alpha = 0.0
        })
        
        UILabel.animate(withDuration: 0.5, animations: {
            self.fadeOutLabel.alpha = 0.0
        })
        UIImageView.animate(withDuration: 1.3, delay: 0.3, options: UIImageView.AnimationOptions.curveEaseOut, animations: {
            self.fadeOutLogo.transform = CGAffineTransform(
                scaleX: 3.5,
                y: 3.5)
            self.fadeOutLogo.alpha = 0.0
        })
        
    }
    func initialDisplacement(){
        self.mainTitle.transform = CGAffineTransform(
            translationX: 0,
            y: -50)
        self.instagramButton.transform = CGAffineTransform(
            translationX: 0,
            y: 50)
        self.startNowButton.alpha = 0.0
        self.startNowButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        self.instructionsButton.alpha = 0.0
        self.instructionsButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        self.quizButton.alpha = 0.0
        self.quizButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.notesButton.alpha = 0.0
        self.notesButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        toAnimateElements()
    }
    func toAnimateElements(){
        UILabel.animate(withDuration: 0.8, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
            self.mainTitle.transform = CGAffineTransform(
                translationX: 0,
                y: 0)
        })
        UIButton.animate(withDuration: 0.8, delay: 0.2, options: UIButton.AnimationOptions.curveEaseOut, animations: {
            self.instagramButton.transform = CGAffineTransform(
                translationX: 0,
                y: 0)
        })
        UIButton.animate(withDuration: 0.8, delay: 0.3, options: UIButton.AnimationOptions.curveEaseOut, animations: {
            self.startNowButton.alpha = 1.0
            self.startNowButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
        UIButton.animate(withDuration: 0.8, delay: 0.5, options: UIButton.AnimationOptions.curveEaseOut, animations: {
            self.instructionsButton.alpha = 1.0
            self.instructionsButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
        UIButton.animate(withDuration: 0.8, delay: 0.7, options: UIButton.AnimationOptions.curveEaseOut, animations: {
            self.quizButton.alpha = 1.0
            self.quizButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
        UIButton.animate(withDuration: 0.8, delay: 0.9, options: UIButton.AnimationOptions.curveEaseOut, animations: {
            self.notesButton.alpha = 1.0
            self.notesButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        })
        
    }
    func editMainElemnt(){
        mainTitle.layer.shadowColor = UIColor.black.cgColor
        mainTitle.layer.shadowOpacity = 0.5
        mainTitle.layer.shadowOffset = CGSize(width: -1, height: 1)
        mainTitle.layer.shadowRadius = 5.0
        
    }
    func editStartNowButton(){
        startNowButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4980392157, blue: 0.9490196078, alpha: 1)
        startNowButton.layer.shadowColor = UIColor.black.cgColor
        startNowButton.layer.shadowOpacity = 0.5
        startNowButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        startNowButton.layer.shadowRadius = 5.0
        startNowButton.layer.cornerRadius = 25.0
    }
    func editInstructionsButton(){
        instructionsButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4588235294, blue: 0.9490196078, alpha: 1)
        instructionsButton.layer.shadowColor = UIColor.black.cgColor
        instructionsButton.layer.shadowOpacity = 0.5
        instructionsButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        instructionsButton.layer.shadowRadius = 5.0
        instructionsButton.layer.cornerRadius = 25.0
    
    }
    func editQuizButton(){
        quizButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4196078431, blue: 0.9490196078, alpha: 1)
        quizButton.layer.shadowColor = UIColor.black.cgColor
        quizButton.layer.shadowOpacity = 0.5
        quizButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        quizButton.layer.shadowRadius = 5.0
        quizButton.layer.cornerRadius = 25.0
        
    }
    func editNotesButton() {
        notesButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4196078431, blue: 0.9490196078, alpha: 1)
        notesButton.layer.shadowColor = UIColor.black.cgColor
        notesButton.layer.shadowOpacity = 0.5
        notesButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        notesButton.layer.shadowRadius = 5.0
        notesButton.layer.cornerRadius = 25.0
        
    }
    func editIgLogo(){
        instagramButton.layer.shadowColor = UIColor.black.cgColor
        instagramButton.layer.shadowOpacity = 0.5
        instagramButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        instagramButton.layer.shadowRadius = 2.5
    }
    func editThankYouLabel(){
        instagramButton.layer.shadowColor = UIColor.black.cgColor
        instagramButton.layer.shadowOpacity = 0.3
        instagramButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        instagramButton.layer.shadowRadius = 1.5
        
    }
    
    //open Instagram profile on button click
    @IBAction func didTapInstagramLink(_ sender: Any) {
        UIApplication.shared.open(URL(string:"https://www.instagram.com/svenskaforforeigners/")! as URL, options: [:], completionHandler: nil)
        UIView.animate(withDuration: 1.0, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.thankYouLabel.transform = CGAffineTransform(translationX: 0, y: -55)
            self.thankYouLabel.alpha = 0.8
        })
    }
    @IBAction func didTapStartNowButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {
        self.startNowButton.backgroundColor = #colorLiteral(red: 0.03087398054, green: 0.1198029617, blue: 0.2282702513, alpha: 1)
        self.startNowButton.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        })
    }
    @IBAction func didTapInstructionsButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {
        self.instructionsButton.backgroundColor = #colorLiteral(red: 0.02645955533, green: 0.1026732879, blue: 0.1956317015, alpha: 1)
        self.instructionsButton.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        })
    }
    @IBAction func didTapQuizButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {
        self.quizButton.backgroundColor = #colorLiteral(red: 0.02222043604, green: 0.09191779225, blue: 0.174949646, alpha: 1)
        self.quizButton.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        })
    }
    
}

