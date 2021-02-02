typealias ApiDtAppErrno = Int
typealias ApiDtOrderType = Int


struct ApiDtAuthUrlDataModel: Codable {
    let url: String /* 要绑定的 URL */
}


struct ApiDtAuthUrlForm: Codable {
    let token: String /* 认证 TOKEN */
}


struct ApiDtBangDanTuiJianForm: Codable {
    let page: Int? /* 分页 */
    let page_size: Int? /* 每页数据条数 */
    let sort: String? /* 商品排序方式 */
    let cid: Int? /* 一级商品分类 */
}


struct ApiDtBangDanTuiJianModel: Codable {
    let code: String /* 折淘客编号 */
    let type_one_id: String /* 分类 id, 参见: cid */
    let tao_id: String /* 淘宝的商品 id */
    let title: String /* 商品的标题 */
    let jianjie: String /* 商品的简介 */
    let pict_url: String /* 商品的主图 */
    let user_type: String /* 卖家类型 */
    let seller_id: String /* 商家的 id */
    let shop_dsr: String /* 店铺 dsr 评分 */
    let volume: String /* 30天销量 */
    let size: String /* 折扣价 */
    let quanhou_jiage: String /* 券后价格 */
    let date_time_yongjin: String /* 数据更新时间 */
    let tkrate3: String /* 佣金比例 */
    let yongjin_type: String /* 佣金类型 */
    let coupon_id: String /* 优惠券ID */
    let coupon_start_time: String /* 优惠券开始时间 */
    let coupon_end_time: String /* 优惠券结束时间 */
    let coupon_info_money: String /* 优惠券金额 */
    let coupon_total_count: String /* 优惠券总量 */
    let coupon_remain_count: String /* 优惠券剩余数量 */
    let coupon_info: String /* 优惠券信息 */
    let juhuasuan: String /* 是否为 聚划算 */
    let taoqianggou: String /* 是否为 淘抢购 */
    let haitao: String /* 是否为 海淘 */
    let jiyoujia: String /* 是否极有家 */
    let jinpaimaijia: String /* 是否为 金牌卖家 */
    let pinpai: String /* 是否为 品牌 */
    let pinpai_name: String /* 品牌名称 */
    let yunfeixian: String /* ??? */
    let nick: String /* 店铺名称 */
    let small_images: String /* 商品组图/商品小图列表 */
    let white_image: String /* 商品白底图 */
    let tao_title: String /* 商品长标题 */
    let provcity: String /* 省份 城市 */
    let shop_title: String /* 商家名称 */
    let zhibo_url: String /* 直播地址 */
    let sellCount: String /* 销售数量 */
    let commentCount: String /* 评论数量 */
    let favcount: String /* 喜欢数量 */
    let score1: String /* 宝贝描述分 */
    let score2: String /* 卖家服务分 */
    let score3: String /* 物流服务分 */
    let creditLevel: String /* 店铺等级 */
    let shopIcon: String /* 商家图标 URL */
    let pcDescContent: String /* 内容 url */
    let item_url: String /* 商品地址 */
    let category_id: String /* 分类 id */
    let category_name: String /* 分类名称 */
    let level_one_category_id: String /* ??? */
    let level_one_category_name: String /* ??? */
    let volume_shishi: String /* 两小时销量 */
    let volume_quantian: String /* 全天销量 */
    let tk_sale_count: String /* 人气值 */
    let tkfee3: String /* ??? */
    let biaoqian: String /* 店铺活动 */
    let tag: String /* 朋友圈文案 */
}


struct ApiDtBangDanTuiJianResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtBangDanTuiJianModel]? /* 详细数据 */
}


struct ApiDtCategoryDdqGoodsListArgs: Codable {
    let roundTime: String? /* 默认为当前场次，场次时间输入方式：yyyy-mm-dd hh:mm:ss */
}


struct ApiDtCategoryGetSuperCategoryResp: Codable {
    let cid: Int? /* Cid */
    let cname: String? /* Cname */
    let cpic: String? /* Cpic */
    let subcategories: [ApiDtCategoryGetSuperCategoryRespSubcategories]? /* Subcategories */
}


struct ApiDtCategoryGetSuperCategoryRespSubcategories: Codable {
    let subcid: Int? /* Subcid */
    let subcname: String? /* Subcname */
    let scpic: String? /* Scpic */
}


struct ApiDtDtkBrandListResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtTbServiceGetBrandListResp]? /* 详细数据 */
}


struct ApiDtDtkGoodsDetailResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: ApiDtGoodsGetGoodsDetailsResp? /* 详细数据 */
}


struct ApiDtDtkGoodsPriceTrendResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: ApiDtGoodsPriceTrendResp? /* 详细数据 */
}


struct ApiDtDtkPrivilegeLinkResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: ApiDtTbServiceGetPrivilegeLinkResp? /* 详细数据 */
}


struct ApiDtDtkSearchSuggestionResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [String]? /* 详细数据 */
}


struct ApiDtDtkSuperCategoryResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtCategoryGetSuperCategoryResp]? /* 详细数据 */
}


struct ApiDtDtkTbServiceResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtTbServiceGetTbServiceResp]? /* 详细数据 */
}


struct ApiDtDtkTop100ResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [String]? /* 详细数据 */
}


struct ApiDtGaoYongForm: Codable {
    let item_id: String /* 淘宝的商品 id */
    let token: String /* 认证 TOKEN */
}


struct ApiDtGaoYongModel: Codable {
    let code: String /* 折淘客编号 */
    let type_one_id: String /* 分类 id, 参见: cid */
    let tao_id: String /* 淘宝的商品 id */
    let title: String /* 商品的标题 */
    let jianjie: String /* 商品的简介 */
    let pict_url: String /* 商品的主图 */
    let user_type: String /* 卖家类型 */
    let seller_id: String /* 商家的 id */
    let shop_dsr: String /* 店铺 dsr 评分 */
    let volume: String /* 30天销量 */
    let size: String /* 折扣价 */
    let quanhou_jiage: String /* 券后价格 */
    let date_time_yongjin: String /* 数据更新时间 */
    let tkrate3: String /* 佣金比例 */
    let yongjin_type: String /* 佣金类型 */
    let coupon_id: String /* 优惠券ID */
    let coupon_start_time: String /* 优惠券开始时间 */
    let coupon_end_time: String /* 优惠券结束时间 */
    let coupon_info_money: String /* 优惠券金额 */
    let coupon_total_count: String /* 优惠券总量 */
    let coupon_remain_count: String /* 优惠券剩余数量 */
    let coupon_info: String /* 优惠券信息 */
    let juhuasuan: String /* 是否为 聚划算 */
    let taoqianggou: String /* 是否为 淘抢购 */
    let haitao: String /* 是否为 海淘 */
    let jiyoujia: String /* 是否极有家 */
    let jinpaimaijia: String /* 是否为 金牌卖家 */
    let pinpai: String /* 是否为 品牌 */
    let pinpai_name: String /* 品牌名称 */
    let yunfeixian: String /* ??? */
    let nick: String /* 店铺名称 */
    let small_images: String /* 商品组图/商品小图列表 */
    let white_image: String /* 商品白底图 */
    let tao_title: String /* 商品长标题 */
    let provcity: String /* 省份 城市 */
    let shop_title: String /* 商家名称 */
    let zhibo_url: String /* 直播地址 */
    let sellCount: String /* 销售数量 */
    let commentCount: String /* 评论数量 */
    let favcount: String /* 喜欢数量 */
    let score1: String /* 宝贝描述分 */
    let score2: String /* 卖家服务分 */
    let score3: String /* 物流服务分 */
    let creditLevel: String /* 店铺等级 */
    let shopIcon: String /* 商家图标 URL */
    let pcDescContent: String /* 内容 url */
    let taobao_url: String /* 商品URL */
    let category_id: String /* 分类 id */
    let category_name: String /* 分类名称 */
    let level_one_category_id: String /* ??? */
    let level_one_category_name: String /* ??? */
    let tkfee3: String /* ??? */
    let biaoqian: String /* 店铺活动 */
    let tag: String /* 朋友圈文案 */
    let date_time: String /* 数据添加时间 */
    let presale_discount_fee_text: String? /* 预售商品-商品优惠信息 */
    let presale_tail_end_time: String? /* 预售商品-付定金结束时间（毫秒） */
    let presale_tail_start_time: String? /* 预售商品-付尾款开始时间（毫秒） */
    let presale_end_time: String? /* 预售结束时间 */
    let presale_start_time: String? /* 预售开始时间 */
    let presale_deposit: String? /* 预售 ??? */
    let min_commission_rate: String /* Min Commission Rate */
    let coupon_click_url: String /* 二合一推广链接，已经自动拼接S券 */
    let item_url: String /* 商品地址 */
    let shorturl: String /* 淘宝短链接 */
    let tkl: String /* 淘口令 */
}


