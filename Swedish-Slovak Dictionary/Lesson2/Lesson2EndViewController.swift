import UIKit
import Lottie

class Lesson2EndViewController: UIViewController {
    
    let animationView = AnimationView()

    @IBOutlet weak var congratsLabel: UILabel!
    
    @IBOutlet weak var continueLabel: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var quizButton: UIButton!
    @IBOutlet weak var gifView: UIImageView!
    @IBOutlet weak var gradientView: GradientViewLesson2!
    
    var toDisableLoopedAnimation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMode()
        
        //declare alpha stat
        self.congratsLabel.alpha = 0.0
        self.label2.alpha = 0.0
        self.gradientView.alpha = 0.0
        self.libraryButton.alpha = 0.0
        self.quizButton.alpha = 0.0
        self.gifView.alpha = 0.0
        self.animationView.alpha = 0.0
        
        SuccessAnimation()
        editQuizButton()
        initialDisplacement()
        animateContinueLabel()
        loadGifView()
        
        view.addSubview(gradientView)
        view.addSubview(libraryButton)
        view.addSubview(quizButton)
        view.addSubview(congratsLabel)
        view.addSubview(label2)
        view.addSubview(gifView)
        
    }
    func checkMode() {
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }
    func loadGifView(){
        gifView.loadGif(name: "CelebrationEmoji")
    }
    func initialDisplacement(){
        UIView.animate(withDuration: 1.0, animations: {
            self.quizButton.transform = CGAffineTransform(translationX: 0, y: -100)
        })
        
    }
    func editQuizButton(){
        self.quizButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4588235294, blue: 0.9490196078, alpha: 1)
        quizButton.layer.shadowColor = UIColor.black.cgColor
        quizButton.layer.shadowOpacity = 0.5
        quizButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        quizButton.layer.shadowRadius = 7.5
        quizButton.layer.cornerRadius = 25.0
    }
    func SuccessAnimation(){
        animationView.animation = Animation.named("AnimationSuccess")
        animationView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        animationView.center = view.center
        animationView.backgroundColor = .white
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1.25
        animationView.play()
        view.addSubview(animationView)
        SuccessAnimationDidLoad()
    }
    func SuccessAnimationDidLoad(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UIView.animate(withDuration: 0.3, delay: 0.2, animations: {
                self.animationView.alpha = 1.0
            })
        })
    }
    func animateContinueLabel(){
        if toDisableLoopedAnimation == false {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) {
                UILabel.animate(withDuration: 1.0, delay: 0.3, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                    self.continueLabel.alpha = 0.0
                }, completion: {
                    Void in UILabel.animate(withDuration: 1.0, delay: 0.3, options: UILabel.AnimationOptions.curveEaseIn, animations: {
                        self.continueLabel.alpha = 1.0
                    }, completion: {
                        Void in self.animateContinueLabel()
                    })
                })
            }
            
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.continueLabel.alpha = 0.0
            })
        }
    }

    @IBAction func didTapContinue(_ sender: Any) {
        
        toDisableLoopedAnimation = true
        UIView.animate(withDuration: 1.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.gradientView.alpha = 1.0
        })
        UIView.animate(withDuration: 1.5, delay: 0.5, options:
        UIView.AnimationOptions.curveEaseOut,animations: {
            self.quizButton.alpha = 1.0
            self.quizButton.transform = CGAffineTransform(translationX: 0, y: 75)
        })
        UIView.animate(withDuration: 2.0, delay: 0.6, options:
        UIView.AnimationOptions.curveEaseOut, animations: {
            self.libraryButton.alpha = 1.0
            self.congratsLabel.alpha = 1.0
            self.label2.alpha = 1.0
        })
        UIView.animate(withDuration: 2.0, delay: 0.6, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.gifView.alpha = 1.0
            self.gifView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
    }
    @IBAction func didTapButtonToLesson1Quiz(_ sender: Any) {
        UIView.animate(withDuration: 0.05, delay: 0.05, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.quizButton.backgroundColor = #colorLiteral(red: 0, green: 0.2705882353, blue: 0.4509803922, alpha: 1)
        })
    }
    @IBAction func didTapQuizButton(_ sender: Any) {
        performSegue(withIdentifier: "QuizLesson2", sender: (Any).self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "QuizLesson2") {
            let lesson2Quiz = segue.destination as! Lesson2Quiz
            lesson2Quiz.lessonIdentifier = "Lesson2"
        }
    }
}
