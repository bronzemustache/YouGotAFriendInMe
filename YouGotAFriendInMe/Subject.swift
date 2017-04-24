
// Implementation of "subjects".  Subjects have names, and people 
// can be expert in zero to many subjects.

class Subject: Equatable {

    // Used so that each subject has a unique id.
    private static var nextId = 0
    
    // Maintain a collection of all the subjects 
    // because we need that for the UI.
    private static var allSubjects:[Subject] = []
    
    // Instance properties.
    let id: Int                     // unique
    let name: String                // unique

    
    
    // Static functions ---------------------------------------------
    
    static func all() -> [Subject] {
        return allSubjects
    }
    
    static func == (lhs: Subject, rhs: Subject) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
    // Instance functions ------------------------------------------
    
    init(_ name: String) {
        
        self.name = name
        self.id = Subject.nextId
        
        // Class housekeeping.
        Subject.nextId += 1
        Subject.allSubjects.append(self)
        Subject.allSubjects.sort {$0.name < $1.name}
    }
}
