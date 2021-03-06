#author: 徐梓豪 2016-07-14

Feature:商品列表导出商品
"""
	1.商品列表导出商品

"""
Background:
	Given manager登录管理系统
	When manager添加账号
	"""
		[{
			"account_type":"体验客户",
			"company_name":"爱昵咖啡有限责任公司",
			"shop_name":"爱昵咖啡",
			"manage_type":"休闲食品",
			"purchase_type":"固定底价",
			"connect_man":"aini",
			"mobile_number":"13813985506",
			"login_account":"aini",
			"password":"123456",
			"valid_time":"2016-07-15"至"2017-07-15",
			"ramarks":"爱昵咖啡客户体验账号"
			},{
			"account_type":"运营",
			"account_name":"运营部门",
			"login_account":"yunying",
			"password":123456,
			"ramarks":"运营部门"
		}]
	Given yunying登录管理系统
	When yunying添加类目
	"""
	{
		head_classify":"无",
		"classify_name":"生活用品",
		"comments":"1"
		},{
		"head_classify":"生活用品",
		"classify_name":"零食",
		"comments":"国产"
		},{
		head_classify":"无",
		"classify_name":"居家",
		"comments":""
		},{
		head_classify":"居家",
		"classify_name":"鞋子",
		"comments":""
		}
	}
	"""

	When aini使用密码123456登录系统
	When aini添加商品
	"""
		[{
			"first_classify":"生活用品",
			"second_classify":"零食",
			"name": "武汉鸭脖",
			"promotion_name":"武汉鸭脖",
			"price": 10.00,
			"weight": 1.00,
			"stock_number": "5000",
			"settlement_price":10.00,
			"introduction": "这是一种很好吃的鸭脖"
			"standard_promotion":"是",
			"standard":{
						"standard_name":"颜色",
						"standard":"黑色","红色"
						},{
						"standard_name":"尺码",
						"standard":"X,XL"
						}
			"standard_price":{
						|standard_1|standard_2|purchase_price|timelimit_price|sale_price|weight|stock_number|product_id|
						|   黑色   |     X    |     14.90    |      14.90    |   29.00  | 0.50 |   2500.00  |    001   |
						|   黑色   |    XL    |     14.90    |      14.90    |   29.00  | 0.50 |   2000.00  |    002   |    
						|   红色   |     X    |     14.90    |      14.90    |   29.00  | 0.50 |   1000.00  |    003   |
						|   红色   |    XL    |     14.90    |      14.90    |   29.00  | 0.50 |   1300.00  |    004   | 
						},{
			"first_classify":"居家",
			"second_classify":"鞋子",			
			"name": "耐克男鞋",
			"promotion_name":"耐克男鞋",
			"price": 198.00,
			"weight": 1.00,
			"stock_number": "5000",
			"settlement_price":200.00,
			"introduction": "耐克男鞋"
			"standard_promotion":"是",
			"standard":{
						"standard_name":"颜色",
						"standard":"黑色","红色"
						},{
						"standard_name":"尺码",
						"standard":"X,XL"
						}
			"standard_price":{
						|standard_1|standard_2|purchase_price|timelimit_price|sale_price|weight|stock_number|product_id|
						|   黑色   |     X    |     14.90    |      14.90    |   29.00  | 0.50 |   2500.00  |    001   |
						|   黑色   |    XL    |     14.90    |      14.90    |   29.00  | 0.50 |   2000.00  |    002   |    
						|   红色   |     X    |     14.90    |      14.90    |   29.00  | 0.50 |   1000.00  |    003   |
						|   红色   |    XL    |     14.90    |      14.90    |   29.00  | 0.50 |   1300.00  |    004   | 
						
		}]
	"""


	Then aini能获得商品列表
	|  name   | set_price |sale_price| sales |   creat_time   | status |
	|武汉鸭脖 |   10.00   |   14.90  | 0.00  |2016-07-25 16:30| 未上架 |
	|耐克男鞋 |   10.00   |   14.90  | 0.00  |2016-07-25 16:30| 未上架 |
@penda @hj
scenario:1 商品列表导出商品
	When aini登录系统
	When aini导出商品列表
	|  name   | price | sales |   creat_time   | status |
	|武汉鸭脖 | 10.00 | 0.00  |2016-07-25 16:30| 未上架 |
	|耐克男鞋 | 198.00| 0.00  |2016-07-25 16:30| 未上架 |