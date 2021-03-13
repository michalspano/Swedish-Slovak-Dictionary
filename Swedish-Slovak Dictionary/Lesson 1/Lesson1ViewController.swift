import UIKit

class Lesson1ViewController: UIViewController {
    
    //declare IBOutlets
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var L1Label: UILabel!

    override func viewDidLoad() {
        view.addSubview(L1Label)
        super.viewDidLoad()
        fadeOut()
        
        //gradient bounds
        self.lbl.alpha = 0
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.blue.cgColor, UIColor.purple.cgColor]
    }
    //declare fadeOut function
    func fadeOut(){
        UIView.animate(withDuration: 1.0, animations: {
                        self.lbl.alpha = 0.5}, completion: { (completed: Bool) -> Void in
                            UIView.animate(withDuration: 1.0, delay: 1.0, options: UIView.AnimationOptions.curveLinear, animations: {
                                self.lbl.alpha = 0.0 }, completion: { (completed: Bool) -> Void in
                                
                                self.fadeOut()}) //looped animation
                        })
    }

}
