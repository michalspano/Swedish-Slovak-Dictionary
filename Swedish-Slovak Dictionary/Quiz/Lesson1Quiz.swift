import UIKit
import AVFoundation

//declare local structure for Question as Str, Answer as an Arrays of Str and Answer of Int for index value;
struct Question {
    var Question: String!
    var Answers: [String]!
    var Answer: Int!
}

class Lesson1Quiz: UIViewController {
    
    @IBOutlet weak var QLabel: UILabel!
    //an array of buttons in IBOutlets
    @IBOutlet var Buttons: [UIButton]!
    
    //declare variables
    var Questions = [Question]()
    var QuestionNumber = Int()
    var AnswerNumber = Int()
    
    var score: Int = 0
    
    var blueColorAmount: Double = 1.0
    
    var finalScoreTextLabel = String()
    
    @IBOutlet weak var Button1: UIButton!
    @IBOutlet weak var Button2: UIButton!
    @IBOutlet weak var Button3: UIButton!
    @IBOutlet weak var Button4: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var successView: UIView!
    @IBOutlet var secondaryLabel: UILabel!
    @IBOutlet weak var successGifImageView: UIImageView!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var finalScoreLabel: UILabel!
    @IBOutlet weak var wellDoneLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var lessonButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    
    var wrongSoundEffect = AVAudioPlayer()
    var correctSoundEffect = AVAudioPlayer()
    var successSoundEffect = AVAudioPlayer()
    var popSoundEffect = AVAudioPlayer()
    
    var lessonIdentifier = String()
    var id = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMode()
        lessonAssets()
        editButtons()
        editWellDoneLabel()
        editRetryButton()
        editLesson2Button()
        editMenuButton()
        initialDisplacement()
        
        //declare and prepare sound effect to play
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
        