struct ApiDtGaoYongResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: ApiDtGaoYongModel? /* 详细数据 */
}


struct ApiDtGenericItemListResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtTbkItemInfo]? /* 详细数据 */
}


struct ApiDtGoodsExplosiveGoodsListArgs: Codable {
    let pageId: String /* 分页id：常规分页方式，请直接传入对应页码（比如：1,2,3……） */
    let pageSize: String /* 每页返回条数，每页条数支持输入10,20，50,100。默认50条 */
    let PriceCid: String? /* 价格区间，1表示10~20元区；2表示20~40元区；3表示40元以上区；默认为1 */
    let cids: String? /* 大淘客的一级分类id，如果需要传多个，以英文逗号相隔，如：”1,2,3”。1 -女装，2 -母婴，3 -美妆，4 -居家日用，5 -鞋品，6 -美食，7 -文娱车品，8 -数码家电，9 -男装，10 -内衣，11 -箱包，12 -配饰，13 -户外运动，14 -家装家纺。不填默认全部 */
}


struct ApiDtGoodsGetDtkSearchGoodsArgs: Codable {
    let pageId: String /* 分页id，默认为1，支持传统的页码分页方式和scroll_id分页方式，根据用户自身需求传入值。示例1：商品入库，则首次传入1，后续传入接口返回的pageid，接口将持续返回符合条件的完整商品列表，该方式可以避免入口商品重复；示例2：根据pagesize和totalNum计算出总页数，按照需求返回指定页的商品（该方式可能在临近页取到重复商品） */
    let pageSize: String /* 每页条数，默认为100，最大值200，若小于10，则按10条处理，每页条数仅支持输入10,50,100,200 */
    let keyWords: String /* 关键词搜索 */
    let cids: String? /* 大淘客的一级分类id，如果需要传多个，以英文逗号相隔，如：”1,2,3”。当一级类目id和二级类目id同时传入时，会自动忽略二级类目id，一级分类id请求详情：1 -女装，2 -母婴，3 -美妆，4 -居家日用，5 -鞋品，6 -美食，7 -文娱车品，8 -数码家电，9 -男装，10 -内衣，11 -箱包，12 -配饰，13 -户外运动，14 -家装家纺 */
    let subcid: String? /* 大淘客的二级类目id，通过超级分类API获取。仅允许传一个二级id，当一级类目id和二级类目id同时传入时，会自动忽略二级类目id */
    let juHuaSuan: String? /* 是否聚划算，1-聚划算商品，0-所有商品，不填默认为0 */
    let taoQiangGou: String? /* 是否淘抢购，1-淘抢购商品，0-所有商品，不填默认为0 */
    let tmall: String? /* 是否天猫商品，1-天猫商品，0-非天猫商品，不填默认为所有商品 */
    let tchaoshi: String? /* 是否天猫超市商品，1-天猫超市商品，0-所有商品，不填默认为0 */
    let goldSeller: String? /* 是否金牌卖家，1-金牌卖家，0-所有商品，不填默认为0 */
    let haitao: String? /* 是否海淘商品，1-海淘商品，0-所有商品，不填默认为0 */
    let brand: String? /* 是否品牌商品，1-品牌商品，0-所有商品，不填默认为0 */
    let brandIds: String? /* 品牌id，当brand传入0时，再传入brandIds将获取不到结果。品牌id可以传多个，以英文逗号隔开，如：”345,321,323” */
    let priceLowerLimit: String? /* 价格（券后价）下限 */
    let priceUpperLimit: String? /* 价格（券后价）上限 */
    let commissionRateLowerLimit: String? /* 最低佣金比率 */
    let sort: String? /* 排序字段，默认为0，0-综合排序，1-商品上架时间从新到旧，2-销量从高到低，3-领券量从高到低，4-佣金比例从高到低，5-价格（券后价）从高到低，6-价格（券后价）从低到高 */
    let freeshipRemoteDistrict: String? /* 偏远地区包邮，1-是，0-非偏远地区，不填默认所有商品 */
    let couponPriceLowerLimit: String? /* 最低优惠券面额 */
    let monthSalesLowerLimit: String? /* 最低月销量 */
}


struct ApiDtGoodsGetGoodsDetailsArgs: Codable {
    let id: String /* 大淘客商品id，请求时id或goodsId必填其中一个，若均填写，将优先查找当前单品id */
    let goodsId: String? /* 淘宝商品id，id或goodsId必填其中一个，若均填写，将优先查找当前单品id */
}


struct ApiDtGoodsGetGoodsDetailsResp: Codable {
    let id: Int? /* Id */
    let goodsId: String? /* Goodsid */
    let title: String? /* Title */
    let dtitle: String? /* Dtitle */
    let originalPrice: Float? /* Originalprice */
    let actualPrice: Float? /* Actualprice */
    let shopType: Int? /* Shoptype */
    let goldSellers: Int? /* Goldsellers */
    let monthSales: Int? /* Monthsales */
    let twoHoursSales: Int? /* Twohourssales */
    let dailySales: Int? /* Dailysales */
    let commissionType: Int? /* Commissiontype */
    let desc: String? /* Desc */
    let couponReceiveNum: Int? /* Couponreceivenum */
    let couponLink: String? /* Couponlink */
    let couponEndTime: String? /* Couponendtime */
    let couponStartTime: String? /* Couponstarttime */
    let couponPrice: Float? /* Couponprice */
    let couponConditions: String? /* Couponconditions */
    let activityType: Int? /* Activitytype */
    let createTime: String? /* Createtime */
    let mainPic: String? /* Mainpic */
    let marketingMainPic: String? /* Marketingmainpic */
    let sellerId: String? /* Sellerid */
    let brandWenan: String? /* Brandwenan */
    let cid: Int? /* Cid */
    let discounts: Float? /* Discounts */
    let commissionRate: Float? /* Commissionrate */
    let couponTotalNum: Int? /* Coupontotalnum */
    let haitao: Int? /* Haitao */
    let activityStartTime: String? /* Activitystarttime */
    let activityEndTime: String? /* Activityendtime */
    let shopName: String? /* Shopname */
    let shopLevel: Int? /* Shoplevel */
    let descScore: Float? /* Descscore */
    let brand: Int? /* Brand */
    let brandId: Int? /* Brandid */
    let brandName: String? /* Brandname */
    let hotPush: Int? /* Hotpush */
    let teamName: String? /* Teamname */
    let itemLink: String? /* Itemlink */
    let tchaoshi: Int? /* Tchaoshi */
    let dsrScore: Float? /* Dsrscore */
    let dsrPercent: Float? /* Dsrpercent */
    let shipScore: Float? /* Shipscore */
    let shipPercent: Float? /* Shippercent */
    let serviceScore: Float? /* Servicescore */
    let servicePercent: Float? /* Servicepercent */
    let subcid: [String]? /* Subcid */
    let imgs: String? /* Imgs */
    let reimgs: String? /* Reimgs */
    let quanMLink: Int? /* Quanmlink */
    let hzQuanOver: Int? /* Hzquanover */
    let yunfeixian: Int? /* Yunfeixian */
    let estimateAmount: Int? /* Estimateamount */
    let shopLogo: String? /* Shoplogo */
    let specialText: [String]? /* Specialtext */
    let freeshipRemoteDistrict: Int? /* Freeshipremotedistrict */
    let video: String? /* Video */
    let detailPics: String? /* Detailpics */
    let isSubdivision: Int? /* Issubdivision */
    let subdivisionId: Int? /* Subdivisionid */
    let subdivisionName: String? /* Subdivisionname */
    let subdivisionRank: Int? /* Subdivisionrank */
    let tbcid: Int? /* Tbcid */
}


