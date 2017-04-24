
// In this screen, the user can add or remove friend relationships.

import UIKit

class FriendshipVC: UITableViewController {

    var people: [Person] = []
    var personInTitle: Person?
    
    
    
    // ViewController ------------------------------------------------------------
    
    // On appearance, create list of people that could be friends,
    // which excludes person in title.
    override func viewWillAppear(_ animated: Bool) {
        people = Person.all()
        personInTitle = (people.filter{ $0.name == self.title! })[0]
        assert(personInTitle != nil)
        people = people.filter {$0 != personInTitle!}
    }
    
    
    
    // table methods --------------------------------------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    
    // On click, friend status is reversed.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let personInCell = people[indexPath.row]
        let friends = personInTitle!.friends
        if friends.contains(personInCell) {
            personInTitle!.breakUp(personInCell)
        }
        else {
            personInTitle!.makeFriend(personInCell)
        }
        self.tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)

        // Add checkmark or blank to cell depending on friend status.
        let personInCell = people[indexPath.row]
        if (personInTitle?.friends.contains(personInCell))! {
            cell.accessoryType = .checkmark
        }
        else {
            cell.accessoryType = .none
        }

        // Add name to cell.
        let label = UILabel()
        label.frame = CGRect(x: 16, y: 0, width: 200, height: 50)
        label.text = personInCell.name
        cell.addSubview(label)
        return cell
    }
}
