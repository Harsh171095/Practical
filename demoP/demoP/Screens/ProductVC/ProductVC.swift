//
//  ProductVC.swift
//  demoP
//
//  Created by 200OK-IOS5 on 31/03/23.
//

import UIKit


class ProductVC: UIViewController {

    @IBOutlet private weak var lblUserName: UILabel!
    @IBOutlet private weak var lblUserEmail: UILabel!
    
    @IBOutlet private weak var tblProductList: UITableView!
    
    /// variable diclaration
    private let apiRequestObj = APICall()
    private var skipItem = 0
    private let limitItem = 15
    private var totalItems = 0
    private var arrProducts = [ProductItem]()
    
    //MARK:- Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                tblProductList.register(UINib(nibName: "ProductItemCell", bundle: nil), forCellReuseIdentifier: "ProductItemCell")
        
        lblUserName.text = authUser?.userName ?? ""
        lblUserEmail.text = authUser?.userEmail ?? ""
        
        //methods call for initial product fecth
        getProducts()

    }
    
    
    //MARK:- API calls
    func getProducts() {
        DispatchQueue.main.async {
            showLoader(self)
            let para = ["skip": "\(self.skipItem)", "limit" :"\(self.limitItem)"]
            self.apiRequestObj.getAPICall(endPoint: "products", requestPara: para) { responder in
                hideLoader(self)
                DispatchQueue.main.async {
                    let decoder = JSONDecoder()
                    do{
                        if let data = responder.data as? Data {
                            if let jsonPetitions = try? decoder.decode(Product.self, from: data) {
                                if self.skipItem == 0 {
                                    self.arrProducts = jsonPetitions.products
                                    self.totalItems = jsonPetitions.total
                                } else {
                                    for item in jsonPetitions.products {
                                        self.arrProducts.append(item)
                                    }
                                }
                                
                                self.tblProductList.reloadData()
                            }
                            
                            
                        }
                        
                    }catch(let error){
                        print(error)
                    }
                }
            }
        }
    }
}
extension ProductVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ProductDetailVC(productItem: arrProducts[indexPath.row]), animated: true)
    }
}
extension ProductVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductItemCell", for: indexPath) as? ProductItemCell {
            cell.setData(arrProducts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (arrProducts.count - 2) {
            skipItem = skipItem + limitItem
            if skipItem < totalItems {
                getProducts()
            }
        }
    }
}