struct ApiDtGoodsGetGoodsListArgs: Codable {
    let pageId: String /* 默认为1，支持传统的页码分页方式和scroll_id分页方式，根据用户自身需求传入值。示例1：商品入库，则首次传入1，后续传入接口返回的pageid，接口将持续返回符合条件的完整商品列表，该方式可以避免入口商品重复；示例2：根据pagesize和totalNum计算出总页数，按照需求返回指定页的商品（该方式可能在临近页取到重复商品） */
    let pageSize: String? /* 每页条数，默认为100，最大值200，若小于10，则按10条处理，每页条数仅支持输入10,50,100,200 */
    let sort: String? /* 排序方式，默认为0，0-综合排序，1-商品上架时间从高到低，2-销量从高到低，3-领券量从高到低，4-佣金比例从高到低，5-价格（券后价）从高到低，6-价格（券后价）从低到高 */
    let cids: String? /* 大淘客的一级分类id，如果需要传多个，以英文逗号相隔，如：”1,2,3”。当一级类目id和二级类目id同时传入时，会自动忽略二级类目id */
    let subcid: String? /* 大淘客的二级类目id，通过超级分类API获取。仅允许传一个二级id，当一级类目id和二级类目id同时传入时，会自动忽略二级类目id */
    let juHuaSuan: String? /* 1-聚划算商品，0-所有商品，不填默认为0 */
    let taoQiangGou: String? /* 1-淘抢购商品，0-所有商品，不填默认为0 */
    let tmall: String? /* 1-天猫商品， 0-非天猫商品，不填默认所有商品 */
    let tchaoshi: String? /* 1-天猫超市商品， 0-所有商品，不填默认为0 */
    let goldSeller: String? /* 1-金牌卖家商品，0-所有商品，不填默认为0 */
    let haitao: String? /* 1-海淘商品， 0-所有商品，不填默认为0 */
    let pre: String? /* 1-预告商品，0-所有商品，不填默认为0 */
    let brand: String? /* 1-品牌商品，0-所有商品，不填默认为0 */
    let brandIds: String? /* 当brand传入0时，再传入brandIds可能无法获取结果。品牌id可以传多个，以英文逗号隔开，如：”345,321,323” */
    let priceLowerLimit: String? /* 价格（券后价）下限 */
    let priceUpperLimit: String? /* 价格（券后价）上限 */
    let commissionRateLowerLimit: String? /* 最低佣金比率 */
    let monthSalesLowerLimit: String? /* 最低月销量 */
    let specialId: String? /* 商品卖点，1.拍多件活动；2.多买多送；3.限量抢购；4.额外满减；6.买商品礼赠 */
    let freeshipRemoteDistrict: String? /* 偏远地区包邮，1-是，0-非偏远地区，不填默认所有商品 */
    let couponPriceLowerLimit: String? /* 最低优惠券面额 */
    let preSale: String? /* 1-活动预售商品，0-所有商品，不填默认为0。*（10.30新增字段）* */
}


struct ApiDtGoodsGetRankingListArgs: Codable {
    let rankType: String /* 榜单类型，1.实时榜 2.全天榜 3.热推榜 4.复购榜 5.热词飙升榜 6.热词排行榜 7.综合热搜榜 */
    let cid: String? /* 大淘客一级类目id，仅对实时榜单、全天榜单有效 */
    let pageSize: String? /* 每页条数返回条数（支持10,20.50，默认返回20条） */
    let pageId: String? /* 分页id：常规分页方式，请直接传入对应页码（比如：1,2,3……）。*超过200条，分页返回为空* */
}


struct ApiDtGoodsListSuperGoodsArgs: Codable {
    let pageId: String /* 请求的页码，默认参数1 */
    let pageSize: String /* 每页条数，默认为20，最大值100 */
    let keyWords: String /* 关键词搜索 */
    let type: String /* 搜索类型：0-综合结果，1-大淘客商品，2-联盟商品 */
    let tmall: String? /* 是否天猫商品：1-天猫商品，0-所有商品，不填默认为0 */
    let haitao: String? /* 是否海淘商品：1-海淘商品，0-所有商品，不填默认为0 */
    let sort: String? /* 排序字段信息 销量（total_sales） 价格（price），排序_des（降序），排序_asc（升序），示例：升序查询销量total_sales_asc */
    let specialId: String? /* 会员运营id */
    let channelId: String? /* 渠道id将会和传入的pid进行验证，验证通过将正常转链，请确认填入的渠道id是正确的*channelId对应联盟的relationId* */
}


struct ApiDtGoodsNineOpGoodsListArgs: Codable {
    let pageId: String /* 分页id：常规分页方式，请直接传入对应页码（比如：1,2,3……） */
    let pageSize: String /* 每页条数：默认为20，最大值100 */
    let nineCid: String /* 9.9精选的类目id，分类id请求详情：*-1-精选，1 -5.9元区，2 -9.9元区，3 -19.9元区（调整字段）* */
}


struct ApiDtGoodsPriceTrendArgs: Codable {
    let id: String /* 在大淘客的在线商品id（已下架的商品id不支持） */
    let goodsId: String? /* 淘宝商品id */
}


struct ApiDtGoodsPriceTrendResp: Codable {
    let id: Int? /* Id */
    let goodsId: String? /* Goodsid */
    let title: String? /* Title */
    let dtitle: String? /* Dtitle */
    let originalPrice: Float? /* Originalprice */
    let historicalPrice: [ApiDtGoodsPriceTrendRespHistoricalprice]? /* Historicalprice */
    let monthSales: Int? /* Monthsales */
    let twoHoursSales: Int? /* Twohourssales */
    let dailySales: Int? /* Dailysales */
    let commissionType: Int? /* Commissiontype */
    let desc: String? /* Desc */
    let couponReceiveNum: Int? /* Couponreceivenum */
    let couponEndTime: String? /* Couponendtime */
    let couponStartTime: String? /* Couponstarttime */
    let couponPrice: Float? /* Couponprice */
    let couponConditions: String? /* Couponconditions */
    let mainPic: String? /* Mainpic */
    let marketingMainPic: String? /* Marketingmainpic */
    let commissionRate: Float? /* Commissionrate */
    let couponTotalNum: Int? /* Coupontotalnum */
    let brandId: Int? /* Brandid */
    let brandName: String? /* Brandname */
    let itemLink: String? /* Itemlink */
}


