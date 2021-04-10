import UIKit
import AVFoundation
import Foundation

class Lesson2Quiz: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var transitionView: QuizLibraryGradientView!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var arrowIcon: UIImageView!
    
    var lessonIdentifier = String()
    var id = Int()
    
    var questions: [String] = []
    var answers: [String] = []
    
    var index = Array<Int>()
    
    var QuestionNumber = Int()
    var removeQuestion = Int()
    var inputTextFieldText = String()
    
    var score = 0
    
    var blueColorAmount: Double = 1.0
    
    var scoreTextLabel = String()
    
    var wrongSoundEffect = AVAudioPlayer()
    var correctSoundEffect = AVAudioPlayer()
    var popSoundEffect = AVAudioPlayer()
    var successSoundEffect = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMode()
        lessonAssets()
        textField.delegate = self
        editElements()
        initialDisplacement()
        updateColorForQuestionLabel()
        
        //prepare UIDesign
        do {
            wrongSoundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "wrongAnswerSoundEffect", ofType: "wav")!))
            correctSoundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "correctAnswerSoundEffect", ofType: "wav")!))
            
            successSoundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "successSoundEffect", ofType: "wav")!))
            
            popSoundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "popSoundEffect", ofType: "wav")!))
            
            //prepare to play Sound UI
            wrongSoundEffect.prepareToPlay()
            successSoundEffect.prepareToPlay()
            correctSoundEffect.prepareToPlay()
            popSoundEffect.prepareToPlay()
            
        //print error if not loaded
        } catch let error {
            print(error.localizedDescription)
            
        }
        
        //read from local txt files from dataStructure
        do {
            let directory1: String = Bundle.main.path(forResource: "Lesson\(id)SlovakData", ofType: "txt")!
            let file1 = try String(contentsOfFile: directory1)
            questions = file1.components(separatedBy: "\n")
            
            let directory2: String = Bundle.main.path(forResource: "Lesson\(id)SwedishData", ofType: "txt")!
            let file2 = try String(contentsOfFile: directory2)
            answers = file2.components(separatedBy: "\n")
            
        } catch {}
        
        //remove index 10 for "" -> prevent error
        questions.remove(at: 10)
        answers.remove(at: 10)
        
        //create array for amount of questions
        for i in 0..<Int(questions.count) {
            index.append(Int(i))
        }
        updateQuestionLabel()
        updateScoreLabel()

    }
    
    func checkMode() {
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }
    
    func lessonAssets() {
        switch lessonIdentifier {
        case "Lesson2":
            id = 2
        case "Lesson4":
            id = 4
        default:
            break
        }
        mainLabel.text = "Lesson \(id) Quiz"
    }
    
    // use UserDefault to present global variablie
    /* func writeToTextFile() {
       
        UserDefaults.standard.setValue("2", forKey: "lesson2Completion")
        
    } */
    func animateArrowIcon() {
        if Int(blueColorAmount) == Int(1.0) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
                UIImageView.animate(withDuration: 0.8, animations: {
                    self.arrowIcon.transform = CGAffineTransform(translationX: 5, y: 0)
                    self.arrowIcon.alpha = 0.6
                }, completion: {_ in
                    UIImageView.animate(withDuration: 0.8, animations: {
                        self.arrowIcon.transform = CGAffineTransform(translationX: -5, y: 0)
                        self.arrowIcon.alpha = 0.0
                    }, completion: {
                        Void in self.animateArrowIcon()
                    })
                })
            })
        }
        else {
            self.arrowIcon.alpha = 0.0
        }
    }
    
    //dismisses keyboard after prompt
    func dismissKeyboard() {
        textField.resignFirstResponder()
    }
    
    //adds return key to User Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //tap Gesture Recog. for dismissKeyboard
    @IBAction func didTapDismissKeyboard(_ sender: Any) {
        dismissKeyboard()
    }
    func editElements(){
        //edit Lesson2 Quiz label
        mainLabel.layer.shadowColor = UIColor.black.cgColor
        mainLabel.layer.shadowOpacity = 0.25
        mainLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        mainLabel.layer.shadowRadius = 5.0
        
        //edit scoreLabel
        scoreLabel.layer.backgroundColor = #colorLiteral(red: 0.05997246763, green: 0.1288298523, blue: 0.5649524613, alpha: 1)
        scoreLabel.layer.cornerRadius = 25
        scoreLabel.layer.masksToBounds = true
        
        scoreLabel.layer.shadowColor = UIColor.black.cgColor
        scoreLabel.layer.shadowOpacity = 0.4
        scoreLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        scoreLabel.layer.shadowRadius = 7.0
        
        //edit doneButton
        doneButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.3411764706, blue: 0.9490196078, alpha: 1)
        doneButton.layer.shadowColor = UIColor.black.cgColor
        doneButton.layer.shadowOpacity = 0.35
        doneButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        doneButton.layer.shadowRadius = 5.0
        doneButton.layer.cornerRadius = 20.0
    }
    func initialDisplacement(){
        self.mainLabel.transform = CGAffineTransform(translationX: 0, y: -30)
        self.mainLabel.alpha = 0.0
        
        self.secondaryLabel.transform = CGAffineTransform(translationX: 0, y: -30)
        self.secondaryLabel.alpha = 0.0
        self.libraryButton.alpha = 0.0
        
        self.textField.transform = CGAffineTransform(translationX: -30, y: 0)
        self.textField.alpha = 0.0
        
        self.doneButton.transform = CGAffineTransform(translationX: 0, y: -30)
        self.doneButton.alpha = 0.0
        
        self.questionLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.questionLabel.alpha = 0.0
        self.scoreLabel.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.scoreLabel.alpha = 0.0
        self.arrowIcon.alpha = 0.0
        elementsDidAppear()
    }
    func elementsDidAppear(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UILabel.animate(withDuration: 0.5, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.mainLabel.alpha = 1.0
                self.mainLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                self.libraryButton.alpha = 1.0
            }, completion: {
                Void in self.secondaryLabelDidAppear()
            })
            UITextField.animate(withDuration: 0.6, delay: 0.2, options: UITextField.AnimationOptions.curveEaseOut, animations: {
                self.textField.alpha = 1.0
                self.textField.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: {
                Void in self.doneButtonDidAppear()
                self.scoreLabelAndQuestionLabelDidAppear()
            })
        })

    }
    func doneButtonDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UIButton.animate(withDuration: 0.5, delay: 0.2, options: UIButton.AnimationOptions.curveEaseOut, animations: {
                self.doneButton.alpha = 1.0
                self.doneButton.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        })
        
    }
    func scoreLabelAndQuestionLabelDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UILabel.animate(withDuration: 0.6, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.questionLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.questionLabel.alpha = 1.0
                
                self.scoreLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.scoreLabel.alpha = 1.0
            }, completion: {
                Void in self.animateArrowIcon()
            })
        })
    }
    func secondaryLabelDidAppear(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UILabel.animate(withDuration: 0.4, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.secondaryLabel.alpha = 1.0
                self.secondaryLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        })
    }
    
    //to animate with textField if input = wrong answer
    func didTypeWrongAnswer(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UITextField.animate(withDuration: 0.1, animations: {
                self.textField.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.05882352941, blue: 0.09803921569, alpha: 1)
                self.textField.transform = CGAffineTransform(translationX: 3, y: 0)
            }, completion: {
                Void in UITextField.animate(withDuration: 0.1, animations: {
                    self.textField.transform = CGAffineTransform(translationX: -3, y: 0)
                }, completion: {
                    Void in UITextField.animate(withDuration: 0.3, animations: {
                        self.textField.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.textField.backgroundColor = .systemBackground
                    })
                })
            })
        })
    }
    //to animate with textField if input = correct answer
    func didTypeCorrectAnswer(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UITextField.animate(withDuration: 0.1, delay: 0.15, options: UITextField.AnimationOptions.curveEaseOut, animations: {
                self.textField.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.7803921569, blue: 0, alpha: 1)
            }, completion: {
                Void in UITextField.animate(withDuration: 0.3, delay: 0.2, options: UITextField.AnimationOptions.curveEaseIn, animations: {
                    self.textField.backgroundColor = .systemBackground
                })
            })
        })
    }
    func didTapDoneButtonAnimate(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UIButton.animate(withDuration: 0.1, animations: {
                self.doneButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.2, animations: {
                    self.doneButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            })
        })
    }
    
    //check result for final display
    func checkScore(){
        if Int(score) <= 5 {
            scoreTextLabel = "Try again!"
            //writeToTextFile()
        }
        if Int(score) > 5 && Int(score) < 8 {
            scoreTextLabel = "Not bad!"
        }
        if Int(score) > 8 {
            scoreTextLabel = "Well done!"
        }
    }
    
    //to instantiate segue to end VC
    func moveToEndViewController(){
        checkScore()
        guard let lessonQuizEndVC = storyboard?.instantiateViewController(identifier: "QuizLesson2EndVC") as? Lesson2QuizEndViewController else {
            return
        }
        lessonQuizEndVC.finalScore = String(score)
        lessonQuizEndVC.finalScoreTextLabel = scoreTextLabel
        lessonQuizEndVC.identifier = id + 1
        lessonQuizEndVC.modalPresentationStyle = .fullScreen
        lessonQuizEndVC.modalTransitionStyle = .crossDissolve
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            self.present(lessonQuizEndVC, animated: false, completion: nil)
        })
    }
    func animateTransitionViewController(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UIView.animate(withDuration: 0.6, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.transitionView.alpha = 1.0
            }, completion: {
                Void in self.moveToEndViewController()
            })
        })
        
    }
    func clearInputSpace(){
        
        //clears up textField after Buttons is pressed
        self.textField.text = ""
    }
    func updateQuestionLabel(){
        clearInputSpace()
        
        //if questions are left
        if Int(index.count) > 0 {
            
            
            //picks random element from 'index' array
            QuestionNumber = index.randomElement()!
            
            //detects the index of the selected element from the array
            removeQuestion = index.firstIndex(of: QuestionNumber)!
            
            //remove the given element with its index value
            index.remove(at: removeQuestion)
            
            //updates QuestionLabel
            questionLabel.text = questions[QuestionNumber]
        }
        else {
            dismissKeyboard()
            
            //to do when no questions are left
            animateTransitionViewController()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                self.successSoundEffect.play()
            })
        }
    }
    @IBAction func didTapDoneButton(_ sender: Any) {
        didTapDoneButtonAnimate()
        
        //set up correction method
        if self.textField.text == answers[QuestionNumber] {
            score += 1
            correctSoundEffect.play()
            didTypeCorrectAnswer()
            
            blueColorAmount -= 0.05
            updateColorForQuestionLabel()
        }
        else {
            wrongSoundEffect.play()
            didTypeWrongAnswer()
            
            blueColorAmount -= 0.05
            updateColorForQuestionLabel()
        }
        
        //to update Score and Question Labels
        updateQuestionLabel()
        updateScoreLabel()
    }
    func updateScoreLabel(){
        
        //updates scoreLabel
        self.scoreLabel.text = String(score) + "/10"
    }
    
    func updateColorForQuestionLabel(){
        //edit QuestionLabel
        questionLabel.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: CGFloat(blueColorAmount), alpha: 1)
        scoreLabel.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: CGFloat(blueColorAmount), alpha: 1)
        
        questionLabel.layer.cornerRadius = 25.0
        questionLabel.layer.masksToBounds = true
        
        UIButton.animate(withDuration: 0.4, animations: {
            self.questionLabel.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }, completion: {
            Void in UIButton.animate(withDuration: 0.4, animations: {
                self.questionLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })
        
    }
    
  

}
