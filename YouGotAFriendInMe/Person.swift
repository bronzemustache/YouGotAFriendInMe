
// Implementation of a "person".  A person can be expert in zero to many
// "subjects".  A person can be friends with another person, which is
// a mutual relationship in this implementation.

class Person: Hashable {
    
    // Used so that each person has a unique hash value, which 
    // can also be thought of as an id.
    private static var nextHashValue = 0
    
    // Maintain a collection of all the people
    // because we need that for the UI.
    private static var allThePeople:[Person] = []
    
    // Friendship is mutual so there is an invariant that every
    // person in this friends list also has this person in their
    // friends list.
    var friends: [Person]
    
    // Other instance properties
    let hashValue: Int              // unique
    let name: String                // unique, there is logic that depends on this in the UI
    var subjects: [Subject]
    
    
    
    // Static functions ---------------------------------------
    
    static func all() -> [Person] {
        return allThePeople
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    

    
    // Instance functions -------------------------------------
    
    init(_ name: String) {

        self.hashValue = Person.nextHashValue
        self.name = name
        self.subjects = []
        self.friends = []
        
        // Class housekeeping.
        Person.nextHashValue += 1
        Person.allThePeople.append(self)
        Person.allThePeople.sort {$0.name < $1.name}
    }
    
    
    // Create friend relationship between two people.
    func makeFriend(_ friend: Person) {
        guard self != friend else { return }
        self.friends.append(friend)
        friend.friends.append(self)
    }
    
    
    // Destroy friend relationship between two people.
    func breakUp(_ wasFriend: Person) {
        guard self != wasFriend else { return }
        friends = friends.filter {$0 != wasFriend}
        wasFriend.friends = wasFriend.friends.filter {$0 != self}
    }
    
    
    func addSubject(_ subject: Subject) {
        subjects.append(subject)
    }
    
    func removeSubject(_ subject: Subject) {
        subjects = subjects.filter { $0 != subject }
    }
    
    
    // Given a subject, returns the path of friends this person can 
    // go through to find an expert in that subject.  For example,
    // Bob knows landscaping, Tom knows nothing, and Mary knows algebra.
    // If Bob is friends with Tom who is friends with Mary, the path
    // of Bob(algebra) is [Bob, Tom, Mary].  If no path is possible, 
    // empty array is returned.  If person is expert in a subject, 
    // path is just that person as in the path of Bob(landscaping) is 
    // [Bob].
    //
    func pathToSubject(_ subject: Subject) -> [Person] {

        // A note on the big picture here.  This is a breadth first 
        // search on an undirected graph.  Nodes of graph are people;
        // edges of graph are friend relationships.
        
        // We need this because there can be cycles in our friend graph.
        var visited = Set<Person>()
        
        // Queue is an array of "paths".  Path is a person array.
        var q = [ [self] ]
        while !q.isEmpty {

            // Remove path from queue and check if last person in
            // current path is expert in the subject.  
            let path = q.removeLast()
            let possibleExpert = (path.last)!
            if possibleExpert.subjects.contains(subject) {
                return path 
            }

            // If we are here we are not done yet.  This node did not have
            // expertise, but neighbor or path from its neighbors might.
            // If we haven't already searched from this person, set up that
            // search.
            if !visited.contains(possibleExpert) {
                for friend in possibleExpert.friends {
                    var newPath = path
                    newPath.append(friend)
                    q.append(newPath)
                }
                visited.insert(possibleExpert)
            }
        }
        
        // If we got here, there was no path found.
        return []
    }
}
