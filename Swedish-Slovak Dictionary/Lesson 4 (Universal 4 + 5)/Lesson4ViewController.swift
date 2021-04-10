import UIKit

class Lesson4ViewController: UIViewController {
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet weak var swipeUpLabel: UILabel!
    @IBOutlet weak var lowerLabel: UILabel!
    @IBOutlet var lessonView: UIImageView!
    @IBOutlet var lessonLabel: UILabel!
    @IBOutlet weak var libraryButton: UIButton!
    var lessonIdentifier = String()
    var id = Int()
    var subj = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMode()
        checkLessonIdentifier()
        initialDisplacement()

    }
    func checkMode() {
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }
    func checkLessonIdentifier() {
        if lessonIdentifier == "Lesson 4" {
            id = 4
            subj = "animals"

        }
        else {
            id = 5
            subj = "places"
        }
        mainLabel.text = "Lesson \(id)"
        lowerLabel.text = "Welcome to Lesson \(id)! In this lesson you will learn \(subj) in Swedish."
        lessonView.image = UIImage(named: "Lesson\(id)Icon")
        lessonLabel.text = "L\(id)"
        view.addSubview(lessonView)
        view.addSubview(lessonLabel)
        
    }
    func initialDisplacement() {
        self.mainLabel.alpha = 0.0
        self.mainLabel.transform = CGAffineTransform(translationX: 0, y: -50)
        self.lowerLabel.alpha = 0.0
        
        self.libraryButton.transform = CGAffineTransform(
            translationX: 0,
            y: 30)
        self.libraryButton.alpha = 0.0
        
        //lesson Label View
        self.lessonLabel.alpha = 0.0
        self.lessonLabel.transform = CGAffineTransform(
            scaleX: 0.5,
            y: 0.5)
        
        self.lessonView.alpha = 0.0
        self.lessonView.transform = CGAffineTransform(
            scaleX: 0.5,
            y: 0.5)
        self.swipeUpLabel.alpha = 0.0
        self.swipeUpLabel.transform = CGAffineTransform(
            translationX: 50,
            y: 0)
        animateElements()
        
    }
    func animateElements(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            UILabel.animate(withDuration: 0.8, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.swipeUpToStart()
                self.mainLabel.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
                self.mainLabel.alpha = 1.0
                
                self.libraryButton.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
                self.libraryButton.alpha = 1.0
                self.swipeUpLabel.transform = CGAffineTransform(
                    translationX: 0,
                    y: 0)
            })
            UILabel.animate(withDuration: 1.0, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.lowerLabel.alpha = 1.0
                
                self.lessonView.alpha = 1.0
                self.lessonLabel.alpha = 1.0
                self.animateLessonView()
            })
        }
    }
    func animateLessonView() {
        UIView.animate(withDuration: 1.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.lessonView.transform = CGAffineTransform(
                scaleX: 1.15,
                y: 1.15)
            self.lessonLabel.transform = CGAffineTransform(
                scaleX: 1.15,
                y: 1.15)
        }, completion: {
            Void in UIView.animate(withDuration: 1.7, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.lessonView.transform = CGAffineTransform(
                    scaleX: 1.0,
                    y: 1.0)
                self.lessonLabel.transform = CGAffineTransform(
                    scaleX: 1.0,
                    y: 1.0)
            }, completion: {
                Void in self.animateLessonView()
            })
        })
    }
    func swipeUpToStart() {
        self.swipeUpLabel.alpha = 0.0
        
        //instantiate delay for UIAnimation with DispatchQueue
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            UIButton.animate(withDuration: 1.3, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.swipeUpLabel.alpha = 0.5
            }, completion: {
                Void in UIButton.animate(withDuration: 1.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
                    self.swipeUpLabel.alpha = 0.0
                }, completion: {
                    Void in self.swipeUpToStart()
                })
            })
            
        }
        
    }
    
    @IBAction func didSwipeUp(_ sender: Any) {
        performSegue(withIdentifier: "fromLessonInitialToLesson", sender: (Any).self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromLessonInitialToLesson") {
            let targetVC = segue.destination as! Lesson4Part1ViewController
            targetVC.lessonIdentifier2 = lessonIdentifier
        }
    }
    
}
