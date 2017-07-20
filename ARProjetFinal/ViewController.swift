//=====================================
import UIKit
//=====================================
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {


    @IBOutlet weak var tableV: UITableView!
    @IBOutlet weak var newElement: UITextField!
    
    var viewContent: [String] = []
    var defaults = UserDefaults.standard
    
    //-------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    //-------------------------
    func loadData() {
        viewContent = []
        for a in Singleton.instancePartage.unArray{
            viewContent.append(a)
        }
    }
    //-------------------------
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //-------------------------
    @IBAction func Ajouter(_ sender: UIButton) {
        
        if(newElement.text?.isEmpty)!{
            let alerte = UIAlertController(title: "Champ vide", message:"Veuillez entrer une tâche pour l'ajouter à la liste", preferredStyle: UIAlertControllerStyle.alert)
            alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alerte,animated: true, completion: nil)
        }
        else{
            print("message enregistrer")
            Singleton.instancePartage.unArray.append(newElement.text!)
            
            loadData()
            tableV.reloadData()
        }
    }
    
    
    //----Methodes pour table view-----------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return viewContent.count
    }
    //---------------------
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        cell.textLabel!.text = viewContent[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //---------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
    }
    //---------------------
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    //---------------------
    
}