struct ApiDtGoodsPriceTrendRespHistoricalprice: Codable {
    let actualPrice: Float? /* Actualprice */
    let date: String? /* Date */
}


struct ApiDtGoodsSearchSuggestionArgs: Codable {
    let keyWords: String /* 关键词 */
    let type: String /* 当前搜索API类型：1.大淘客搜索 2.联盟搜索 3.超级搜索 */
}


struct ApiDtGuessYouLikeForm: Codable {
    let page: Int? /* 分页 */
    let page_size: Int? /* 每页数据条数 */
    let sort: String? /* 商品排序方式 */
    let device_value: String? /* 设备号 */
    let device_encrypt: String? /* 设备类型 */
    let item_id: String? /* 商品ID */
}


struct ApiDtGuessYouLikeModel: Codable {
    let code: String /* 折淘客编号 */
    let type_one_id: String /* 分类 id, 参见: cid */
    let tao_id: String /* 淘宝的商品 id */
    let title: String /* 商品的标题 */
    let jianjie: String /* 商品的简介 */
    let pict_url: String /* 商品的主图 */
    let user_type: String /* 卖家类型 */
    let seller_id: String /* 商家的 id */
    let shop_dsr: String /* 店铺 dsr 评分 */
    let volume: String /* 30天销量 */
    let size: String /* 折扣价 */
    let quanhou_jiage: String /* 券后价格 */
    let date_time_yongjin: String /* 数据更新时间 */
    let tkrate3: String /* 佣金比例 */
    let yongjin_type: String /* 佣金类型 */
    let coupon_id: String /* 优惠券ID */
    let coupon_start_time: String /* 优惠券开始时间 */
    let coupon_end_time: String /* 优惠券结束时间 */
    let coupon_info_money: String /* 优惠券金额 */
    let coupon_total_count: String /* 优惠券总量 */
    let coupon_remain_count: String /* 优惠券剩余数量 */
    let coupon_info: String /* 优惠券信息 */
    let juhuasuan: String /* 是否为 聚划算 */
    let taoqianggou: String /* 是否为 淘抢购 */
    let haitao: String /* 是否为 海淘 */
    let jiyoujia: String /* 是否极有家 */
    let jinpaimaijia: String /* 是否为 金牌卖家 */
    let pinpai: String /* 是否为 品牌 */
    let pinpai_name: String /* 品牌名称 */
    let yunfeixian: String /* ??? */
    let nick: String /* 店铺名称 */
    let small_images: String /* 商品组图/商品小图列表 */
    let white_image: String /* 商品白底图 */
    let tao_title: String /* 商品长标题 */
    let provcity: String /* 省份 城市 */
    let shop_title: String /* 商家名称 */
    let zhibo_url: String /* 直播地址 */
    let sellCount: String /* 销售数量 */
    let commentCount: String /* 评论数量 */
    let favcount: String /* 喜欢数量 */
    let score1: String /* 宝贝描述分 */
    let score2: String /* 卖家服务分 */
    let score3: String /* 物流服务分 */
    let creditLevel: String /* 店铺等级 */
    let shopIcon: String /* 商家图标 URL */
    let pcDescContent: String /* 内容 url */
    let item_url: String /* 商品地址 */
    let category_id: String /* 分类 id */
    let category_name: String /* 分类名称 */
    let level_one_category_id: String /* ??? */
    let level_one_category_name: String /* ??? */
    let tkfee3: String /* ??? */
}


struct ApiDtGuessYouLikeResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtGuessYouLikeModel]? /* 返回数据 */
}


struct ApiDtHTTPValidationError: Codable {
    let detail: [ApiDtValidationError]? /* Detail */
}


struct ApiDtItemDetailV2Model: Codable {
    let code: String /* 折淘客编号 */
    let type_one_id: String /* 分类 id, 参见: cid */
    let tao_id: String /* 淘宝的商品 id */
    let title: String /* 商品的标题 */
    let jianjie: String /* 商品的简介 */
    let pict_url: String /* 商品的主图 */
    let user_type: String /* 卖家类型 */
    let seller_id: String /* 商家的 id */
    let shop_dsr: String /* 店铺 dsr 评分 */
    let volume: String /* 30天销量 */
    let size: String /* 折扣价 */
    let quanhou_jiage: String /* 券后价格 */
    let date_time_yongjin: String /* 数据更新时间 */
    let tkrate3: String /* 佣金比例 */
    let yongjin_type: String /* 佣金类型 */
    let coupon_id: String /* 优惠券ID */
    let coupon_start_time: String /* 优惠券开始时间 */
    let coupon_end_time: String /* 优惠券结束时间 */
    let coupon_info_money: String /* 优惠券金额 */
    let coupon_total_count: String /* 优惠券总量 */
    let coupon_remain_count: String /* 优惠券剩余数量 */
    let coupon_info: String /* 优惠券信息 */
    let juhuasuan: String /* 是否为 聚划算 */
    let taoqianggou: String /* 是否为 淘抢购 */
    let haitao: String /* 是否为 海淘 */
    let jiyoujia: String /* 是否极有家 */
    let jinpaimaijia: String /* 是否为 金牌卖家 */
    let pinpai: String /* 是否为 品牌 */
    let pinpai_name: String /* 品牌名称 */
    let yunfeixian: String /* ??? */
    let nick: String /* 店铺名称 */
    let small_images: String /* 商品组图/商品小图列表 */
    let white_image: String /* 商品白底图 */
    let tao_title: String /* 商品长标题 */
    let provcity: String /* 省份 城市 */
    let shop_title: String /* 商家名称 */
    let zhibo_url: String /* 直播地址 */
    let sellCount: String /* 销售数量 */
    let commentCount: String /* 评论数量 */
    let favcount: String /* 喜欢数量 */
    let score1: String /* 宝贝描述分 */
    let score2: String /* 卖家服务分 */
    let score3: String /* 物流服务分 */
    let creditLevel: String /* 店铺等级 */
    let shopIcon: String /* 商家图标 URL */
    let pcDescContent: String /* 内容 url */
    let item_url: String /* 商品地址 */
    let category_id: String /* 分类 id */
    let category_name: String /* 分类名称 */
    let level_one_category_id: String /* ??? */
    let level_one_category_name: String /* ??? */
    let tkfee3: String /* ??? */
    let biaoqian: String /* 店铺活动 */
    let tag: String /* 朋友圈文案 */
    let date_time: String /* 数据添加时间 */
    let presale_discount_fee_text: String? /* 预售商品-商品优惠信息 */
    let presale_tail_end_time: String? /* 预售商品-付定金结束时间（毫秒） */
    let presale_tail_start_time: String? /* 预售商品-付尾款开始时间（毫秒） */
    let presale_end_time: String? /* 预售结束时间 */
    let presale_start_time: String? /* 预售开始时间 */
    let presale_deposit: String? /* 预售 ??? */
    let min_commission_rate: String /* Min Commission Rate */
}


struct ApiDtItemV2ResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtItemDetailV2Model]? /* 详细数据 */
}


struct ApiDtJuHuaSuanForm: Codable {
    let page: Int? /* 分页 */
    let page_size: Int? /* 每页数据条数 */
    let sort: String? /* 商品排序方式 */
    let cid: Int? /* 一级商品分类 */
}


