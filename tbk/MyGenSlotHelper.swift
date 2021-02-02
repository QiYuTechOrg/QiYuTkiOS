import Foundation

/// 生成 http 请求的参数
func gen_slot_http_request_args<Type: Codable>(url: URL, method: String, args: Type? = nil) -> URLRequest {
    var request =  URLRequest(url: url)

    guard let data = args else {
        request.httpMethod = "GET"
        return request
    }

    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField:"Content-Type")

    let en = JSONEncoder()
    request.httpBody = try! en.encode(data)

    return request
}

/// 辅助函数
func gen_slot_http_request_helper<Type: Codable>(
    request: URLRequest,
    failure_cb: @escaping () -> Void,
    success_cb: @escaping (Type) -> Void) {

    URLSession.shared.dataTask(with: request) { Data, Response, Error in

        if (Error != nil) {
            DispatchQueue.main.async {
                failure_cb()
            }
            return
        }

        guard let resp = Response else {
            DispatchQueue.main.async {
                failure_cb()
            }
            return
        }
        
        let http = resp as! HTTPURLResponse
        if 200 > http.statusCode || http.statusCode > 300 {
            DispatchQueue.main.async {
                failure_cb()
            }
            return
        }

        guard let data = Data else {
            DispatchQueue.main.async {
                failure_cb()
            }
            return
        }

        let de = JSONDecoder()
        let v = try? de.decode(Type.self, from: data)
        guard let v2 = v else {
            DispatchQueue.main.async {
                failure_cb()
            }
            return
        }


        // 成功的回调
        DispatchQueue.main.async {
            success_cb(v2)
        }

    }.resume()
}
