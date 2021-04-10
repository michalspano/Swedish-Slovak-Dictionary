import UIKit

// initial view of Notes mini-app to display Icon animation
class NotesViewController: UIViewController {
    
    //IB outlet reference for GifLoader
    @IBOutlet weak var gifView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkMode()
        
        //loads Gif to UIView and animates it
        gifView.loadGif(name: "AnimatedIcon")
        animation()
    }
    func checkMode() {
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }
    //animation for GifView
    func animation() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0, execute: {
            UIImageView.animate(withDuration: 1.5, animations: {
                self.gifView.alpha = 0.0
                self.gifView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            }, completion: {
                
                //Voids in completion - performs segue to NotesTableView
                Void in DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25, execute: {
                    self.performSegue(withIdentifier: "toNotesVC", sender: Any?.self)
                })
            })
        })
    }
    
}