struct ApiDtJuHuaSuanModel: Codable {
    let code: String /* 折淘客编号 */
    let type_one_id: String /* 分类 id, 参见: cid */
    let tao_id: String /* 淘宝的商品 id */
    let title: String /* 商品的标题 */
    let jianjie: String /* 商品的简介 */
    let pict_url: String /* 商品的主图 */
    let user_type: String /* 卖家类型 */
    let seller_id: String /* 商家的 id */
    let shop_dsr: String /* 店铺 dsr 评分 */
    let volume: String /* 30天销量 */
    let size: String /* 折扣价 */
    let quanhou_jiage: String /* 券后价格 */
    let date_time_yongjin: String /* 数据更新时间 */
    let tkrate3: String /* 佣金比例 */
    let yongjin_type: String /* 佣金类型 */
    let coupon_id: String /* 优惠券ID */
    let coupon_start_time: String /* 优惠券开始时间 */
    let coupon_end_time: String /* 优惠券结束时间 */
    let coupon_info_money: String /* 优惠券金额 */
    let coupon_total_count: String /* 优惠券总量 */
    let coupon_remain_count: String /* 优惠券剩余数量 */
    let coupon_info: String /* 优惠券信息 */
    let juhuasuan: String /* 是否为 聚划算 */
    let taoqianggou: String /* 是否为 淘抢购 */
    let haitao: String /* 是否为 海淘 */
    let jiyoujia: String /* 是否极有家 */
    let jinpaimaijia: String /* 是否为 金牌卖家 */
    let pinpai: String /* 是否为 品牌 */
    let pinpai_name: String /* 品牌名称 */
    let yunfeixian: String /* ??? */
    let nick: String /* 店铺名称 */
    let small_images: String /* 商品组图/商品小图列表 */
    let white_image: String /* 商品白底图 */
    let tao_title: String /* 商品长标题 */
    let provcity: String /* 省份 城市 */
    let shop_title: String /* 商家名称 */
    let zhibo_url: String /* 直播地址 */
    let sellCount: String /* 销售数量 */
    let commentCount: String /* 评论数量 */
    let favcount: String /* 喜欢数量 */
    let score1: String /* 宝贝描述分 */
    let score2: String /* 卖家服务分 */
    let score3: String /* 物流服务分 */
    let creditLevel: String /* 店铺等级 */
    let shopIcon: String /* 商家图标 URL */
    let pcDescContent: String /* 内容 url */
    let item_url: String /* 商品地址 */
    let category_id: String /* 分类 id */
    let category_name: String /* 分类名称 */
    let level_one_category_id: String /* ??? */
    let level_one_category_name: String /* ??? */
    let tkfee3: String /* ??? */
    let biaoqian: String /* 店铺活动 */
    let tag: String /* 朋友圈文案 */
    let presale_discount_fee_text: String? /* 预售商品-商品优惠信息 */
    let presale_tail_end_time: String? /* 预售商品-付定金结束时间（毫秒） */
    let presale_tail_start_time: String? /* 预售商品-付尾款开始时间（毫秒） */
    let presale_end_time: String? /* 预售结束时间 */
    let presale_start_time: String? /* 预售开始时间 */
    let presale_deposit: String? /* 预售 ??? */
}


struct ApiDtJuHuanSuanResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtJuHuaSuanModel]? /* 具体信息 */
}


struct ApiDtKeywordResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [String]? /* 热词/关键字 */
}


struct ApiDtNineNineForm: Codable {
    let page: Int? /* 分页 */
    let page_size: Int? /* 每页数据条数 */
    let sort: String? /* 商品排序方式 */
    let cid: Int? /* 一级商品分类 */
    let price: String? /* 商品价格 */
}


struct ApiDtNineNineModel: Codable {
    let code: String /* 折淘客编号 */
    let type_one_id: String /* 分类 id, 参见: cid */
    let tao_id: String /* 淘宝的商品 id */
    let title: String /* 商品的标题 */
    let jianjie: String /* 商品的简介 */
    let pict_url: String /* 商品的主图 */
    let user_type: String /* 卖家类型 */
    let seller_id: String /* 商家的 id */
    let shop_dsr: String /* 店铺 dsr 评分 */
    let volume: String /* 30天销量 */
    let size: String /* 折扣价 */
    let quanhou_jiage: String /* 券后价格 */
    let date_time_yongjin: String /* 数据更新时间 */
    let tkrate3: String /* 佣金比例 */
    let yongjin_type: String /* 佣金类型 */
    let coupon_id: String /* 优惠券ID */
    let coupon_start_time: String /* 优惠券开始时间 */
    let coupon_end_time: String /* 优惠券结束时间 */
    let coupon_info_money: String /* 优惠券金额 */
    let coupon_total_count: String /* 优惠券总量 */
    let coupon_remain_count: String /* 优惠券剩余数量 */
    let coupon_info: String /* 优惠券信息 */
    let juhuasuan: String /* 是否为 聚划算 */
    let taoqianggou: String /* 是否为 淘抢购 */
    let haitao: String /* 是否为 海淘 */
    let jiyoujia: String /* 是否极有家 */
    let jinpaimaijia: String /* 是否为 金牌卖家 */
    let pinpai: String /* 是否为 品牌 */
    let pinpai_name: String /* 品牌名称 */
    let yunfeixian: String /* ??? */
    let nick: String /* 店铺名称 */
    let small_images: String /* 商品组图/商品小图列表 */
    let white_image: String /* 商品白底图 */
    let tao_title: String /* 商品长标题 */
    let provcity: String /* 省份 城市 */
    let shop_title: String /* 商家名称 */
    let zhibo_url: String /* 直播地址 */
    let sellCount: String /* 销售数量 */
    let commentCount: String /* 评论数量 */
    let favcount: String /* 喜欢数量 */
    let score1: String /* 宝贝描述分 */
    let score2: String /* 卖家服务分 */
    let score3: String /* 物流服务分 */
    let creditLevel: String /* 店铺等级 */
    let shopIcon: String /* 商家图标 URL */
    let pcDescContent: String /* 内容 url */
    let item_url: String /* 商品地址 */
    let category_id: String /* 分类 id */
    let category_name: String /* 分类名称 */
    let level_one_category_id: String /* ??? */
    let level_one_category_name: String /* ??? */
    let tkfee3: String /* ??? */
    let biaoqian: String /* 店铺活动 */
    let tag: String /* 朋友圈文案 */
    let presale_discount_fee_text: String? /* 预售商品-商品优惠信息 */
    let presale_tail_end_time: String? /* 预售商品-付定金结束时间（毫秒） */
    let presale_tail_start_time: String? /* 预售商品-付尾款开始时间（毫秒） */
    let presale_end_time: String? /* 预售结束时间 */
    let presale_start_time: String? /* 预售开始时间 */
    let presale_deposit: String? /* 预售 ??? */
}


struct ApiDtNineNineResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtNineNineModel]? /* 具体数据 */
}


struct ApiDtOrderListDataModel: Codable {
    let order_platform: String /* 订单平台 */
    let order_no: String /* 订单号 */
    let order_parent_no: String /* 订单组号 */
    let order_num: Int? /* 购买数量 */
    let order_ctime: String /* 订单创建时间 */
    let order_status: String /* 订单状态 */
    let pay_price: Float /* 付款价格 */
    let pay_time: String /* 支付时间 */
    let end_time: String /* 结束时间 */
    let item_id: String /* 商品ID */
    let item_title: String /* 商品名称 */
    let item_pic: String /* 商品主图 */
    let item_price: Float /* 商品价格 */
    let item_category: String /* 商品分类 */
    let shop_title: String /* 商家名称 */
    let income: Float /* 收入 */
    let score: Int? /* 积分 */
    let status: String /* 状态 */
    let ctime: String /* 创建时间 */
    let mtime: String /* 最近修改时间 */
}


