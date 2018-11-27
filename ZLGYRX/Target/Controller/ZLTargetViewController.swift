//
//  ZLTargetViewController.swift
//  zlgy
//
//  Created by iOS软件工程师 on 2018/11/26.
//  Copyright © 2018 wcz. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ZLTargetViewController: ZLBaseController {

    let disposeBag = DisposeBag()
    var dataSourceSubject = BehaviorRelay<[SectionModel<String,ZLTargetModel>]>(value: [])
    
    private lazy var ingBtn : ZLSegmentBtn = {
        let btn = ZLSegmentBtn.init(frame: CGRect(x: 0, y: 35, width: 100, height: 26))
        btn.title = "进行中"
        return btn
    }()
    private lazy var finishBtn : ZLSegmentBtn = {
        let btn = ZLSegmentBtn.init(frame: CGRect(x: 200, y: 35, width: 100, height: 26))
        btn.title = "已结束"
        return btn
    }()
    private lazy var addBtn : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: kScreenWidth-38-17, y: 45, width: 38, height: 29)
        btn.setTitle("添加", for: .normal)
        btn.setImage(UIImage(named: "icon_plus"), for: .normal)
        btn.titleLabel?.font = ICYFONT14
        btn.adjustsImageWhenHighlighted = false
        return btn
    }()
    private lazy var tableView : UITableView = {
        let tb = UITableView(frame: CGRect(x: 0, y: 75, width: kScreenWidth, height: kScreenHeight-100-49), style: .plain)
        tb.register(ZLTargetTableViewCell.self, forCellReuseIdentifier: ZLTargetTableViewCell.description())
        tb.separatorStyle = .none
        tb.rowHeight = 135;
        return tb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
        bindToView()
    }
    func setUpViews()  {
        let BG = UIView.init(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 116))
        view.addSubview(BG);       UIView.gradualChange(BG)
        BG.addSubview(ingBtn);     BG.addSubview(finishBtn);         finishBtn.btn.alpha = 0.6
        finishBtn.line.isHidden = true;  view.addSubview(addBtn);    view.addSubview(tableView)
        tableView.backgroundColor = UIColor.clear
    }
    func bindToView() {
        let rxDataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, ZLTargetModel>>(configureCell: {(dataSource, tableview, indexPatch, model) -> ZLTargetTableViewCell in
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ZLTargetTableViewCell.description()) as! ZLTargetTableViewCell
            cell.gotoSend.rx.tap.subscribe(onNext: {[weak self] _ in
                guard let self = self else {return}
                print("\(indexPatch.row) + ------为它去种")
            }).disposed(by:self.disposeBag)
            cell.punchCard.rx.tap.subscribe(onNext: {[weak self] _ in
                guard let self = self else {return}
                print("\(indexPatch.row) + ------打卡")
            }).disposed(by: self.disposeBag)
            return cell
        })
        let model = ZLTargetModel()
        model.title = "11"
        model.subTitle = "111"
        let model2 = ZLTargetModel()
        model2.title = "22"
        model2.subTitle = "222"
        let model3 = ZLTargetModel()
        model3.title = "333"
        model3.subTitle = "333"
        let model4 = ZLTargetModel()
        model4.title = "444"
        model4.subTitle = "444"
        dataSourceSubject.accept(dataSourceSubject.value + [SectionModel(model: "", items: [model,model2,model3,model4])])
        dataSourceSubject.bind(to: tableView.rx.items(dataSource: rxDataSource)).disposed(by: disposeBag)
        ingBtn.btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.finishBtn.line.isHidden = true
            self.finishBtn.btn.alpha = 0.6
            self.ingBtn.btn.alpha = 1.0
            self.ingBtn.line.isHidden = false
        }).disposed(by: disposeBag)
        finishBtn.btn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else { return }
            self.ingBtn.line.isHidden = true
            self.ingBtn.btn.alpha = 0.6
            self.finishBtn.btn.alpha = 1.0
            self.finishBtn.line.isHidden = false
        }).disposed(by: disposeBag)
        addBtn.rx.tap.subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            self.navigationController?.pushViewController(ZLLoginController(), animated: false)
        }).disposed(by: disposeBag)
    }
}