        QuestionPick()
        updateScoreLabel()
        updateColorForQuestionLabel()
    }
    func checkMode() {
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }
    func lessonAssets(){
        //declare Questions with possible answers and index value of the correct answer as Int!
        
        switch lessonIdentifier {
        case "Lesson1":
            id = 1
            Questions = [Question(Question: "God morgon!", Answers: ["Dobré ráno!", "Dobrý deň!", "Dobrý večer!", "Dovidenia!"], Answer: 0),
                Question(Question: "God dag!", Answers: ["Ďakujem", "Dobrú noc!", "Dovidenia!", "Dobrý deň!"], Answer: 3),
                Question(Question: "God afton!", Answers: ["Dovidenia!", "Dobrý deň!", "Dobrý večer!", "Dobré ráno!"], Answer: 2),
                Question(Question: "God natt!", Answers: ["Dobrú noc!", "Dovidenia!", "Dobrý večer!", "Ďakujem!"], Answer: 0),
                Question(Question: "Hej! / Hallå!", Answers: ["Dobré ráno!", "Dobrú noc!", "Dobrý deň!", "Ahoj!"], Answer: 3),
                Question(Question: "Tjäna!", Answers: ["Ahoj!", "Rado sa stalo.", "Čau!", "Zbohom!"], Answer: 2),
                Question(Question: "Tack!", Answers: ["Dobrý deň!", "Ďakujem!", "Zbohom!", "Ahoj"], Answer: 1),
                Question(Question: "Varsågod.", Answers: ["Ahoj!", "Rado sa stalo.", "Dobrý deň!", "Ďakujem!"], Answer: 1),
                Question(Question: "Hejdå!", Answers: ["Dovidenia!", "Dobrú noc!", "Zbohom!", "Čau!"], Answer: 0),
                Question(Question: "Adjö!", Answers: ["Dovidenia!", "Ďakujem!", "Rado sa stalo.", "Zbohom!"], Answer: 3)]
        case "Lesson3":
            id = 3
            Questions = [Question(Question: "röd", Answers: ["červená", "oranžová", "biela", "hnedá"], Answer: 0),
                Question(Question: "gul", Answers: ["hnedá", "zelená", "fialová", "žltá"], Answer: 3),
                Question(Question: "orange", Answers: ["červená", "modrá", "oranžová", "čierna"], Answer: 2),
                Question(Question: "grön", Answers: ["zelená", "žltá", "sivá", "oranžová"], Answer: 0),
                Question(Question: "blå", Answers: ["zelená", "fialová", "sivá", "modrá"], Answer: 3),
                Question(Question: "lila", Answers: ["biela", "hnedá", "fialová", "červená"], Answer: 2),
                Question(Question: "brun", Answers: ["modrá", "hnedá", "žltá", "biela"], Answer: 1),
                Question(Question: "svart", Answers: ["fialová", "čierna", "modrá", "zelená"], Answer: 1),
                Question(Question: "vit", Answers: ["biela", "červená", "oranžová", "hnedá"], Answer: 0),
                Question(Question: "grå", Answers: ["čierna", "zelená", "hnedá", "sivá"], Answer: 3)]
        case "Lesson5":
            id = 5
            Questions = [Question(Question: "Djurpark", Answers: ["ZOO", "Policajná stanica", "Pláž", "Supermarket"], Answer: 0),
                Question(Question: "Skola", Answers: ["Knižnica", "Pošta", "Nemocnica", "Škola"], Answer: 3),
                Question(Question: "Polisstation", Answers: ["Vlaková stanica", "Pláž", "Policajná stanica", "ZOO"], Answer: 2),
                Question(Question: "Tågstation", Answers: ["Vlaková stanica", "Supermarket", "Pošta", "Nemocnica"], Answer: 0),
                Question(Question: "Bibliotek", Answers: ["Kostol", "Pošta", "Supermarket", "Knižnica"], Answer: 3),
                Question(Question: "Sjukhus", Answers: ["ZOO", "Vlaková stanica", "Nemocnica", "Kostol"], Answer: 2),
                Question(Question: "Strand", Answers: ["Supermarket", "Pláž", "Policajná stanica", "Škola"], Answer: 1),
                Question(Question: "Kyrka", Answers: ["Knižnica", "Kostol", "Škola", "Vlaková stanica"], Answer: 1),
                Question(Question: "Posten", Answers: ["Pošta", "Policajná stanica", "Kostol", "Knižnica"], Answer: 0),
                Question(Question: "Mataffär", Answers: ["Nemocnica", "Pláž", "Pošta", "Supermarket"], Answer: 3)]
            
        default:
            break
        }
        mainLabel.text = "Quiz Lesson \(id)"
    }
    
    //check score from quiz
    func checkScore(){
        if Int(score) <= 5 {
            finalScoreTextLabel = "Try again!"
        }
        if Int(score) > 5 && Int(score) < 8 {
            finalScoreTextLabel = "Not bad!"
        }
        if Int(score) > 8 {
            finalScoreTextLabel = "Well done!"
        }
        toUpdateScoreTextLabel()
    }
    
    //to update final label under given condition
    func toUpdateScoreTextLabel(){
        self.wellDoneLabel.text = finalScoreTextLabel
    }
    func initialDisplacement(){
        mainLabel.alpha = 0.0
        mainLabel.transform = CGAffineTransform(translationX: 0, y: -20)
        secondaryLabel.alpha = 0.0
        secondaryLabel.transform = CGAffineTransform(translationX: 0, y: -10)
        QLabel.alpha = 0.0
        animateElements()
        Button1.alpha = 0.0
        Button2.alpha = 0.0
        Button3.alpha = 0.0
        Button4.alpha = 0.0
        Button1.transform = CGAffineTransform(translationX: -30, y: 0)
        Button2.transform = CGAffineTransform(translationX: -30, y: 0)
        Button3.transform = CGAffineTransform(translationX: -30, y: 0)
        Button4.transform = CGAffineTransform(translationX: -30, y: 0)
        scoreLabel.alpha = 0.0
        scoreLabel.transform = CGAffineTransform(translationX: 0, y: -20)
    }
    func animateElements() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            UILabel.animate(withDuration: 0.5, delay: 0.2, animations: {
                self.mainLabel.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
                self.mainLabel.alpha = 1.0
                self.secondaryLabelDidAppear()
                self.questionLabelDidAppear()
            })
        })
    }
    func secondaryLabelDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UILabel.animate(withDuration: 0.4, delay: 0.1, animations: {
                self.secondaryLabel.alpha = 1.0
                self.secondaryLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        })
    }
    func questionLabelDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UILabel.animate(withDuration: 0.5, delay: 0.2, animations: {
                self.QLabel.alpha = 1.0
                self.buttonsDidAppear()
            })
        })
    }
    func buttonsDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.02, execute: {
            UIButton.animate(withDuration: 0.5, delay: 0.2, options: UIButton.AnimationOptions.curveEaseOut, animations: {
                self.Button1.alpha = 1.0
                self.Button1.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            UIButton.animate(withDuration: 0.5, delay: 0.4, options: UIButton.AnimationOptions.curveEaseOut, animations: {
                self.Button2.alpha = 1.0
                self.Button2.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            UIButton.animate(withDuration: 0.5, delay: 0.6, options: UIButton.AnimationOptions.curveEaseOut, animations: {
                self.Button3.alpha = 1.0
                self.Button3.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            UIButton.animate(withDuration: 0.5, delay: 0.8, options: UIButton.AnimationOptions.curveEaseOut, animations: {
                self.Button4.alpha = 1.0
                self.Button4.transform = CGAffineTransform(translationX: 0, y: 0)
                self.scoreLabelDidAppear()
            })
        })
    }
    func scoreLabelDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UILabel.animate(withDuration: 0.3, animations: {
                self.scoreLabel.alpha = 1.0
                self.scoreLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            })
        })
    }
    func editWellDoneLabel(){
        
        //editWellDoneLabel
        wellDoneLabel.layer.shadowColor = UIColor.black.cgColor
        wellDoneLabel.layer.shadowOpacity = 0.35
        wellDoneLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        wellDoneLabel.layer.shadowRadius = 3.5
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
        
    }
    func editButtons(){
        
        //edit Button1
        Button1.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4980392157, blue: 0.9490196078, alpha: 1)
        Button1.layer.shadowColor = UIColor.black.cgColor
        Button1.layer.shadowOpacity = 0.5
        Button1.layer.shadowOffset = CGSize(width: -1, height: 1)
        Button1.layer.shadowRadius = 7.5
        Button1.layer.cornerRadius = 25.0
        
        //edit Button2
        Button2.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4588235294, blue: 0.9490196078, alpha: 1)
        Button2.layer.shadowColor = UIColor.black.cgColor
        Button2.layer.shadowOpacity = 0.5
        Button2.layer.shadowOffset = CGSize(width: -1, height: 1)
        Button2.layer.shadowRadius = 7.5
        Button2.layer.cornerRadius = 25.0
        
        //edit Button3
        Button3.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4196078431, blue: 0.9490196078, alpha: 1)
        Button3.layer.shadowColor = UIColor.black.cgColor
        Button3.layer.shadowOpacity = 0.5
        Button3.layer.shadowOffset = CGSize(width: -1, height: 1)
        Button3.layer.shadowRadius = 7.5
        Button3.layer.cornerRadius = 25.0
        
        //edit Button4
        Button4.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.3803921569, blue: 0.9490196078, alpha: 1)
        Button4.layer.shadowColor = UIColor.black.cgColor
        Button4.layer.shadowOpacity = 0.5
        Button4.layer.shadowOffset = CGSize(width: -1, height: 1)
        Button4.layer.shadowRadius = 7.5
        Button4.layer.cornerRadius = 25.0
        
        //edit scoreLabel
        scoreLabel.layer.backgroundColor = #colorLiteral(red: 0.05997246763, green: 0.1288298523, blue: 0.5649524613, alpha: 1)
        scoreLabel.layer.cornerRadius = 25
        scoreLabel.layer.masksToBounds = true
        
        scoreLabel.layer.shadowColor = UIColor.black.cgColor
        scoreLabel.layer.shadowOpacity = 0.4
        scoreLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        scoreLabel.layer.shadowRadius = 7.0
        
        //edit welcome label
        mainLabel.layer.shadowColor = UIColor.black.cgColor
        mainLabel.layer.shadowOpacity = 0.25
        mainLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        mainLabel.layer.shadowRadius = 5.0
        
        //edit ScoreView
        scoreView.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.3803921569, blue: 0.9490196078, alpha: 1)
        scoreView.layer.shadowColor = UIColor.black.cgColor
        scoreView.layer.shadowOpacity = 0.5
        scoreView.layer.shadowOffset = CGSize(width: -1, height: 1)
        scoreView.layer.shadowRadius = 7.5
        
    }
    func showScore(){
        checkScore()
        updateScoreViewColor()
        let s = 0.30
        let toDelay = DispatchTime.now() + s
        
        //to delay sound of delay seconds
        DispatchQueue.main.asyncAfter(deadline: toDelay) {
            self.popSoundEffect.play()
            self.popSoundEffect.volume = 0.75
        }
        
        self.finalScoreLabel.text = String(score) + "/10"
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
    //to animate when 10 questions passed
    func animateSuccessView(){
        self.successGifImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        //present Gif in a Image View
        successGifImageView.loadGif(name: "successAnimation")
        view.addSubview(successGifImageView)
        
        //to animate Gif in a Image View
        UIView.animate(withDuration: 1.5, delay: 0.4, options: UIView.AnimationOptions.curveEaseInOut,animations: {
            //present UIView
            self.successView.alpha = 1.0
        })
        UIImageView.animate(withDuration: 1.8, delay: 0.5, options: UIImageView.AnimationOptions.curveEaseOut, animations: {
            self.successGifImageView.alpha = 1.0
            self.successGifImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: {
            Void in UIImageView.animate(withDuration: 0.5, animations: {
                self.successGifImageView.alpha = 0.0
                self.showScore()
            })
        })
    }

    func updateScoreLabel(){
        
        //update text according to the picked answers
        scoreLabel.text = "\(String(score))/10"
    }
    //declare a function that picks a random question
    func QuestionPick(){
        
    //start if questions are available
        if Questions.count > 0 {
            //pick up random question number
            QuestionNumber = Int(arc4random_uniform(UInt32(Questions.count)))
            
            //changes QLabel aaccordingly
            QLabel.text = Questions[QuestionNumber].Question
            
            AnswerNumber = Questions[QuestionNumber].Answer
            
            //i in range number of buttons sets title of questions
            for i in 0..<Buttons.count {
                
                Buttons[i].setTitle(Questions[QuestionNumber].Answers[i], for: UIControl.State.normal)
            }
            
            //if a question was used, delete it from the list
            Questions.remove(at: QuestionNumber)
            
        }
        //if no questions are available
        else {
            let seconds = 1.25
            let when = DispatchTime.now() + seconds
            
            //to delay sound of delay seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.successSoundEffect.play()
                self.successSoundEffect.volume = 0.75
            }
            
            //Change lessonButton title after quiz completion for following lesson (id + 1);
            if id < 5 {
                lessonButton.setTitle("Lesson \(id + 1)", for: .normal)
            }
            else {
                lessonButton.setTitle("Finish", for: .normal)
            }
            animateSuccessView()
        }
    }
    
    //event if Button1 is clicked
    @IBAction func Button1Click(_ sender: Any) {
        blueColorAmount -= 0.05
        updateColorForQuestionLabel()
        if AnswerNumber == 0{
            correctSoundEffect.play()
            score += 1
            //if the correct answer is selected do;
            QuestionPick()
            updateScoreLabel()
            editButtons()
            
            //animate Button to be green for a seq of time then animate to base color; -> indicates correct answer
            UIButton.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.Button1.backgroundColor = #colorLiteral(red: 0.05116792015, green: 0.7801304056, blue: 0, alpha: 1)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.Button1.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4980392157, blue: 0.9490196078, alpha: 1)
                })
            })
        }
        else {
            //if the wrong answer is selected;
            wrongSoundEffect.play()
            QuestionPick()
            
            //animate Button to be red for a seq of time then animate to base color; -> indicates wrong answer
            UIButton.animate(withDuration: 0.1, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.Button1.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.05882352941, blue: 0.09803921569, alpha: 1)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.Button1.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4980392157, blue: 0.9490196078, alpha: 1)
                })
            })
        }
    }
    //event if Button2 is clicked
    @IBAction func Button2Click(_ sender: Any) {
        blueColorAmount -= 0.1
        updateColorForQuestionLabel()
        if AnswerNumber == 1{
            correctSoundEffect.play()
            score += 1
            QuestionPick()
            updateScoreLabel()
            
            //animate Button to be green for a seq of time then animate to base color; -> indicates correct answer
            UIButton.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.Button2.backgroundColor = #colorLiteral(red: 0.05098039216, green: 0.7803921569, blue: 0, alpha: 1)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.Button2.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4588235294, blue: 0.9490196078, alpha: 1)
                })
            })
        }
        else {
            wrongSoundEffect.play()
            QuestionPick()
            
            //animate Button to be red for a seq of time then animate to base color; -> indicates wrong answer
            UIButton.animate(withDuration: 0.1, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.Button2.backgroundColor = #colorLiteral(red: 0.6978190258, green: 0.05974426592, blue: 0.09837293433, alpha: 1)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.Button2.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4588235294, blue: 0.9490196078, alpha: 1)
                })
            })
        }
    }
    //event if Button3 is clicked
    @IBAction func Button3Click(_ sender: Any) {
        blueColorAmount -= 0.05
        updateColorForQuestionLabel()
        if AnswerNumber == 2{
            correctSoundEffect.play()
            score += 1
            QuestionPick()
            updateScoreLabel()
            
            //animate Button to be green for a seq of time then animate to base color; -> indicates correct answer
            UIButton.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.Button3.backgroundColor = #colorLiteral(red: 0.05116792015, green: 0.7801304056, blue: 0, alpha: 1)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.Button3.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4196078431, blue: 0.9490196078, alpha: 1)
                })
            })
        }
        else {
            wrongSoundEffect.play()
            QuestionPick()
            
            //animate Button to be red for a seq of time then animate to base color; -> indicates wrong answer
            UIButton.animate(withDuration: 0.1, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.Button3.backgroundColor = #colorLiteral(red: 0.6978190258, green: 0.05974426592, blue: 0.09837293433, alpha: 1)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.Button3.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.4196078431, blue: 0.9490196078, alpha: 1)
                })
            })
        }
    }
    //event if Button4 is clicked
    @IBAction func Button4Click(_ sender: Any) {
        blueColorAmount -= 0.1
        updateColorForQuestionLabel()
        if AnswerNumber == 3{
            correctSoundEffect.play()
            score += 1
            QuestionPick()
            updateScoreLabel()
            
            //animate Button to be green for a seq of time then animate to base color; -> indicates correct answer
            UIButton.animate(withDuration: 0.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                self.Button4.backgroundColor = #colorLiteral(red: 0.05116792015, green: 0.7801304056, blue: 0, alpha: 1)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.Button4.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.3803921569, blue: 0.9490196078, alpha: 1)
                })
            })
        }
        else {
            wrongSoundEffect.play()
            QuestionPick()
            
            //animate Button to be red for a seq of time then animate to base color; -> indicates wrong answer
            UIButton.animate(withDuration: 0.1, delay: 0.1, options: UIView.AnimationOptions.curveEaseIn, animations: {
                self.Button4.backgroundColor = #colorLiteral(red: 0.6978190258, green: 0.05974426592, blue: 0.09837293433, alpha: 1)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.3, delay: 0.3, options: UIView.AnimationOptions.curveEaseInOut, animations: {
                    self.Button4.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.3803921569, blue: 0.9490196078, alpha: 1)
                })
            })
        }
    }
    func updateColorForQuestionLabel(){
        //edit QuestionLabel
        QLabel.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: CGFloat(blueColorAmount), alpha: 1)
        scoreLabel.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: CGFloat(blueColorAmount), alpha: 1)
        
        QLabel.layer.cornerRadius = 25.0
        QLabel.layer.masksToBounds = true
        
        UIButton.animate(withDuration: 0.4, animations: {
            self.QLabel.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }, completion: {
            Void in UIButton.animate(withDuration: 0.4, animations: {
                self.QLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })
        
    }
    @IBAction func didTapLessonButton(_ sender: Any) {
        performSegue(withIdentifier: "fromLesson\(id)QuizToLesson\(id+1)", sender: (Any).self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromLesson3QuizToLesson4") {
            let lessonVC = segue.destination as! Lesson4ViewController
            lessonVC.lessonIdentifier = "Lesson 4"
        }
    }
}
