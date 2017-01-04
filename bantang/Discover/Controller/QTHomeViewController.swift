//
//  QTHomeViewController.swift
//  bantang
//
//  Created by chenqitao on 2016/11/9.
//  Copyright © 2016年 陈齐涛. All rights reserved.
//

import UIKit
import SwiftyJSON
class QTHomeViewController: QTBaseViewController {
    
    @IBOutlet weak var backScrollView: UIScrollView!

    var dataArray = NSMutableArray()
    var tableArray = NSMutableArray()
    var jsonArray = NSDictionary()
    var currentTableView = UIScrollView()
    var lastTableView = UIScrollView()
    lazy var headView : UIView = {
        var headview = UIView.init(frame: CGRect.init(x: 0, y: 0, width:UIScreen.main.bounds.width , height: 202))
        headview.backgroundColor = UIColor.red
        return headview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        initData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func initData() {
        let filepath = Bundle.main.path(forResource: "index", ofType: "json")
    
        let dic = try? JSONSerialization.jsonObject(with: NSData(contentsOfFile: filepath!) as Data, options: .allowFragments)
        let dic1 = JSON(dic ?? [])
        
        let array = dic1["data"]["topic"]
        for jsonValue in array.arrayValue {
         let homeModel = QTHomeModel.initWithJson(json: jsonValue)
            dataArray.add(homeModel)
        }
        backScrollView.delegate = self
        backScrollView.frame = CGRect(x:0,y:0,width:view.frame.width,height:view.frame.height)
        backScrollView.contentSize = CGSize(width: view.frame.width*9, height: 0)
        for i in 0...9 {
            let homeListTableView = UITableView()
            homeListTableView.dataSource = self
            homeListTableView.delegate = self
            homeListTableView.contentInset = UIEdgeInsetsMake(182, 0, 0, 0)
            homeListTableView.frame = CGRect(x: CGFloat(i)*view.frame.width, y: 0, width: view.frame.width, height: view.frame.height)
            homeListTableView.register(UINib(nibName: "QTListHomeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "QTListHomeTableViewCell")
            backScrollView.addSubview(homeListTableView)
            tableArray.add(homeListTableView)
        }
    }

    func initUI() {
       view.addSubview(headView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension QTHomeViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QTListHomeTableViewCell", for: indexPath) as!QTListHomeTableViewCell
        cell.configCellWithModel(model: dataArray[indexPath.row] as! QTHomeModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 284
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == backScrollView {
            guard scrollView.contentOffset.x.truncatingRemainder(dividingBy: view.frame.width) == 0 else {
                return
            }
            let index = scrollView.contentOffset.x/view.frame.width
            lastTableView = currentTableView
            currentTableView = tableArray[Int(index)] as! UIScrollView
            lastTableView.contentOffset.y = currentTableView.contentOffset.y < -44 ? currentTableView.contentOffset.y : -44
            
            
        } else {
        let scrollY = scrollView.contentOffset.y
        print(scrollY)

        if scrollY < -44 {
            for tableView  in tableArray {
                guard !currentTableView.isEqual(tableView) else {
                    continue
                }
                (tableView as! UITableView).contentOffset.y = scrollY
            }
         headView.frame.origin.y = -(scrollY + 182)
           
        } else {
         headView.frame.origin.y = CGFloat(44.0 - 182)
            for tableView  in tableArray {
                guard !currentTableView.isEqual(tableView) else {
                    continue
                }
                (tableView as! UITableView).contentOffset.y = -44
            }
         }
        }
       
        
    }
}
