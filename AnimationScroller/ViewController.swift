//
//  ViewController.swift
//  AnimationScroller
//
//  Created by 馮仰靚 on 2017/12/29.
//  Copyright © 2017年 larvata.YC. All rights reserved.
//

/*---Input------

 1.MainImg: String = "ImgURL"
 2.DishType: String = "法式料理"
 3.Restaurant: String = "麥當勞"
 4.Rating
 5.Content
 6.SpecialDish
 7.Service
 8.Open time
 9.Map
 10.Rating Record

----------------*/
import UIKit

class Restaurant {
  var mainImgURL: String = ""
  var dishType: String = ""
  var restaurant: String = ""
  var Content: String = ""
}

class MainImageCell: UITableViewCell {



}

class RestaurantInfoCell: UITableViewCell {

  @IBOutlet weak var ratingButton: UIButton!
  @IBOutlet weak var isLikeButton: UIButton!

}

class ViewController: UIViewController {

  @IBOutlet weak var tableViewTopSpace: NSLayoutConstraint!
  @IBOutlet weak var tableview: UITableView!


  @IBOutlet weak var mainImage: UIImageView!
  @IBOutlet weak var mainImageHeight: NSLayoutConstraint!

  var restaurant: Restaurant?
  var myButton: UIButton!
  var isLikeButton: UIButton!
  var referenceView: UIView!
  var imageHeight: CGFloat = 296.0
  var iconDistance: CGFloat = 16
  var iconHeight: CGFloat = 21
  var iconFrame: CGRect!
  var cellLocation: CGRect!
  var button: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    tableview.delegate = self
    tableview.dataSource = self
    if #available(iOS 11.0, *) {
      self.tableview.contentInsetAdjustmentBehavior = .never
    } else {
      self.automaticallyAdjustsScrollViewInsets = false
      self.navigationController?.automaticallyAdjustsScrollViewInsets = false
    }
    myButton = UIButton()
    myButton.frame = CGRect(x: 50, y: 100, width: 40, height: 40)
    myButton.setImage(#imageLiteral(resourceName: "dicover_icon_rank"), for: .normal)
    myButton.restorationIdentifier = "button"
    isLikeButton = UIButton()
    isLikeButton.frame = CGRect(x: 50, y: 100, width: 40, height: 40)
    isLikeButton.setImage(#imageLiteral(resourceName: "dicover_icon_collect"), for: .normal)
    isLikeButton.restorationIdentifier = "isLikeButton"
    referenceView = UIView()
    referenceView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: UIScreen.main.bounds.width,
                                 height: (self.navigationController?.navigationBar.frame.height)!)
    referenceView.backgroundColor = .clear
    referenceView.clipsToBounds = true
    referenceView.addSubview(myButton)
    referenceView.addSubview(isLikeButton)
    UIApplication.shared.statusBarStyle = .lightContent


    setNavigationBar()
//    setStatusBar()

    // Do any additional setup after loading the view, typically from a nib.
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if let cell = tableview.cellForRow(at: IndexPath(row: 0, section: 0)) as? MainImageCell {
      imageHeight = cell.frame.height
    }
    if let cell = tableview.cellForRow(at: IndexPath(row: 1, section: 0)) as? RestaurantInfoCell {
      iconDistance = cell.ratingButton.frame.origin.y
      iconHeight = cell.ratingButton.frame.height
      iconFrame = cell.ratingButton.frame
    }
    self.mainImageHeight.constant = imageHeight
    //create a new button
    button = UIButton.init(type: .custom)
    //set image for button
    button.setImage(#imageLiteral(resourceName: "icon_back_white"), for: UIControlState.normal)
    //add function for button
    button.addTarget(self, action: #selector(backButton), for: UIControlEvents.touchUpInside)
    //set frame
    button.frame = CGRect(x: 0, y: 0, width: 40, height: 50)
    let barButton = UIBarButtonItem(customView: button)
    //assign button to navigationbar
    self.navigationItem.leftBarButtonItem = barButton
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @objc func backButton(){

  }

  func setNavigationBar() {
    var colors = [UIColor]()
    colors.append(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6))
    colors.append(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0))
    navigationController?.navigationBar.setGradientBackground(colors: colors)
    navigationController?.navigationBar.addSubview(referenceView)
    navigationController?.navigationBar.shadowImage = UIImage()
  }

  func setStatusBar() {
    UIApplication.shared.statusBarStyle = .lightContent
  }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch indexPath.row {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "MainImageCell", for: indexPath)
      if let cell = cell as? MainImageCell {
        imageHeight = cell.frame.height
      }
      return cell
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantInfoCell", for: indexPath)
      if let cell = cell as? RestaurantInfoCell {
        iconDistance = cell.ratingButton.frame.origin.y
        iconHeight = cell.ratingButton.frame.height
        iconFrame = cell.ratingButton.frame
        cellLocation = cell.bounds
      }
      return cell
    }

  }
  func whiteColors() -> [UIColor] {
    var colors = [UIColor]()
    colors.append(UIColor(red: 1, green: 1, blue: 1, alpha: 0.99))
    colors.append(UIColor(red: 1, green: 1, blue: 1, alpha: 1))
    return colors
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView)   {

    let yPosition = self.tableview.contentOffset.y
    //control navigationBar color
    let fadeOutRange: CGFloat = 100
    
    switch yPosition {
    case CGFloat.leastNormalMagnitude..<(imageHeight - fadeOutRange):
      var colors = [UIColor]()
      colors.append(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.6))
      colors.append(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0))
      navigationController?.navigationBar.setGradientBackground(colors: colors)
      myButton.frame = CGRect(x: 50, y: 100, width: 50, height: 50)
      button.setImage(#imageLiteral(resourceName: "icon_back_white"), for: .normal)
      UIApplication.shared.statusBarStyle = .lightContent
    case (imageHeight - fadeOutRange)..<(imageHeight  + iconDistance + iconHeight):
      if yPosition <= imageHeight {
        var colors = [UIColor]()
        let rgbNum: CGFloat = 255.0 //(yPosition - imageHeight + fadeOutRange) * 255/fadeOutRange
        let topAlpha = (yPosition - imageHeight + fadeOutRange)*4/fadeOutRange
        let bottomAlpha = (yPosition - imageHeight + fadeOutRange)/fadeOutRange
        colors.append(UIColor(red: rgbNum/255, green: rgbNum/255, blue: rgbNum/255, alpha: 0 + bottomAlpha))
        colors.append(UIColor(red: rgbNum/255, green: rgbNum/255, blue: rgbNum/255, alpha: 0 + bottomAlpha))
        navigationController?.navigationBar.setGradientBackground(colors: colors)
        button.setImage(#imageLiteral(resourceName: "icon_back"), for: .normal)
        UIApplication.shared.statusBarStyle = .default
      } else if yPosition > 0 && yPosition > imageHeight{
        navigationController?.navigationBar.setGradientBackground(colors: whiteColors())
      }
      switch yPosition {
      case (imageHeight - 66)..<(imageHeight  + iconDistance + iconHeight ):
        myButton.frame = CGRect(x: iconFrame.origin.x , y: max((imageHeight + iconDistance - 20) - yPosition, 0) , width: 40, height: 40)
        isLikeButton.frame = CGRect(x: iconFrame.origin.x - 40, y: max((imageHeight + iconDistance - 20) - yPosition, 0) , width: 40, height: 40)
      default:
        myButton.frame = CGRect(x: iconFrame.origin.x , y: max((imageHeight + iconDistance - 20) - yPosition, 0) , width: 40, height: 40)
        isLikeButton.frame = CGRect(x: iconFrame.origin.x - 40, y: max((imageHeight + iconDistance - 20) - yPosition, 0) , width: 40, height: 40)
      }
    case (imageHeight + iconDistance + iconHeight)...CGFloat.greatestFiniteMagnitude:
      navigationController?.navigationBar.setGradientBackground(colors: whiteColors())
      myButton.frame = CGRect(x: iconFrame.origin.x, y: 0 , width: 40, height: 40)

    default:
      break
    }
    if myButton.frame.origin.y == 0 {
      navigationController?.navigationBar.shadowImage = UIImage(color: UIColor(red: 213/255, green: 188/255, blue: 149/255, alpha: 1))
    } else {
      navigationController?.navigationBar.shadowImage = UIImage()
    }
    //控制圖片
    let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview!)

    if mainImageHeight.constant < 10 {
      mainImageHeight.constant = 10
    }
    if mainImageHeight.constant > 9   {
      if translation.y > 0 {
          mainImageHeight.constant = max(imageHeight - yPosition, 50)
      } else {
         mainImageHeight.constant = max(imageHeight - yPosition, 50)
      }
    }
  }

}

public extension UIImage {
  public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 0.3)) {
    let rect = CGRect(origin: .zero, size: size)
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
    color.setFill()
    UIRectFill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    guard let cgImage = image?.cgImage else { return nil }
    self.init(cgImage: cgImage)
  }
}

extension CAGradientLayer {

  convenience init(frame: CGRect, colors: [UIColor]) {
    self.init()
    self.frame = frame
    self.colors = []
    for color in colors {
      self.colors?.append(color.cgColor)
    }
    startPoint = CGPoint(x: 0, y: 0)
    endPoint = CGPoint(x: 0, y: 1)
  }

  func creatGradientImage() -> UIImage? {

    var image: UIImage? = nil
    UIGraphicsBeginImageContext(bounds.size)
    if let context = UIGraphicsGetCurrentContext() {
      render(in: context)
      image = UIGraphicsGetImageFromCurrentImageContext()
    }
    UIGraphicsEndImageContext()
    return image
  }

}

extension UINavigationBar {

  func setGradientBackground(colors: [UIColor]) {

    var updatedFrame = bounds
    updatedFrame.size.height += 20
    let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)

    setBackgroundImage(gradientLayer.creatGradientImage(), for: UIBarMetrics.default)
  }
}



