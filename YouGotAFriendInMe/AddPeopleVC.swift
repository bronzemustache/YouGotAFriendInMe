
// This screen is where user can add new people.

import UIKit

class AddPeopleVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var people: [Person] = []
    
    @IBOutlet var newName: UITextField!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    
    // ViewController -----------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        people = Person.all()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editPersonVC = segue.destination as! EditPersonVC
        if let indexPath = tableView.indexPathForSelectedRow {
            editPersonVC.title = people[indexPath.row].name
        }
    }
    
    
    
    // Add a new person --------------------------------------------------------
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        // Only add the name if it is unique.
        guard
            newName.text != nil &&
            newName.text != "" &&
            (people.filter { $0.name == newName.text }).count == 0
            else { return }
        
        _ = Person(newName.text!)
        people = Person.all()
        tableView.reloadData()
    }
    
    
   
    // Table methods ----------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
 
        // New label.
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 0, width: 200, height: 50)
        label.text = people[indexPath.row].name
        
        // If we don't remove the label that was created before,
        // both the old and new labels are drawn.
        for subview in cell.subviews {
            if type(of: subview) == type(of: label) {
                subview.removeFromSuperview()
            }
        }
        cell.addSubview(label)
        return cell
    }
}
