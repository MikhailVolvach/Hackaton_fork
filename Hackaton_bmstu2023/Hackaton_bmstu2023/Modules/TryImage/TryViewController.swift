//
//  TryViewController.swift
//  Hackaton_bmstu2023
//
//  Created by Grigoriy on 27.10.2023.
//

import UIKit
import PinLayout

final class TryViewController: UIViewController {
    
    private let imagePicker = ImagePicker()
    private let imageView = UIImageView(frame: CGRect(x: 100, y: 300, width: 200, height: 200))
    
    private let imageView2 = UIImageView(frame: CGRect(x: 100, y: 50, width: 200, height: 200))
    
    private let button = UIButton()
    private let button2 = UIButton()
    
    private let shared = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(imageView ,imageView2, button, button2)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(didTabButton), for: .touchUpInside)
        button.setTitle("выбрать картинку", for: .normal)
        button.layer.cornerRadius = 10
        
        button2.backgroundColor = .red
        button2.addTarget(self, action: #selector(didTabButton2), for: .touchUpInside)
        button2.setTitle("post", for: .normal)
        button2.layer.cornerRadius = 20
        
        
        DispatchQueue.global(qos: .userInteractive).async {
            guard let url = URL(string: "http://84.201.134.49:9988/view/image.jpg"),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                print(":(")
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = image
            }
        }
    }
    
    @objc
    private func didTabButton() {
        imagePicker.showImagePicker(with: self) { image in
            self.imageView2.image = image
        }
    }
    @objc
    private func didTabButton2() {
        shared.post(image: (imageView2.image ?? UIImage(named: "key"))!)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        button.pin
            .top(600)
            .horizontally(100)
            .height(50)
        
        button2.pin
            .top(700)
            .horizontally(80)
            .height(40)
    }
}

final class ImagePicker: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var completion: ((UIImage) -> ())?
    
    func showImagePicker(with vc: UIViewController, completion: ((UIImage) -> ())?) {
        self.completion = completion
        var imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        vc.present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            self.completion?(image)
            picker.dismiss(animated: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}