struct ApiDtOrderListForm: Codable {
    let token: String /* 认证 TOKEN */
    let page: Int? /* 分页 */
    let typ: ApiDtOrderType /* 订单类型 */
}


struct ApiDtOrderListResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtOrderListDataModel]? /* 详细数据 */
}


struct ApiDtSearchForm: Codable {
    let q: String /* 商品标题 */
    let page: Int? /* 分页 */
    let page_size: Int? /* 每页数据条数 */
    let sort: String? /* 商品排序方式 */
    let youquan: Int? /* 是否有券 */
}


struct ApiDtSearchModel: Codable {
    let code: String /* 折淘客编号 */
    let type_one_id: String /* 分类 id, 参见: cid */
    let tao_id: String /* 淘宝的商品 id */
    let title: String /* 商品的标题 */
    let jianjie: String /* 商品的简介 */
    let pict_url: String /* 商品的主图 */
    let user_type: String /* 卖家类型 */
    let seller_id: String /* 商家的 id */
    let shop_dsr: String /* 店铺 dsr 评分 */
    let volume: String /* 30天销量 */
    let size: String /* 折扣价 */
    let quanhou_jiage: String /* 券后价格 */
    let date_time_yongjin: String /* 数据更新时间 */
    let tkrate3: String /* 佣金比例 */
    let yongjin_type: String /* 佣金类型 */
    let coupon_id: String /* 优惠券ID */
    let coupon_start_time: String /* 优惠券开始时间 */
    let coupon_end_time: String /* 优惠券结束时间 */
    let coupon_info_money: String /* 优惠券金额 */
    let coupon_total_count: String /* 优惠券总量 */
    let coupon_remain_count: String /* 优惠券剩余数量 */
    let coupon_info: String /* 优惠券信息 */
    let juhuasuan: String /* 是否为 聚划算 */
    let taoqianggou: String /* 是否为 淘抢购 */
    let haitao: String /* 是否为 海淘 */
    let jiyoujia: String /* 是否极有家 */
    let jinpaimaijia: String /* 是否为 金牌卖家 */
    let pinpai: String /* 是否为 品牌 */
    let pinpai_name: String /* 品牌名称 */
    let yunfeixian: String /* ??? */
    let nick: String /* 店铺名称 */
    let small_images: String /* 商品组图/商品小图列表 */
    let white_image: String /* 商品白底图 */
    let tao_title: String /* 商品长标题 */
    let provcity: String /* 省份 城市 */
    let shop_title: String /* 商家名称 */
    let zhibo_url: String /* 直播地址 */
    let sellCount: String /* 销售数量 */
    let commentCount: String /* 评论数量 */
    let favcount: String /* 喜欢数量 */
    let score1: String /* 宝贝描述分 */
    let score2: String /* 卖家服务分 */
    let score3: String /* 物流服务分 */
    let creditLevel: String /* 店铺等级 */
    let shopIcon: String /* 商家图标 URL */
    let pcDescContent: String /* 内容 url */
    let item_url: String /* 商品地址 */
    let category_id: String /* 分类 id */
    let category_name: String /* 分类名称 */
    let level_one_category_id: String /* ??? */
    let level_one_category_name: String /* ??? */
    let tkfee3: String /* ??? */
    let biaoqian: String /* 店铺活动 */
    let tag: String /* 朋友圈文案 */
    let presale_discount_fee_text: String? /* 预售商品-商品优惠信息 */
    let presale_tail_end_time: String? /* 预售商品-付定金结束时间（毫秒） */
    let presale_tail_start_time: String? /* 预售商品-付尾款开始时间（毫秒） */
    let presale_end_time: String? /* 预售结束时间 */
    let presale_start_time: String? /* 预售开始时间 */
    let presale_deposit: String? /* 预售 ??? */
}


struct ApiDtSearchResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtSearchModel]? /* 详细数据 */
}


struct ApiDtShareItemTklForm: Codable {
    let item_id: String /* 淘宝的商品 id */
    let token: String /* 认证令牌 */
}


struct ApiDtShareItemTklResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: String? /* 淘口令 */
}


struct ApiDtSuggestResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [String]? /* 推荐词 */
}


struct ApiDtSysConfigDataModel: Codable {
    let pid: String /* 淘宝 PID 配置 */
}


struct ApiDtSysConfigResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: ApiDtSysConfigDataModel? /* 详细数据 */
}


struct ApiDtTMallChaoShiForm: Codable {
    let page: Int? /* 分页 */
    let page_size: Int? /* 每页数据条数 */
    let sort: String? /* 商品排序方式 */
    let cid: Int? /* 一级商品分类 */
    let price: String? /* 商品价格 */
}


struct ApiDtTMallChaoShiResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtTmallChaoShiModel]? /* 返回数据 */
}


struct ApiDtTMallShangPinForm: Codable {
    let page: Int? /* 分页 */
    let page_size: Int? /* 每页数据条数 */
    let sort: String? /* 商品排序方式 */
    let cid: Int? /* 一级商品分类 */
    let price: String? /* 商品价格 */
}


struct ApiDtTMallShangPinResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtTmallShangPinModel]? /* 详细数据 */
}


struct ApiDtTaoBaoAuthUrlResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: ApiDtAuthUrlDataModel? /* 详细数据 */
}


struct ApiDtTbBindForm: Codable {
    let code: String /* 授权的 access code */
    let token: String /* 认证 TOKEN */
}


struct ApiDtTbBindResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: Bool? /* 是否绑定了渠道 ID */
}


struct ApiDtTbServiceGetBrandListArgs: Codable {
    let pageId: String /* 页码 */
    let pageSize: String? /* 每页条数，默认为20，最大值100 */
}


struct ApiDtTbServiceGetBrandListResp: Codable {
    let cid: Int? /* Cid */
    let brandId: Int? /* Brandid */
    let brandName: String? /* Brandname */
    let brandLogo: String? /* Brandlogo */
    let brandEnglish: String? /* Brandenglish */
    let shop: [ApiDtTbServiceGetBrandListRespShop]? /* Shop */
    let brandScore: Int? /* Brandscore */
    let location: String? /* Location */
    let establishTime: String? /* Establishtime */
    let belongTo: String? /* Belongto */
    let position: String? /* Position */
    let consumer: String? /* Consumer */
    let label: String? /* Label */
    let simpleLabel: String? /* Simplelabel */
    let cids: String? /* Cids */
    let sales2h: Int? /* Sales2H */
    let fansNum: Int? /* Fansnum */
    let brandDesc: String? /* Branddesc */
}


struct ApiDtTbServiceGetBrandListRespShop: Codable {
    let name: String? /* Name */
    let sellerId: String? /* Sellerid */
}


struct ApiDtTbServiceGetPrivilegeLinkArgs: Codable {
    let goodsId: String /* 淘宝商品id */
    let couponId: String? /* 商品的优惠券ID，一个商品在联盟可能有多个优惠券，可通过填写该参数的方式选择使用的优惠券，请确认优惠券ID正确，否则无法正常跳转 */
    let pid: String? /* 推广位ID，用户可自由填写当前大淘客账号下已授权淘宝账号的任一pid，若未填写，则默认使用创建应用时绑定的pid */
    let channelId: String? /* 渠道id将会和传入的pid进行验证，验证通过将正常转链，请确认填入的渠道id是正确的 *channelId对应联盟的relationId* */
    let specialId: String? /* 会员运营id */
    let externalId: String? /* 淘宝客外部用户标记，如自身系统账户ID；微信ID等 */
    let rebateType: String? /* 付定返红包，0.不使用付定返红包，1.参与付定返红包 */
}


