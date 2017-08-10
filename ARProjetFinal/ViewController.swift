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

        self.tableV.allowsMultipleSelection = true
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
    //---Bouton ajouter
    @IBAction func Ajouter(_ sender: UIButton) {
        
        if(newElement.text?.isEmpty)!{
            let alerte = UIAlertController(title: "Champ vide", message:"Veuillez entrer une tâche pour l'ajouter à la liste", preferredStyle: UIAlertControllerStyle.alert)
            alerte.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alerte,animated: true, completion: nil)
        }
        else{
            Singleton.instancePartage.unArray.append(newElement.text!)
            
            loadData()
            tableV.reloadData()
        }
        newElement.text = ""
    }
    //---Bouton Sauvegarder
    //sauvegarder toutes les infos sur le serveur
    @IBAction func Sauvegarder(_ sender: UIButton) {
        
        var listeDesTaches: [String] = []
        var urlToSend = "http://localhost/dashboard/robitaille/check_list_php/add.php?json=["
        
        //parcour le tableview et prend le contenu des lignes
        let cells = self.tableV.visibleCells 
        
        for cell in cells{
            
            listeDesTaches.append(cell.textLabel!.text!)
            print(listeDesTaches)
        }
        

        urlToSend += "]"
    }
    
    
    //---Bouton réinitialiser
    //déselectionner toutes les taches sélectionnés
    @IBAction func Reinitialiser(_ sender: UIButton) {
        tableV.reloadData()
    }
   
    //---Bouton charger
    //va chercher les informations sauvegarder sur le serveur et update la liste
    @IBAction func Charger(_ sender: UIButton) {
        
    }
    //---Bouton Voir Liste
    //Prend les elements sélectionné et les envoies dans la liste
    @IBAction func VoirListe(_ sender: UIButton) {
        
    }
    
    
    //----Methodes pour table view-----------------
    //----Nombre de cellules
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.backgroundColor = UIColor.clear
        return viewContent.count
    }
    //---------------------
    //----Texte dans les cellules
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style:UITableViewCellStyle.default, reuseIdentifier:"proto")
        cell.textLabel!.text = viewContent[indexPath.row]
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        return cell
    }
    //---------------------
    //----Selection des cellules
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath as IndexPath)!
        selectedCell.contentView.backgroundColor = UIColor.darkGray
    }
    //---------------------
    //----Éliminer les cellules
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    //---------------------
    
}

