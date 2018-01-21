//import UIKit
//
//
//
//class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
//
//    var tableView: UITableView = UITableView()
//    var data = ["A","B","C","D","E","F","G"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //Constructing tableView.
//        self.tableView.frame = CGRect(x:0,y:10, width:self.view.frame.width,height:self.view.frame.height - 40);
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
//        self.tableView.rowHeight = 50
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//
//        self.view.addSubview(self.tableView)
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
//        cell.textLabel?.text = data[indexPath.row]
//        return cell
//    }
//
//}

