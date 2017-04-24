
// This is the start screen for the app that shows all the people in 
// one picker and all the subjects in another picker, and changing 
// either one updates the path of that person to that subject in a
// text box at bottom of screen.  Also has buttons to segue to the 
// adding people and adding subjects screens.  From the add people 
// screen the user can segue to the add/delete friendships and 
// add/delete expertise screens.

import UIKit

class ShowPathVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // UI elements that get read or changed.
    @IBOutlet var personPicker: UIPickerView!
    @IBOutlet var subjectPicker: UIPickerView!
    @IBOutlet var pathTextBox: UITextView!
    
    // Enum used to tag controllers so they can be distinquished
    // in the picker delegate methods.
    enum Tag: Int { case people, subject }
    
    // Used to load picker controls and to get the path from
    // a given person to a given subject.
    var people: [Person] = []
    var subjects: [Subject] = []
 
    
    
    // ViewController methods ---------------------------------------------------
    
    // Set up self as delegate for our people and subject
    // picker controllers and tag them so we can tell them apart.
    override func viewDidLoad() {
        personPicker.delegate = self
        personPicker.tag = Tag.people.rawValue
        subjectPicker.delegate = self
        subjectPicker.tag = Tag.subject.rawValue
    }
    
    // Reload person and subject lists on appearance because
    // user might have changed them in the other screens.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        people = Person.all()
        subjects = Subject.all()
        personPicker.reloadAllComponents()
        subjectPicker.reloadAllComponents()
    }
    
    // Doing the path textbox update here because I want to
    // be sure the pickers can safely query the pickers for
    // what is selected.  Also there is more of a chance 
    // of the user seeing the update which in this case
    // I like.
    override func viewDidAppear(_ animated: Bool) {
        updatePath()
    }
    
    
    
    // the path textbox -----------------------------------------------------------
    
    // Updates the text box that contains the path of the currently
    // selected person to the currently selected subject.
    func updatePath() {
        
        guard people.count > 0 && subjects.count > 0
            else { return }
        
        let person = people[personPicker.selectedRow(inComponent: 0)]
        let subject = subjects[subjectPicker.selectedRow(inComponent: 0)]
        let path = person.pathToSubject(subject)
        
        if path == [] {
            pathTextBox.text = "There is no path from person \(person.name) to subject \(subject.name)."
        }
        else {
            let pathNames = path.map { $0.name }
            let pathString = pathNames.joined(separator: " -> ")
            pathTextBox.text = "The path from person \(person.name) to subject \(subject.name) is \(pathString)."
        }
    }
    
   
    
    // PickerViewDelegate methods -------------------------------------------------
    
    // Same for both pickers.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Same for both pickers
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updatePath()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == Tag.people.rawValue {
            return people.count
        }
        else {
            return subjects.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == Tag.people.rawValue {
            return people[row].name
        }
        else {
            return subjects[row].name
        }
    }
}