struct ApiDtTbServiceGetPrivilegeLinkResp: Codable {
    let couponClickUrl: String? /* Couponclickurl */
    let couponEndTime: String? /* Couponendtime */
    let couponInfo: String? /* Couponinfo */
    let couponStartTime: String? /* Couponstarttime */
    let itemId: String? /* Itemid */
    let couponTotalCount: String? /* Coupontotalcount */
    let couponRemainCount: String? /* Couponremaincount */
    let itemUrl: String? /* Itemurl */
    let tpwd: String? /* Tpwd */
    let maxCommissionRate: String? /* Maxcommissionrate */
    let shortUrl: String? /* Shorturl */
    let minCommissionRate: String? /* Mincommissionrate */
    let longTpwd: String? /* Longtpwd */
}


struct ApiDtTbServiceGetTbServiceArgs: Codable {
    let pageNo: String /* 第几页，默认1 */
    let pageSize: String /* 每页条数， 默认20，范围值1~100 */
    let keyWords: String /* 查询词 */
    let sort: String? /* 排序指标：销量（total_sales），淘客佣金比率（tk_rate）， 累计推广量（tk_total_sales），总支出佣金（tk_total_commi），价格（price）,排序方式：排序_des（降序），排序_asc（升序）,示例：升序查询销量：total_sales_asc */
    let source: String? /* 是否商城商品，设置为1表示该商品是属于淘宝商城商品，设置为非1或不设置表示不判断这个属性（和overseas字段冲突，若已请求source，请勿再请求overseas） */
    let overseas: String? /* 是否海外商品，设置为1表示该商品是属于海外商品，设置为非1或不设置表示不判断这个属性（和source字段冲突，若已请求overseas，请勿再请求source） */
    let endPrice: String? /* 折扣价范围上限，单位：元 */
    let startPrice: String? /* 折扣价范围下限，单位：元 */
    let startTkRate: String? /* 媒体淘客佣金比率下限，如：1234表示12.34% */
    let endTkRate: String? /* 商品筛选-淘客佣金比率上限，如：1234表示12.34% */
    let hasCoupon: String? /* 是否有优惠券，设置为true表示该商品有优惠券，设置为false或不设置表示不判断这个属性 */
    let specialId: String? /* 会员运营id */
    let channelId: String? /* 渠道id将会和传入的pid进行验证，验证通过将正常转链，请确认填入的渠道id是正确的*channelId对应联盟的relationId* */
}


struct ApiDtTbServiceGetTbServiceResp: Codable {
    let title: String? /* Title */
    let volume: Int? /* Volume */
    let nick: String? /* Nick */
    let coupon_start_time: String? /* Coupon Start Time */
    let coupon_end_time: String? /* Coupon End Time */
    let tk_total_sales: String? /* Tk Total Sales */
    let coupon_id: String? /* Coupon Id */
    let pict_url: String? /* Pict Url */
    let small_images: ApiDtTbServiceGetTbServiceRespSmall_images? /* None */
    let reserve_price: String? /* Reserve Price */
    let zk_final_price: String? /* Zk Final Price */
    let user_type: Int? /* User Type */
    let commission_rate: String? /* Commission Rate */
    let seller_id: Int? /* Seller Id */
    let coupon_total_count: Int? /* Coupon Total Count */
    let coupon_remain_count: Int? /* Coupon Remain Count */
    let coupon_info: String? /* Coupon Info */
    let shop_title: String? /* Shop Title */
    let shop_dsr: Int? /* Shop Dsr */
    let level_one_category_name: String? /* Level One Category Name */
    let level_one_category_id: Int? /* Level One Category Id */
    let category_name: String? /* Category Name */
    let category_id: Int? /* Category Id */
    let short_title: String? /* Short Title */
    let white_image: String? /* White Image */
    let coupon_start_fee: String? /* Coupon Start Fee */
    let coupon_amount: String? /* Coupon Amount */
    let item_description: String? /* Item Description */
    let item_id: Int? /* Item Id */
    let ysyl_tlj_face: Int? /* Ysyl Tlj Face */
    let presale_deposit: Int? /* Presale Deposit */
    let presale_discount_fee_text: String? /* Presale Discount Fee Text */
}


struct ApiDtTbServiceGetTbServiceRespSmall_images: Codable {
    let string: [String]? /* String */
}


struct ApiDtTbkBrandGoodsForm: Codable {
    let brand_id: String /* 品牌ID */
    let page_id: Int? /* 获取第几页数据 */
}


struct ApiDtTbkBrandInfo: Codable {
    let brand_id: String /* 品牌ID */
    let brand_name: String /* 品牌名称 */
    let brand_logo: String /* 品牌logo */
    let brand_desc: String? /* 品牌介绍 */
    let sales_2h: Int? /* 近期销量 */
}


struct ApiDtTbkBrandListForm: Codable {
    let page_id: Int? /* 获取第几页数据 */
}


struct ApiDtTbkBrandListResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: [ApiDtTbkBrandInfo]? /* 详细数据 */
}


struct ApiDtTbkGoodsDetailResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: ApiDtTbkItemInfo? /* 详细数据 */
}


struct ApiDtTbkItemDetailForm: Codable {
    let tao_id: String /* 淘宝商品ID */
}


struct ApiDtTbkItemInfo: Codable {
    let tao_id: String /* 商品ID */
    let tao_img: String /* 商品主图 */
    let tao_link: String? /* 商品链接 */
    let tao_details: [String]? /* 商品详情图 */
    let title_long: String /* 淘宝标题 */
    let title_short: String /* 短标题 */
    let price_origin: Float /* 商品原价 */
    let price_actual: Float /* 券后价 */
    let price_coupon: Float? /* 优惠券金额 */
    let seller_id: String? /* 卖家ID */
    let seller_name: String? /* 卖家名称 */
    let seller_logo: String? /* 卖家图标 */
    let seller_level: Int? /* 淘宝店铺等级 */
    let score_dsr: Float? /* 描述评级 */
    let score_ship: Float? /* 物流服务 */
    let score_service: Float? /* 卖家服务评级 */
    let percent_dsr: Float? /* 卖家描述同行比 */
    let percent_ship: Float? /* 物流同行比 */
    let percent_service: Float? /* 卖家服务同行比 */
    let commission_rate: Float? /* 佣金比例 */
    let commission_money: Float? /* 预估佣金 */
    let sale_month: Int? /* 月销量 */
    let sale_day: Int? /* 日销量 */
    let sale_two_hours: Int? /* 两小时销量 */
    let coupon_start_time: String? /* 优惠券开始时间 */
    let coupon_end_time: String? /* 优惠券结束时间 */
    let coupon_total_num: Int? /* 优惠券总量 */
    let coupon_recv_num: Int? /* 优惠券领取量 */
    let coupon_link: String? /* 优惠券链接 */
    let yun_fei_xian: Bool? /* 运费险 */
}


