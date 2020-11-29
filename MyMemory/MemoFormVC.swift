//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by 김종서 on 2020/11/29.
//

import UIKit


class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    //내용의 첫줄을 추출하여 제목으로 사용, 제목을 저장하는 변수
    var subject: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contents.delegate = self
        
    }
    
    //사용자가 이미지를 선택하면 자동으로 이 메소드를 호출
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //선택된 이미지를 미리보기에 출력
        self.preview.image = info[.editedImage] as? UIImage
        
        //이미지피커컨트롤러를 닫음
        picker.dismiss(animated: false)
    }
    
    //사용자가 텍스트뷰에 뭔가를 입력하면 자동으로 이 메소드가 호출
    func textViewDidChange(_ textView: UITextView) {
        
        //내용의 최대 15자리까지 읽어 subject변수에 저장
        //텍스트뷰의 내용을 NSString로 타입캐스팅
        let contents = textView.text as NSString
        // 읽어온 내용이 15자리보다 길경우 15자리까지만, 그보다 짧은경우 전체내용을 읽어옴
        let length = ((contents.length > 15) ? 15 : contents.length)
        //원하는 범위만 잘라내기 위해 substring(with:)를 사용
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        //내비게이션타이틀에 표시
        self.navigationItem.title = self.subject
    }
    
    //저장버튼을 클릭했을때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        
        //내용을 입력하지 않았을 경우, 경고함
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            
            return
        }
        
        //MemoData객체를 생성, 데이터를 담음
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        //앱델리게이트객체를 읽어온 다음, memoList배열에 MemoData객체를 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memoList.append(data)
        
        //작성화면을 종료하고, 이전화면으로 돌아감
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    //카메라버튼을 클릭했을때 호출되는 메소드, 앨범 혹은 카메라기능 실행
    @IBAction func pick(_ sender: Any) {
        
        //이미지피커컨트롤러 인스턴스를 생성
        let picker = UIImagePickerController()
        
        //델리게이트속성을 현재 뷰컨트롤러 인스턴스로 설정
        picker.delegate = self
        //이미지편집을 허용
        picker.allowsEditing = true
        
        //이미지피커 화면을 표시
        self.present(picker, animated: true)
    }
    
}
