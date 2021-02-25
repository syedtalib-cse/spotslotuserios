
class ChatViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var viewWriteMessage: UIView!
    @IBOutlet weak var viewChat: UIView!
    @IBOutlet weak var lblIsOnline: UILabel!
    @IBOutlet weak var tlvChatList: UITableView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var txtvSendMessage: UITextView!
    
    @IBOutlet weak var imgCustomer: UIImageView!
    @IBOutlet weak var lblCustomerName: UILabel!
    
    var arrOfChatModel:[ChatModel] = []
    
    var objAppointment:Upcomming?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tlvChatList.rowHeight = UITableView.automaticDimension
        initialConfig()
    }
    override func viewWillAppear(_ animated: Bool) {
     webServiceToGetallChat()
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
    @IBAction func btnSendMessage(_ sender: Any) {
        if txtvSendMessage.textColor != UIColor.lightGray as UIColor{
            webServiceTosendMessage()
        }else{
             GlobalObj.showAlertVC(title:appName, message:"Please enter your message", controller: self)
        }
    }
}


//MARK:- Delegate and DataSource Methods Of TableView
extension ChatViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.arrOfChatModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.arrOfChatModel[indexPath.row].type == GenralText.Incoming.rawValue{
            tlvChatList.register(UINib(nibName: "InComingMessageCell", bundle: nil), forCellReuseIdentifier: "InComingMessageCell")
            let cell = tlvChatList.dequeueReusableCell(withIdentifier: "InComingMessageCell", for: indexPath) as! InComingMessageCell
            cell.obj = self.arrOfChatModel[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }else{
            tlvChatList.register(UINib(nibName: "OutGoingMessageCell", bundle: nil), forCellReuseIdentifier: "OutGoingMessageCell")
            let cell = tlvChatList.dequeueReusableCell(withIdentifier: "OutGoingMessageCell", for: indexPath) as! OutGoingMessageCell
            cell.obj = self.arrOfChatModel[indexPath.row]
             cell.selectionStyle = .none
            return cell
        }
       
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Write a message"
            textView.textColor = UIColor.lightGray
        }
    }
    
}



//MARK:- Custom function here
extension ChatViewController{
    func initialConfig()  {
        viewWriteMessage.layer.cornerRadius = 25
        viewWriteMessage.layer.borderColor = #colorLiteral(red: 0.8470588235, green: 0.8901960784, blue: 1, alpha: 1)
        viewWriteMessage.layer.borderWidth = 1
        //setRadiusBorder(borderWidth: 0.6, cRadius: 30)
        DispatchQueue.main.async {
            self.viewBG.roundedTop(width: 20, height: 20)
        }
        lblIsOnline.layer.cornerRadius = lblIsOnline.frame.height/2
        txtvSendMessage.delegate = self
        txtvSendMessage.text = "Write a message"
        txtvSendMessage.textColor = UIColor.lightGray
        setData()
    }
    
    func setData(){
        imgCustomer.sd_setImage(with: URL(string: objAppointment?.vendor_image ?? ""), placeholderImage: UIImage(named: "placeholder"))
        lblCustomerName.text = (objAppointment?.vendor_name ?? "").capitalized
        imgCustomer.layer.cornerRadius = imgCustomer.frame.height/2
    }
    
}

//MARK:- Webservice calling here -
extension ChatViewController{
    
    func webServiceToGetallChat(){
        let para = [ParametersKey.vendor_id.rawValue:objAppointment?.vendor_id ?? ""]
        UserDataModel.webServiceToGetAllMessage(params:para) { (response) in
        if response != nil{
        if response?.status == 200{
            self.arrOfChatModel = response?.arrOfChatModel ?? []
            self.tlvChatList.reloadData()
         }
         }
       }
    }
    
    func webServiceTosendMessage(){
        let para = [ParametersKey.to_id.rawValue: self.objAppointment?.vendor_id ?? "",ParametersKey.message.rawValue:self.txtvSendMessage.text!]
        UserDataModel.weberviceToSendMessage(params: para) { (response) in
            if response != nil{
                if response?.status == 200{
                    self.txtvSendMessage.text = "Write a message"
                    self.txtvSendMessage.textColor = UIColor.lightGray
                    self.webServiceToGetallChat()
                }
            }
        }
    }
    
}
