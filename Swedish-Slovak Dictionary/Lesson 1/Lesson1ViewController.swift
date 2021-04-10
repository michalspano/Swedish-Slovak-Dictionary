import UIKit

//Lesson 1 Initial View Code repr.
class Lesson1ViewController: UIViewController {
    
    //declare IBOutlets
    @IBOutlet weak var swipeUpLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var lowerLabel: UILabel!
    @IBOutlet weak var lesson1View: UIImageView!
    @IBOutlet weak var lesson1Label: UILabel!
    @IBOutlet weak var libraryButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMode()
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
    func initialDisplacement(){
        self.mainLabel.alpha = 0.0
        self.mainLabel.transform = CGAffineTransform(translationX: 0, y: -50)
        self.lowerLabel.alpha = 0.0
        
        self.libraryButton.transform = CGAffineTransform(
            translationX: 0,
            y: 30)
        self.libraryButton.alpha = 0.0
        
        //lesson Label View
        self.lesson1Label.alpha = 0.0
        self.lesson1Label.transform = CGAffineTransform(
            scaleX: 0.5,
            y: 0.5)
        
        self.lesson1View.alpha = 0.0
        self.lesson1View.transform = CGAffineTransform(
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
                
                self.lesson1View.alpha = 1.0
                self.lesson1Label.alpha = 1.0
                self.animateLessonView()
            })
        }
    }
    func animateLessonView(){
        UIView.animate(withDuration: 1.5, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.lesson1View.transform = CGAffineTransform(
                scaleX: 1.15,
                y: 1.15)
            self.lesson1Label.transform = CGAffineTransform(
                scaleX: 1.15,
                y: 1.15)
        }, completion: {
            Void in UIView.animate(withDuration: 1.7, delay: 0.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.lesson1View.transform = CGAffineTransform(
                    scaleX: 1.0,
                    y: 1.0)
                self.lesson1Label.transform = CGAffineTransform(
                    scaleX: 1.0,
                    y: 1.0)
            }, completion: {
                Void in self.animateLessonView()
            })
        })
    }
    func swipeUpToStart(){
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
}
