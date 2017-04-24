
// In this screen the user can assign or remove a person's expertise 
// in the various subjects.

import UIKit

class ExpertiseVC: UITableViewController {

    var subjects: [Subject] = []
    
    // Person object comes from the title of this view controller
    // which is set in the segue.
    var personInTitle: Person?
    
    
    
    // ViewController --------------------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        subjects = Subject.all()
        personInTitle = ((Person.all()).filter { $0.name == self.title })[0]
    }

    
    
    // table methods ---------------------------------------------------------------------
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    
    // On click, reverse status of this person's expertise in given subject.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let subject = subjects[indexPath.row]
        if personInTitle!.subjects.contains(subject) {
            personInTitle!.removeSubject(subject)
        }
        else {
            personInTitle!.addSubject(subject)
        }
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "expertCell", for: indexPath)
        
        // Put name of subject in a label in the cell.
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 0, width: 200, height: 50)
        label.text = subjects[indexPath.row].name
        cell.addSubview(label)
        
        // Put a checkmark or no mark in label depending on status
        // of expertise in subject.
        if personInTitle!.subjects.contains(subjects[indexPath.row]) {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}
