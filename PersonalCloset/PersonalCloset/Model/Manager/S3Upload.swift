//
//  S3Upload.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/23/24.
//
//
import Foundation
import AWSCore
import AWSS3

class S3Upload {
    func uploadImageFile(imgData: UIImage?) {
        /// 이미지를 Data 타입으로 변환
        guard let image = imgData?.jpegData(compressionQuality: 0.9) else {
            print("[ DONT HAVE IMAGE DATA ]")
            return
        }

        /// 파일 이름을 위한 날짜 포맷 설정
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmssSSS"

        let fileName = "profile/image/" + dateFormatter.string(from: currentDate) + ".jpg"

        /// 서버 사이드 암호화 설정 : AES256
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.setValue("AES256", forRequestHeader: "x-amz-server-side-encryption")

        /// 이미지 업로드 Completion Handler
        var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
        completionHandler = { (task, error) -> Void in
            DispatchQueue.global().async(execute: {
                /// Do something e.g. Alert a user for transfer completion.
                /// On failed uploads, error contains the error object.
                guard let responseURL = task.response?.url else {
                    return
                }

                /// URL 문자열에서 필요없는 부분을 제거
                /// 문자열을 ? 기준으로 자른뒤 배열로 반환 시키는 함수
                /// 배열의 첫 번째 값이 실제 사용하는 URL
                let url = responseURL.absoluteString.components(separatedBy: "?")[0]
                ImageTempManager.shared.imageURLs.append(url)
            })
        }

        let transferUtility = AWSS3TransferUtility.default()
        transferUtility.uploadData(
                        /// 보내질 Data
                        image,
                        /// 저장소의 버킷 이름
            bucket: S3Configuration.BUCKET_NAME.rawValue,
                        /// 업로드 할 파일의 이름
            key: fileName,
                        /// 컨텐츠 타입 (jpg, png, mp4, txt 등...)
            contentType: S3Configuration.CONTENT_TYPE_IMAGE.rawValue,
                        /// 헤더 값, 프로그래스 바
            expression: expression,
                        /// Request 요청이 끝나면 실행될 객체
            completionHandler: completionHandler).continueWith {
                /// uploadData 코드가 모두 실행되면 실행될 코드
                (task) -> AnyObject? in
                    if let error = task.error {
                       print("Error: \(error.localizedDescription)")
                    }

                    if let _ = task.result {
                        /// Do something with uploadTask.
                        print("업로드 완료")
                    }
                return nil
            }
    }
}

