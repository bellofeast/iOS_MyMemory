//
//  MemoListVC.swift
//  MyMemory
//
//  Created by 김종서 on 2020/11/29.
//

import UIKit


class MemoListVC: UITableViewController {
    
    //앱델리게이트객체의 참조정보를 읽어옴
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        
        //테이블데이터를 다시 읽어들임, 행을 구성하는 로직이 다시 실행
        self.tableView.reloadData()
    }
    
    //테이블뷰의 셀개수를 결정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = self.appDelegate.memoList.count
        
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //1. memoList배열데이터에서 주어진 행에 맞는 데이터를 꺼냄
        let row = self.appDelegate.memoList[indexPath.row]
        
        //2. 이미지속성이 비어 있을 경우 "memoCell", 아니면 "memoCellWithImage"
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        
        //3. 재사용큐로부터 프로토타입셀의 인스턴스를 전달받음
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        
        //4. memoCell의 내용을 구성
        cell.subject?.text = row.title
        cell.contents?.text = row.contents
        cell.img?.image = row.image
        
        //5. Date타입의 날짜를 yyyy-MM-dd HH:mm:ss포맷으로 변경
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = formatter.string(from: row.regdate!)
        
        //6. cell객체를 리턴
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //memoList배열레서 선택된 행에 맞는 데이터를 꺼냄
        let row = self.appDelegate.memoList[indexPath.row]
        
        //상세화면의 인스턴스를 생성
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoRead") as? MemoReadVC else { return }
        
        //값을 전달한 다음, 상세화면으로 이동
        vc.param = row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
