import UIKit
import CoreData

class NotesTableViewController: UITableViewController {
    
    var toDoCD: [ToDoCD] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        checkMode()

    }
    func checkMode() {
        if UserDefaults.standard.bool(forKey: "darkMode") == true {
            overrideUserInterfaceStyle = .dark
        }
        else {
            overrideUserInterfaceStyle = .light
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //number of rows based on array length
        return toDoCD.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //edit elements based on Core Data input
        let cell = UITableViewCell()
        let selectedToDo = toDoCD[indexPath.row]
        
        if selectedToDo.priority == 1 {
            if let name = selectedToDo.name {
                cell.textLabel?.text = "❗️" + " " + name
            }
        }
        else if selectedToDo.priority == 2 {
            if let name = selectedToDo.name {
                cell.textLabel?.text = "❗️❗️" + " " + name
            }
        }
        else {
            if let name = selectedToDo.name {
                cell.textLabel?.text = name
            }
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    //instantiate input from Core Data
    override func viewWillAppear(_ animated: Bool) {
        getToToDos()
    }
    
    //performs Segue from selected note (cell) index path
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedToDo = toDoCD[indexPath.row]
        performSegue(withIdentifier: "moveToDetails", sender: selectedToDo)
    }
    
    //prepares data before performing segues to different destinations
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addNotesViewController = segue.destination as? NotesToDoViewController {
            addNotesViewController.toDoTableViewController = self
        }
        if let detailsToDoViewController = segue.destination as? ToDoDetailsViewController {
            if let selectedToDo = sender as? ToDoCD {
                detailsToDoViewController.toDoCD = selectedToDo
            }
        }
    }
    func getToToDos() {
        //inputs data from Core Data Model via AppDelegate
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()) {
                
                //if data is fetched to array, reload data and update table View
                if let toDos = toDosFromCoreData as? [ToDoCD] {
                    toDoCD = toDos
                    tableView.reloadData()
                }
            }
        }
    }

}
