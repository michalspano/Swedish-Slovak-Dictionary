import UIKit
import AVFoundation

class ToDoDetailsViewController: UIViewController {
    
    //imports data from Core Data (CD)
    var toDoCD : ToDoCD? = nil
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var completeSoundEffect = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotesData()
        editElements()
        initialDisplacement()
        animateElements()

        do {
            completeSoundEffect = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "empty", ofType: "mp3")!))
            
            completeSoundEffect.prepareToPlay()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //laods and displays data
    func loadNotesData() {
    
        if let toDo = toDoCD {
            if toDo.priority == 1 {
                if let name = toDo.name{
                    toDoLabel.text = "❗️" + "\n" + name
                }
            }
            else if toDo.priority == 2 {
                if let name = toDo.name {
                    toDoLabel.text = "❗️❗️" + "\n" + name
                }
            }
            else {
                if let name = toDo.name {
                    toDoLabel.text = name
                }
            }
        }
        
    }
    func editElements() {
        //to edit doneButton
        doneButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.3411764706, blue: 0.9490196078, alpha: 1)
        doneButton.layer.shadowOpacity = 0.25
        doneButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        doneButton.layer.shadowRadius = 5.0
        doneButton.layer.cornerRadius = 20.0
        
        toDoLabel.backgroundColor = #colorLiteral(red: 0.1332223415, green: 0.3412293196, blue: 0.9489018321, alpha: 0.75)
        doneButton.layer.shadowOpacity = 0.5
        doneButton.layer.shadowOffset = CGSize(width: -5, height: 5)
        doneButton.layer.shadowRadius = 10.0
        toDoLabel.layer.masksToBounds = true
        toDoLabel.layer.cornerRadius = 30.0
        
        //edit properties based on light/dark mode
        if self.traitCollection.userInterfaceStyle == .dark {
            doneButton.layer.shadowColor = UIColor.darkGray.cgColor
            doneButton.layer.shadowColor = UIColor.darkGray.cgColor
        }
        else if self.traitCollection.userInterfaceStyle == .light {
            doneButton.layer.shadowColor = UIColor.black.cgColor
            doneButton.layer.shadowColor = UIColor.black.cgColor
        }
        
    }
    func initialDisplacement(){
        toDoLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        doneButton.transform = CGAffineTransform(translationX: 0, y: -50)
        doneButton.alpha = 0.0
        
    }
    
    func animateElements(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UILabel.animate(withDuration: 0.5, delay: 0.2, options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.toDoLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }, completion: {
                Void in UIButton.animate(withDuration: 0.5, delay: 0.2, options: UIButton.AnimationOptions.curveEaseOut, animations: {
                    self.doneButton.alpha = 1.0
                    self.doneButton.transform = CGAffineTransform(translationX: 0, y: 0)
                })
            })
        })
    }
    
    //doneButton Tap IBAction
    @IBAction func doneTapped(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDo = toDoCD {
                context.delete(toDo)
                
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01, execute: {
            UIButton.animate(withDuration: 0.4, delay: 0.2, options: UIButton.AnimationOptions.curveEaseIn, animations: {
                self.doneButton.alpha = 0.0
                self.doneButton.transform = CGAffineTransform(translationX: 0, y: -30)
            }, completion: {
                Void in DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
                    self.completeSoundEffect.play()
                    UILabel.animate(withDuration: 0.5, delay: 0.2, options: UILabel.AnimationOptions.curveEaseIn, animations: {
                        self.toDoLabel.alpha = 0.0
                    }, completion: {
                        Void in self.navigationController?.popViewController(animated: true)
                    })
                })
            })
        })
    }
}
