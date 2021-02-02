// 这个文件由于 openapi.json 自动生成
// 请不要手动编辑


struct ApiPingStub {

}


struct ApiDtkFastBuyStub {

    /**
     * 快抢商品
     */
    static func my_post(args: ApiDtCategoryDdqGoodsListArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtGenericItemListResponseModel) -> Void) {
        let url = AppUrls.DtkFastBuy()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkGoodsDetailStub {

    /**
     * 单品详情
     */
    static func my_post(args: ApiDtGoodsGetGoodsDetailsArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtDtkGoodsDetailResponseModel) -> Void) {
        let url = AppUrls.DtkGoodsDetail()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkGoodsListStub {

    /**
     * 商品列表
     */
    static func my_post(args: ApiDtGoodsGetGoodsListArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtGenericItemListResponseModel) -> Void) {
        let url = AppUrls.DtkGoodsList()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkGoodsNineOpGoodsListStub {

    /**
     * 9.9包邮
     */
    static func my_post(args: ApiDtGoodsNineOpGoodsListArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtGenericItemListResponseModel) -> Void) {
        let url = AppUrls.DtkGoodsNineOpGoodsList()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkGoodsPriceTrendStub {

    /**
     * 商品历史券后价
     */
    static func my_post(args: ApiDtGoodsPriceTrendArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtDtkGoodsPriceTrendResponseModel) -> Void) {
        let url = AppUrls.DtkGoodsPriceTrend()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkGuessYouLikeStub {

    /**
     * 猜你喜欢
     */
    static func my_post(args: ApiDtGoodsExplosiveGoodsListArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtGenericItemListResponseModel) -> Void) {
        let url = AppUrls.DtkGuessYouLike()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkPrivilegeLinkStub {

    /**
     * 高效转链
     */
    static func my_post(args: ApiDtTbServiceGetPrivilegeLinkArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtDtkPrivilegeLinkResponseModel) -> Void) {
        let url = AppUrls.DtkPrivilegeLink()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkRankingListStub {

    /**
     * 各大榜单
     */
    static func my_post(args: ApiDtGoodsGetRankingListArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtGenericItemListResponseModel) -> Void) {
        let url = AppUrls.DtkRankingList()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkSearchGoodsStub {

    /**
     * 大淘客搜索
     */
    static func my_post(args: ApiDtGoodsGetDtkSearchGoodsArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtGenericItemListResponseModel) -> Void) {
        let url = AppUrls.DtkSearchGoods()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkSearchSuggestionStub {

    /**
     * 搜索联想词
     */
    static func my_post(args: ApiDtGoodsSearchSuggestionArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtDtkSearchSuggestionResponseModel) -> Void) {
        let url = AppUrls.DtkSearchSuggestion()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkSuperCategoryStub {

    /**
     * 超级分类
     */
    static func my_get(failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtDtkSuperCategoryResponseModel) -> Void) {
        let url = AppUrls.DtkSuperCategory()

        var request = URLRequest(url: url)
        request.httpMethod = "GET"


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkSuperSearchStub {

    /**
     * 超级搜索
     */
    static func my_post(args: ApiDtGoodsListSuperGoodsArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtGenericItemListResponseModel) -> Void) {
        let url = AppUrls.DtkSuperSearch()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkBrandListStub {

    /**
     * 超值大牌
     */
    static func my_post(args: ApiDtTbServiceGetBrandListArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtDtkBrandListResponseModel) -> Void) {
        let url = AppUrls.DtkBrandList()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkTbServiceStub {

    /**
     * 联盟搜索
     */
    static func my_post(args: ApiDtTbServiceGetTbServiceArgs, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtDtkTbServiceResponseModel) -> Void) {
        let url = AppUrls.DtkTbService()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiDtkTop100Stub {

    /**
     * 热搜记录
     */
    static func my_get(failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtDtkTop100ResponseModel) -> Void) {
        let url = AppUrls.DtkTop100()

        var request = URLRequest(url: url)
        request.httpMethod = "GET"


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiOrderListStub {

    /**
     * 获取订单列表
     */
    static func my_post(args: ApiDtOrderListForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtOrderListResponseModel) -> Void) {
        let url = AppUrls.OrderList()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiShareAndroidRelationTklStub {

    /**
     * Android 使用淘口令分享商品
     */
    static func my_post(args: ApiDtShareItemTklForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtShareItemTklResponseModel) -> Void) {
        let url = AppUrls.ShareAndroidRelationTkl()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiShareIosRelationTklStub {

    /**
     * iOS 使用淘口令分享商品
     */
    static func my_post(args: ApiDtShareItemTklForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtShareItemTklResponseModel) -> Void) {
        let url = AppUrls.ShareIosRelationTkl()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiShareIosNoRelationTklStub {

    /**
     * iOS 使用淘口令分享商品
     */
    static func my_post(args: ApiDtShareItemTklForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtShareItemTklResponseModel) -> Void) {
        let url = AppUrls.ShareIosNoRelationTkl()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiSysConfigStub {

    /**
     * 系统配置
     */
    static func my_get(failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtSysConfigResponseModel) -> Void) {
        let url = AppUrls.SysConfig()

        var request = URLRequest(url: url)
        request.httpMethod = "GET"


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiTaobaoAuthUrlStub {

    /**
     * 渠道ID绑定配置
     */
    static func my_post(args: ApiDtAuthUrlForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtTaoBaoAuthUrlResponseModel) -> Void) {
        let url = AppUrls.TaobaoAuthUrl()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiTbkDtkBrandGoodsStub {

    /**
     * 大淘客品牌商品列表
     */
    static func my_post(args: ApiDtTbkBrandGoodsForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtGenericItemListResponseModel) -> Void) {
        let url = AppUrls.TbkDtkBrandGoods()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiTbkDtkBrandListStub {

    /**
     * 大淘客品牌列表
     */
    static func my_post(args: ApiDtTbkBrandListForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtTbkBrandListResponseModel) -> Void) {
        let url = AppUrls.TbkDtkBrandList()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiTbkItemDetailStub {

    /**
     * 单品详情
     */
    static func my_post(args: ApiDtTbkItemDetailForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtTbkGoodsDetailResponseModel) -> Void) {
        let url = AppUrls.TbkItemDetail()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiUserAuthStub {

    /**
     * 用户认证息
     */
    static func my_post(args: ApiDtUserNativeAuthForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtUserAuthResponseModel) -> Void) {
        let url = AppUrls.UserAuth()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiUserCancelStub {

    /**
     * 用户注销
     */
    static func my_post(args: ApiDtUserTokenForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtUserCancelResponseModel) -> Void) {
        let url = AppUrls.UserCancel()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiUserBindStub {

    /**
     * iOS用户绑定淘宝渠道ID
     */
    static func my_post(args: ApiDtTbBindForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtTbBindResponseModel) -> Void) {
        let url = AppUrls.UserBind()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiUserProfileStub {

    /**
     * 用户信息
     */
    static func my_post(args: ApiDtUserTokenForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtUserProfileResponseModel) -> Void) {
        let url = AppUrls.UserProfile()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiUserTbStub {

    /**
     * 用户是否已经进行淘宝认证
     */
    static func my_post(args: ApiDtUserTokenForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtUserTbResponseModel) -> Void) {
        let url = AppUrls.UserTb()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkBangDanTuiJianStub {

    /**
     * 榜单推荐
     */
    static func my_post(args: ApiDtBangDanTuiJianForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtBangDanTuiJianResponseModel) -> Void) {
        let url = AppUrls.ZtkBangDanTuiJian()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkGuessYouLikeStub {

    /**
     * 猜你喜欢
     */
    static func my_post(args: ApiDtGuessYouLikeForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtGuessYouLikeResponseModel) -> Void) {
        let url = AppUrls.ZtkGuessYouLike()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkItemV2Stub {

    /**
     * 商品详情
     */
    static func my_get(item_id: String, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtItemV2ResponseModel) -> Void) {

        let __url = AppUrls.ZtkItemV2()
        var __u = URLComponents(url: __url, resolvingAgainstBaseURL: false)
        __u?.queryItems = [
            URLQueryItem(name: "item_id", value: item_id.description)
        ]
        guard let url = __u?.url else {
            return
        }


        var request = URLRequest(url: url)
        request.httpMethod = "GET"


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkJuHuaSuanStub {

    /**
     * 聚划算
     */
    static func my_post(args: ApiDtJuHuaSuanForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtJuHuanSuanResponseModel) -> Void) {
        let url = AppUrls.ZtkJuHuaSuan()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkNineNineStub {

    /**
     * 9.9 包邮购
     */
    static func my_post(args: ApiDtNineNineForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtNineNineResponseModel) -> Void) {
        let url = AppUrls.ZtkNineNine()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkSuggestStub {

    /**
     * 关键词推荐
     */
    static func my_get(content: String, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtSuggestResponseModel) -> Void) {

        let __url = AppUrls.ZtkSuggest()
        var __u = URLComponents(url: __url, resolvingAgainstBaseURL: false)
        __u?.queryItems = [
            URLQueryItem(name: "content", value: content.description)
        ]
        guard let url = __u?.url else {
            return
        }


        var request = URLRequest(url: url)
        request.httpMethod = "GET"


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkTmallChaoShiStub {

    /**
     * 天猫超市
     */
    static func my_post(args: ApiDtTMallChaoShiForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtTMallChaoShiResponseModel) -> Void) {
        let url = AppUrls.ZtkTmallChaoShi()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkTmallShangPinStub {

    /**
     * 天猫商品
     */
    static func my_post(args: ApiDtTMallShangPinForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtTMallShangPinResponseModel) -> Void) {
        let url = AppUrls.ZtkTmallShangPin()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkGaoYongStub {

    /**
     * 高佣转链
     */
    static func my_post(args: ApiDtGaoYongForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtGaoYongResponseModel) -> Void) {
        let url = AppUrls.ZtkGaoYong()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkKeywordStub {

    /**
     * 关键词推荐
     */
    static func my_get(failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtKeywordResponseModel) -> Void) {
        let url = AppUrls.ZtkKeyword()

        var request = URLRequest(url: url)
        request.httpMethod = "GET"


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}


struct ApiZtkSearchStub {

    /**
     * 全网商品搜索
     */
    static func my_post(args: ApiDtSearchForm, failure_cb: @escaping () -> Void, success_cb: @escaping (ApiDtSearchResponseModel) -> Void) {
        let url = AppUrls.ZtkSearch()

        var request = URLRequest(url: url)
        request.httpMethod = "POST"


        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let en = JSONEncoder()
        let data = try! en.encode(args)
        request.httpBody = data


        gen_slot_http_request_helper(request: request, failure_cb: failure_cb, success_cb: success_cb)
    }

}



