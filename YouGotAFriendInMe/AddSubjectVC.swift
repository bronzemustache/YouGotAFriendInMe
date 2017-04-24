
// This screen is where user can add new subjects.

import UIKit

class AddSubjectVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var subjects: [Subject] = []
    
    @IBOutlet var addButton: UIButton!
    @IBOutlet var newName: UITextField!
    @IBOutlet var table: UITableView!
    
    
    // ViewController ---------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        subjects = Subject.all()
    }
    
    
    // Add a new subject ------------------------------------------------------
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        // Only add the name if it is unique.
        guard
            newName.text != nil &&
            newName.text != "" &&
            (subjects.filter { $0.name == newName.text }).count == 0
            else { return }
        
        _ = Subject(newName.text!)
        subjects = Subject.all()
        table.reloadData()
    }
    
    
    // Table methods ----------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath)
        
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 0, width: 200, height: 50)
        label.text = subjects[indexPath.row].name
        
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
