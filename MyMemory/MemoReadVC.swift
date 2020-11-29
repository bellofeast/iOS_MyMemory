//
//  MemoReadVC.swift
//  MyMemory
//
//  Created by 김종서 on 2020/11/29.
//

import UIKit


class MemoReadVC: UIViewController {
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    //콘텐츠데이터를 저장하는 변수
    var param: MemoData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //제목, 내용, 이미지를 출력
        self.subject.text = param?.title
        self.contents.text = param?.contents
        self.img.image = param?.image
        
        //날짜포맷 변환
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분애 작성됨"
        let dateString = formatter.string(from: (param?.regdate)!)
        
        //내비게이션타이틀에 날짜를 표시
        self.navigationItem.title = dateString
    }
    
    
}