struct ApiDtTmallChaoShiModel: Codable {
    let code: String /* 折淘客编号 */
    let type_one_id: String /* 分类 id, 参见: cid */
    let tao_id: String /* 淘宝的商品 id */
    let title: String /* 商品的标题 */
    let jianjie: String /* 商品的简介 */
    let pict_url: String /* 商品的主图 */
    let user_type: String /* 卖家类型 */
    let seller_id: String /* 商家的 id */
    let shop_dsr: String /* 店铺 dsr 评分 */
    let volume: String /* 30天销量 */
    let size: String /* 折扣价 */
    let quanhou_jiage: String /* 券后价格 */
    let date_time_yongjin: String /* 数据更新时间 */
    let tkrate3: String /* 佣金比例 */
    let yongjin_type: String /* 佣金类型 */
    let coupon_id: String /* 优惠券ID */
    let coupon_start_time: String /* 优惠券开始时间 */
    let coupon_end_time: String /* 优惠券结束时间 */
    let coupon_info_money: String /* 优惠券金额 */
    let coupon_total_count: String /* 优惠券总量 */
    let coupon_remain_count: String /* 优惠券剩余数量 */
    let coupon_info: String /* 优惠券信息 */
    let juhuasuan: String /* 是否为 聚划算 */
    let taoqianggou: String /* 是否为 淘抢购 */
    let haitao: String /* 是否为 海淘 */
    let jiyoujia: String /* 是否极有家 */
    let jinpaimaijia: String /* 是否为 金牌卖家 */
    let pinpai: String /* 是否为 品牌 */
    let pinpai_name: String /* 品牌名称 */
    let yunfeixian: String /* ??? */
    let nick: String /* 店铺名称 */
    let small_images: String /* 商品组图/商品小图列表 */
    let white_image: String /* 商品白底图 */
    let tao_title: String /* 商品长标题 */
    let provcity: String /* 省份 城市 */
    let shop_title: String /* 商家名称 */
    let zhibo_url: String /* 直播地址 */
    let sellCount: String /* 销售数量 */
    let commentCount: String /* 评论数量 */
    let favcount: String /* 喜欢数量 */
    let score1: String /* 宝贝描述分 */
    let score2: String /* 卖家服务分 */
    let score3: String /* 物流服务分 */
    let creditLevel: String /* 店铺等级 */
    let shopIcon: String /* 商家图标 URL */
    let pcDescContent: String /* 内容 url */
    let item_url: String /* 商品地址 */
    let category_id: String /* 分类 id */
    let category_name: String /* 分类名称 */
    let level_one_category_id: String /* ??? */
    let level_one_category_name: String /* ??? */
    let tkfee3: String /* ??? */
    let biaoqian: String /* 店铺活动 */
    let tag: String /* 朋友圈文案 */
    let presale_discount_fee_text: String? /* 预售商品-商品优惠信息 */
    let presale_tail_end_time: String? /* 预售商品-付定金结束时间（毫秒） */
    let presale_tail_start_time: String? /* 预售商品-付尾款开始时间（毫秒） */
    let presale_end_time: String? /* 预售结束时间 */
    let presale_start_time: String? /* 预售开始时间 */
    let presale_deposit: String? /* 预售 ??? */
}


struct ApiDtTmallShangPinModel: Codable {
    let code: String /* 折淘客编号 */
    let type_one_id: String /* 分类 id, 参见: cid */
    let tao_id: String /* 淘宝的商品 id */
    let title: String /* 商品的标题 */
    let jianjie: String /* 商品的简介 */
    let pict_url: String /* 商品的主图 */
    let user_type: String /* 卖家类型 */
    let seller_id: String /* 商家的 id */
    let shop_dsr: String /* 店铺 dsr 评分 */
    let volume: String /* 30天销量 */
    let size: String /* 折扣价 */
    let quanhou_jiage: String /* 券后价格 */
    let date_time_yongjin: String /* 数据更新时间 */
    let tkrate3: String /* 佣金比例 */
    let yongjin_type: String /* 佣金类型 */
    let coupon_id: String /* 优惠券ID */
    let coupon_start_time: String /* 优惠券开始时间 */
    let coupon_end_time: String /* 优惠券结束时间 */
    let coupon_info_money: String /* 优惠券金额 */
    let coupon_total_count: String /* 优惠券总量 */
    let coupon_remain_count: String /* 优惠券剩余数量 */
    let coupon_info: String /* 优惠券信息 */
    let juhuasuan: String /* 是否为 聚划算 */
    let taoqianggou: String /* 是否为 淘抢购 */
    let haitao: String /* 是否为 海淘 */
    let jiyoujia: String /* 是否极有家 */
    let jinpaimaijia: String /* 是否为 金牌卖家 */
    let pinpai: String /* 是否为 品牌 */
    let pinpai_name: String /* 品牌名称 */
    let yunfeixian: String /* ??? */
    let nick: String /* 店铺名称 */
    let small_images: String /* 商品组图/商品小图列表 */
    let white_image: String /* 商品白底图 */
    let tao_title: String /* 商品长标题 */
    let provcity: String /* 省份 城市 */
    let shop_title: String /* 商家名称 */
    let zhibo_url: String /* 直播地址 */
    let sellCount: String /* 销售数量 */
    let commentCount: String /* 评论数量 */
    let favcount: String /* 喜欢数量 */
    let score1: String /* 宝贝描述分 */
    let score2: String /* 卖家服务分 */
    let score3: String /* 物流服务分 */
    let creditLevel: String /* 店铺等级 */
    let shopIcon: String /* 商家图标 URL */
    let pcDescContent: String /* 内容 url */
    let item_url: String /* 商品地址 */
    let category_id: String /* 分类 id */
    let category_name: String /* 分类名称 */
    let level_one_category_id: String /* ??? */
    let level_one_category_name: String /* ??? */
    let tkfee3: String /* ??? */
    let biaoqian: String /* 店铺活动 */
    let tag: String /* 朋友圈文案 */
    let presale_discount_fee_text: String? /* 预售商品-商品优惠信息 */
    let presale_tail_end_time: String? /* 预售商品-付定金结束时间（毫秒） */
    let presale_tail_start_time: String? /* 预售商品-付尾款开始时间（毫秒） */
    let presale_end_time: String? /* 预售结束时间 */
    let presale_start_time: String? /* 预售开始时间 */
    let presale_deposit: String? /* 预售 ??? */
}


struct ApiDtUserAuthResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: ApiDtUserNativeAuthDataModel? /* 详细数据 */
}


struct ApiDtUserCancelResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: Bool? /* 是否已经注销 */
}


struct ApiDtUserNativeAuthDataModel: Codable {
    let token: String /* 认证令牌(TOKEN) */
}


struct ApiDtUserNativeAuthForm: Codable {
    let username: String /* 账号 */
    let password: String /* 密码 */
}


struct ApiDtUserProfileDataModel: Codable {
    let mobile: String? /* 手机号码 */
    let tao_id: String? /* 用户绑定的淘宝ID */
    let wx: String? /* 微信 */
    let relation_id: String? /* 淘宝渠道ID */
    let ali_name: String? /* 支付宝姓名 */
    let ali_account: String? /* 支付宝账号 */
}


struct ApiDtUserProfileResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: ApiDtUserProfileDataModel? /* 详细数据 */
}


struct ApiDtUserTbResponseModel: Codable {
    let errno: ApiDtAppErrno /* 错误码 */
    let errmsg: String /* 错误信息 */
    let data: Bool? /* 是否绑定了淘宝 */
}


struct ApiDtUserTokenForm: Codable {
    let token: String /* 认证令牌 */
}


struct ApiDtValidationError: Codable {
    let loc: [String] /* Location */
    let msg: String /* Message */
    let type: String /* Error Type */
}


