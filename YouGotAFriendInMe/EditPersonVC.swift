
// This screen just serves to have two buttons so that user can 
// navigate to the edit friends or edit expertise screens for 
// this person.

import UIKit

class EditPersonVC: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Note both the edit friends and edit expertise screens 
        // get their title set to this vc's title, which is the name
        // of the person.  That title is in turn used to get the 
        // person object - so, if the title gets changed that logic
        // would need to be changed too.
        segue.destination.title = self.title
    }
}
