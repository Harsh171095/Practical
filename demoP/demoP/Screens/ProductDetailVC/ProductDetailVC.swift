//
//  ProductDetailVC.swift
//  demoP
//
//  Created by 200OK-IOS5 on 31/03/23.
//

import UIKit

class ProductDetailVC: UIViewController {

    @IBOutlet private weak var collImages: UICollectionView!
    @IBOutlet private weak var pager: UIPageControl!
    
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblPrice: UILabel!
    @IBOutlet private weak var lblRating: UILabel!
    @IBOutlet private weak var lblCategory: UILabel!
    @IBOutlet private weak var lblDis: UILabel!
    
    let productItem: ProductItem?
    
    init(productItem: ProductItem) {
        self.productItem = productItem
        super.init(nibName: "ProductDetailVC", bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        self.productItem = nil
        super.init(coder: coder)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collImages.register(UINib(nibName: "ItemImagesCell", bundle: nil), forCellWithReuseIdentifier: "ItemImagesCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collImages.collectionViewLayout = layout
        
        setData()
    }
    
    private func setData() {
        lblTitle.text =  ": \(productItem?.title ?? "")"
        lblPrice.text = ": \(productItem?.price ?? 0)"
        lblRating.text = ": \(productItem?.rating ?? 0)"
        lblCategory.text = ": \(productItem?.category ?? "")"
        lblDis.text = ": \(productItem?.description ?? "")"
        self.pager.numberOfPages = productItem?.images.count ?? 0
    }
    
    //MARK:- Button Actions
    @IBAction private func clickOn_back() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ProductDetailVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productItem?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemImagesCell", for: indexPath) as? ItemImagesCell {
            cell.setImage(productItem?.images[indexPath.row] ?? "")
            return cell
        }
        return UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let xPoint = scrollView.contentOffset.x + scrollView.frame.width / 2
        let yPoint = scrollView.frame.height / 2
        let center = CGPoint(x: xPoint, y: yPoint)
        if let ip = collImages.indexPathForItem(at: center){
            self.pager.currentPage = ip.row
        }
    }
}
extension ProductDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
