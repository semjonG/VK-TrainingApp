//
//  FriendPhotosVC.swift
//  VK-TrainingApp
//
//  Created by mac on 14.06.2022.
//

import UIKit

final class PhotosVC: UIViewController {
    
    var photosAPI = PhotosAPI()
    var photosArray: Array<Photo> = []
    
    lazy var collectionView: UICollectionView = {
        
        let collectiobViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: collectiobViewFlowLayout)
        collectionView.register(PhotoCollectionCell.self, forCellWithReuseIdentifier: PhotoCollectionCell.identifier)
        collectionView.delegate = self // кладем во внутренн переменную контроллер (для тобо чтобы можно было вызвать у контроллера методы CollectionView)
        collectionView.dataSource = self
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // красим вьюшку
        setupViews() // кладем и настраиваем верстку
        fetchPhotos() // делаем запрос
    }
    
    private func setupViews() {
        
        self.view.addSubview(collectionView) // на рут вью кладем collectionView
        collectionView.pinEdgesToSuperView()
    }
    
    private func fetchPhotos(offset: Int = 0) {
        
        photosAPI.fetchPhotos(offset: 0) { result in
            switch result {
            case .success(let photos):
                self.photosArray.append(contentsOf: photos)
                self.collectionView.reloadData()
            case .failure(_):
                print("cant append pics to array")
            }
        }
    }
}

extension PhotosVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        print("нажатие", indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: 0.2) {
            cell?.transform = .identity
        }
    }
}

extension PhotosVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionCell.identifier, for: indexPath) as! PhotoCollectionCell
        
        let photo = photosArray[indexPath.row]
        cell.configure(photo)
        return cell
    }
}

extension PhotosVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let inset = 10 // центральное расстояние между ячейками
        let itemsInRow = 2 // |[]|[]|
        let insetsWidth = inset * (itemsInRow + 1)//ширина отступов всех
        let availableWith = collectionView.bounds.width - CGFloat(insetsWidth)
        let widthForItem = availableWith / CGFloat(itemsInRow)
        
        return CGSize(width: widthForItem, height: widthForItem) //размер ячейки
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //отступы от секции
    }
}
