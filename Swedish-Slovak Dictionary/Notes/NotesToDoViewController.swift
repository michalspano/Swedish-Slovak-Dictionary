import UIKit
import CoreData

class NotesToDoViewController: UIViewController {
    var toDoTableViewController: NotesTableViewController?=nil
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var upperLabel: UILabel!
    @IBOutlet weak var lowerLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editElements()
        initialDisplacement()
        animateElements()

    }
    
    func editElements() {
        
        //edit shadows
        upperLabel.layer.shadowColor = UIColor.black.cgColor
        upperLabel.layer.shadowOpacity = 0.3
        upperLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        upperLabel.layer.shadowRadius = 5.0
        
        lowerLabel.layer.shadowColor = UIColor.black.cgColor
        lowerLabel.layer.shadowOpacity = 0.3
        lowerLabel.layer.shadowOffset = CGSize(width: -1, height: 1)
        lowerLabel.layer.shadowRadius = 5.0
        
        if self.traitCollection.userInterfaceStyle == .light {
            addButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.3411764706, blue: 0.9490196078, alpha: 1)
        }
        else {
            addButton.backgroundColor = #colorLiteral(red: 0.09640218479, green: 0.2577218304, blue: 0.7225475816, alpha: 1)
        }
        addButton.layer.shadowOpacity = 0.25
        addButton.layer.shadowOffset = CGSize(width: -1, height: 1)
        addButton.layer.shadowRadius = 5.0
        addButton.layer.cornerRadius = 20.0
        
        lowerLabel.layer.shadowColor = UIColor.black.cgColor
        prioritySegment.layer.shadowOpacity = 0.25
        prioritySegment.layer.shadowOffset = CGSize(width: -1, height: 1)
        prioritySegment.layer.shadowRadius = 5.0
        
        nameTextField.layer.shadowColor = UIColor.black.cgColor
        nameTextField.layer.shadowOpacity = 0.25
        nameTextField.layer.shadowOffset = CGSize(width: -2, height: 2)
        nameTextField.layer.shadowRadius = 5.0
        
        
    }
    func initialDisplacement() {
        upperLabel.alpha = 0.0
        upperLabel.transform = CGAffineTransform(translationX: 0, y: -15)
        
        nameTextField.alpha = 0.0
        nameTextField.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        lowerLabel.alpha = 0.0
        prioritySegment.alpha = 0.0
        addButton.alpha = 0.0
        lowerLabel.transform = CGAffineTransform(translationX: 0, y: -10)
        prioritySegment.transform = CGAffineTransform(translationX: 0, y: -10)
        addButton.transform = CGAffineTransform(translationX: 0, y: -10)
        
    }
    
    func animateElements() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.02, execute: {
            UILabel.animate(withDuration: 0.2, delay: 0.25,  options: UILabel.AnimationOptions.curveEaseOut, animations: {
                self.upperLabel.alpha = 1.0
                self.upperLabel.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: {
                Void in UITextField.animate(withDuration: 0.4, delay: 0.35, options: UITextField.AnimationOptions.curveEaseOut, animations: {
                    self.nameTextField.alpha = 1.0
                    self.nameTextField.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            })
            UILabel.animate(withDuration: 0.5, delay: 0.2, animations: {
                self.lowerLabel.alpha = 1.0
                self.lowerLabel.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            })
            UISegmentedControl.animate(withDuration: 0.5, delay: 0.4, animations: {
                self.prioritySegment.alpha = 1.0
                self.prioritySegment.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
                
            })
            UIButton.animate(withDuration: 0.5, delay: 0.6, animations: {
                self.addButton.alpha = 1.0
                self.addButton.transform = CGAffineTransform(translationX: 0.0, y: 0.0)
            })
        })
        
    }
    
    //exports User based data to Core Data Model via AppDelegate
    @IBAction func didTapAdd(_ sender: Any) {
        //checks for correct Core Data Model
        if let context = (UIApplication.shared.delegate as?  AppDelegate)?.persistentContainer.viewContext {
            let newToDo = ToDoCD(context: context)
            newToDo.priority = Int32(prioritySegment.selectedSegmentIndex) //exports priotity based value
            if let name = nameTextField.text {
                newToDo.name = name //exports name String based value
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext() //data is being saved to AppDelegate via CD
        }
        //performs back to previous ViewController
        navigationController?.popViewController(animated: true)
    }
    

}
