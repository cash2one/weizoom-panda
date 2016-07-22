#author: 徐梓豪 2016-07-14

Feature:商品列表导出商品
"""
	1.商品列表导出商品

"""
Background:
	Given jobs登录管理系统
	When jobs添加账号
	"""
		[{
			"account_type":"合作客户",
			"account_name":"爱昵咖啡",
			"login_account":"aini",
			"password":"123456"
		}]

	When aini使用密码123456登录系统
	When aini添加商品
	"""
		[{
			"name": "商品1",
			"promotion_name":"促销的商品1",
			"price": 12.00,
			"weight": 1.00,
			"stock_type": "无限",
			"settlement_price":10.00,
			"introduction": "商品1的简介"
		},{
			"name": "商品2",
			"promotion_name":"促销的商品2",
			"settlement_price":10.00,
			"introduction": "商品2的简介",
			"price": 12.00,
			"weight": 1.00,
			"stock_type": "无限",
			"settlement_price":10.00,
			"introduction": "商品2的简介"

		},{
			"name": "商品3",
			"promotion_name":"促销的商品3",
			"price": 12.00,
			"weight": 1.00,
			"stock_type": "无限",
			"settlement_price":10.00,
			"introduction": "商品3的简介"
		}]
	"""


	Then aini能获得商品列表
	"""
		[{
			"name": "商品3",
			"price": "12.00",
			"sales":"0",
			"status":"未上架",
			"actions":["编辑","彻底删除"]
		},{
			"name": "商品2",
			"price": "12.00",
			"sales":"0",
			"status":"未上架",
			"actions":["编辑","彻底删除"]
		},{
			"name": "商品1",
			"price": "12.00",
			"sales":"0",
			"status":"未上架",
			"actions":["编辑","删除"]
		}]
	"""
@penda @hj
	When aini登录系统
	When aini导出商品列表
	"""
		[{
			"name": "商品3",
			"price": "12.00",
			"sales":"0",
			"status":"未上架",
			"actions":["编辑","彻底删除"]
		},{
			"name": "商品2",
			"price": "12.00",
			"sales":"0",
			"status":"未上架",
			"actions":["编辑","彻底删除"]
		},{
			"name": "商品1",
			"price": "12.00",
			"sales":"0",
			"status":"未上架",
			"actions":["编辑","彻底删除"]
		}]
	"""