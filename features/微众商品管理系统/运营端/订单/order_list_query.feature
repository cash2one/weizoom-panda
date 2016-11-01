#_author_:张三香 2016.11.01

Feature:运营端订单列表的查询
	"""
		1.查询条件：
			客户名称:支持模糊查询
			商品名称:支持模糊查询
			订单号:精确查询
			下单时间
			来源商城:下拉框显示所有自营平台的平台名称，默认显示全部
			订单状态:下拉框显示，包括全部、待发货、已发货、已完成、退款中、退款完成、已取消
	"""

Background:
	Given manager登录商品管理系统
	When manager添加账号
		"""
		{
			"type":"运营",
			"account_name":"运营账号1",
			"login_name":"yunying",
			"login_password":"test",
			"remark":"账号备注信息"
		}
		"""
	Given yunying登录商品管理系统
	When yunying添加商品分类
		"""
		{
			"食品":
			[{
				"name":"饼干"
			},{
				"name":"泡面"
			}]
		}
		"""
	Given manager登录商品管理系统
	#添加'固定底价'类型客户
		When manager添加账号
			"""
			{
				"type":"合作客户",
				"business_name":"北京大公司1",
				"shop_name":"固定底价店铺",
				"purchase_way":"固定底价",
				"payment_type":"自然月",
				"product_category":["食品"],
				"products_limit":300,
				"contact_name":"",
				"mobile":"",
				"start_time":"2016-10-10 10:00",
				"end_time":"2026-10-10 10:00",
				"login_name":"gddj",
				"login_password":"test",
				"remark":"固定底价客户备注信息"
			}
			"""
	#添加'零售价返点'类型客户
		When manager添加账号
			"""
			{
				"type":"合作客户",
				"business_name":"北京大公司2",
				"shop_name":"零售价返点店铺",
				"purchase_way":"零售价返点",
				"points":"20",
				"payment_type":"15天",
				"product_category":["食品"],
				"products_limit":30,
				"contact_name":"张小小",
				"mobile":"13511223344",
				"start_time":"2016-10-11 10:00",
				"end_time":"2026-10-10 11:00",
				"login_name":"lsjfd",
				"login_password":"test",
				"remark":"零售价返点客户备注信息"
			}
			"""
	#固定底价客户添加商品
		Given gddj登录商品管理系统
		When ggdj添加运费模板
			"""
			{
				"name":"运费模板1",
				"first_weight":1.0,
				"first_weight_price": 1.00,
				"added_weight":1.0,
				"added_weight_price": 1.00
			}
			"""
		When gddj添加商品规格
			"""
			{
				"name": "颜色",
				"type": "图片",
				"values": [{
					"name": "黑色",
					"image": "/standard_static/test_resource_img/hangzhou1.jpg"
				},{
					"name": "白色",
					"image": ""
				}]
			}
			"""
		When gddj添加商品规格
			"""
			{
				"name": "尺寸",
				"type": "文本",
				"values": [{
					"name": "M",
					"image":""
				},{
					"name": "S",
					"image": "/standard_static/test_resource_img/hangzhou2.jpg"
				}]
			}
			"""
		When gddj添加商品
			"""
			{
				"product_category":"食品-饼干",
				"name":"固定商品1",
				"promotion_title":"促销标题1",
				"is_enable_model":false,
				"purchase_price": 10.00,
				"weight": 1,
				"stocks": 100,
				"limit_zone_type":"无限制",
				"postage":1.00,
				"image":["love.png"],
				"detail": "商品1描述信息"
			}
			"""
		When gddj添加商品
			"""
			{
				"product_category":"食品-泡面",
				"name":"固定商品2",
				"promotion_title":"促销标题2",
				"is_enable_model":true,
				"model": {
					"models": {
						"黑色 S": {
							"purchase_price": 21.00,
							"weight":1.0,
							"stocks":100
						},
						"白色 S": {
							"purchase_price": 22.00,
							"weight": 2.0,
							"stocks":200
						}
					}
				},
				"limit_zone_type":"无限制",
				"postage":"运费模板1",
				"image":["love.png"],
				"detail": "商品2描述信息"
			}
			"""
	#零售价返点客户添加商品
		Given lsjfd登录商品管理系统
		When lsjfd添加运费模板
			"""
			{
				"name": "运费模板2",
				"first_weight": 1.0,
				"first_weight_price": 1.00,
				"added_weight": 1.0,
				"added_weight_price": 1.00,
				"special_area": [{
					"to_the": ["北京市"],
					"first_weight": 1.0,
					"first_weight_price": 2.00,
					"added_weight": 1.0,
					"added_weight_price": 2.00
					}],
				"free_postages": [{
					"to_the": ["上海市"],
					"condition":"count",
					"value": 1
				},{
					"to_the": ["北京市","重庆市","江苏省"],
					"condition":"money",
					"value": 20.0
				}]
			}
			"""
		When lsjfd添加商品规格
			"""
			{
				"name": "颜色",
				"type": "图片",
				"values": [{
					"name": "黑色",
					"image": "/standard_static/test_resource_img/hangzhou1.jpg"
				},{
					"name": "白色",
					"image": ""
				}]
			}
			"""
		When lsjfd添加商品
			"""
			{
				"product_category":"食品-饼干",
				"name":"零售商品1",
				"promotion_title":"促销标题1",
				"is_enable_model":false,
				"price": 10.00,
				"weight": 1,
				"stocks": 100,
				"limit_zone_type":"无限制",
				"postage":1.00,
				"image":["love.png"],
				"detail": "商品1描述信息"
			}
			"""
		When lsjfd添加商品
			"""
			{
				"product_category":"食品-泡面",
				"name":"零售商品2",
				"promotion_title":"促销标题2",
				"is_enable_model":true,
				"model": {
					"models": {
						"黑色": {
							"price":21.00,
							"weight":1.0,
							"stocks":100
						},
						"白色": {
							"price": 22.00,
							"weight":2.0,
							"stocks":200
						}
					}
				},
				"limit_zone_type":"无限制",
				"postage":"运费模板2",
				"image":["love.png"],
				"detail": "商品2描述信息"
			}
			"""
	Given 添加自营平台账号
		"""
		[{
			"account":"zy1",
			"self_shop_name":"自营平台1"
		},{
			"account":"zy2",
			"self_shop_name":"自营平台2"
		}]
		"""
	Given yunying登录商品管理系统
	When yunying同步商品到自营平台
		"""
		{
			"products":["固定商品1","固定商品2"],
			"platforms":["自营平台1","自营平台2"]
		}
		"""
	When yunying同步商品到自营平台
		"""
		{
			"products":["零售商品1","零售商品2"],
			"platforms":["自营平台1"]
		}
		"""
	Given zy1登录系统
	When zy1添加支付方式
		"""
		{
			"type": "微信支付",
			"is_active": "启用"
		}
		"""
	When zy1批量上架商品池商品
		"""
		["固定商品1","固定商品1","零售商品1","零售商品2"]
		"""
	Given zy2登录系统
	When zy2添加支付方式
		"""
		{
			"type": "微信支付",
			"is_active": "启用"
		}
		"""
	When zy2批量上架商品池商品
		"""
		["固定商品1","固定商品1"]
		"""
	Given bill关注zy1的公众号
	Given bill关注zy2的公众号
	#001(zy1)-单个商家的单个商品-待支付（固定商品1,1）
		When bill访问zy1的webapp::apiserver
		When bill购买zy1的商品::apiserver
			"""
			{
				"order_id":"001",
				"date":"2016-10-11",
				"ship_name": "bill",
				"ship_tel": "13811223344",
				"ship_area": "北京市 北京市 海淀区",
				"ship_address": "泰兴大厦",
				"pay_type": "微信支付",
				"products":[{
					"name":"固定商品1",
					"price":10.00,
					"count":1
				}],
				"postage": 1.00,
				"customer_message": "bill的订单备注1"
			}
			"""
	#002(zy2)-单个商家的多个商品-待支付（固定商品1,1+固定商品2,2）
		When bill访问zy2的webapp::apiserver
		When bill购买zy1的商品::apiserver
			"""
			{
				"order_id":"002",
				"date":"2016-10-12",
				"ship_name": "bill",
				"ship_tel": "13811223344",
				"ship_area": "北京市 北京市 海淀区",
				"ship_address": "泰兴大厦",
				"pay_type": "微信支付",
				"products":[{
					"name":"固定商品1",
					"price":10.00,
					"count":1
				},{
					"name":"固定商品2",
					"model":"黑色 S",
					"price":21.00,
					"count":2
				}],
				"postage":3.00,
				"customer_message": "bill的订单备注2"
			}
			"""
	#003(zy1)-多个商家多个商品-待支付（固定商品1,1+零售商品1,1）
		When bill访问zy1的webapp::apiserver
		When bill购买zy1的商品::apiserver
			"""
			{
				"order_id":"003",
				"date":"2016-10-13",
				"ship_name": "bill",
				"ship_tel": "13811223344",
				"ship_area": "北京市 北京市 海淀区",
				"ship_address": "泰兴大厦",
				"pay_type": "微信支付",
				"products":[{
					"name":"固定商品1",
					"price":10.00,
					"count":1
				},{
					"name":"零售商品1",
					"price":10.00,
					"count":1
				}],
				"postage":2.00,
				"customer_message": "bill的订单备注3"
			}
			"""
	#004(zy2)-单个商家多个商品-待发货（固定商品1,1）
		When bill访问zy2的webapp::apiserver
		When bill购买zy2的商品::apiserver
			"""
			{
				"order_id":"004",
				"date":"2016-10-14",
				"ship_name": "bill",
				"ship_tel": "13811223344",
				"ship_area": "北京市 北京市 海淀区",
				"ship_address": "泰兴大厦",
				"pay_type": "微信支付",
				"products":[{
					"name":"固定商品1",
					"price":10.00,
					"count":1
				}],
				"postage":2.00,
				"customer_message": "bill的订单备注3"
			}
			"""
		And bill使用支付方式'微信支付'进行支付::apiserver
	#005(zy1)-多个商家多个商品-待发货（固定商品1,1+零售商品1,1+零售商品2,1）
		When bill访问zy1的webapp::apiserver
		When bill购买zy1的商品::apiserver
			"""
			{
				"order_id":"005",
				"date":"2016-10-15",
				"ship_name": "bill",
				"ship_tel": "13811223344",
				"ship_area": "北京市 北京市 海淀区",
				"ship_address": "泰兴大厦",
				"pay_type": "微信支付",
				"products":[{
					"name":"固定商品1",
					"price":10.00,
					"count":1
				},{
					"name":"零售商品1",
					"price":10.00,
					"count":1
				},{
					"name":"零售商品2",
					"model":"黑色",
					"price":21.00,
					"count":1
				}],
				"postage":4.00,
				"customer_message": "bill的订单备注3"
			}
			"""
		And bill使用支付方式'微信支付'进行支付::apiserver

Scenario:1 运营端订单列表默认查询
	Given yunying登录商品管理系统
	When yunying设置订单列表查询条件
		"""
		{
			"shop_name":"",
			"product_name":"",
			"order_id":"",
			"order_time_start":"",
			"order_time_end":"",
			"source":"",
			"order_status":"全部"
		}
		"""
	Then yunying获得订单列表
		"""
		[{
			"order_id":"005-固定底价店铺",
			"products":[{
				"name":"固定商品1",
				"count":1
			}],
			"order_money":10.00,
			"postage":1.00,
			"order_status":"待发货",
			"shop_name":"固定底价店铺",
			"source":"自营平台1"
		},{
			"order_id":"005-零售价返点店铺",
			"products":[{
				"name":"零售商品1",
				"count":1
			},{
				"name":"零售商品2",
				"model":"黑色"
				"count":1
			}],
			"order_money":31.00,
			"postage":3.00,
			"order_status":"待发货",
			"shop_name":"零售价返点店铺",
			"source":"自营平台1"
		},{
			"order_id":"004-固定底价店铺",
			"products":[{
				"name":"固定商品1",
				"count":1
			}],
			"order_money":10.00,
			"postage":1.00,
			"order_status":"待发货",
			"shop_name":"固定底价店铺",
			"source":"自营平台2"
		},{
			"order_id":"003-固定底价店铺",
			"products":[{
				"name":"固定商品1",
				"count":1
			}],
			"order_money":10.00,
			"postage":1.00,
			"order_status":"待支付",
			"shop_name":"固定底价店铺",
			"source":"自营平台1"
		},{
			"order_id":"003-零售价返点店铺",
			"products":[{
				"name":"零售商品1",
				"count":1
			}],
			"order_money":10.00,
			"postage":1.00,
			"order_status":"待支付",
			"shop_name":"零售价返点店铺",
			"source":"自营平台1"
		},{
			"order_id":"002-固定底价店铺",
			"products":[{
				"name":"固定商品1",
				"count":1
			},{
				"name":"固定商品2",
				"model":"黑色 S",
				"count":2
			}],
			"order_money":31.00,
			"postage":3.00,
			"order_status":"待支付",
			"shop_name":"固定底价店铺",
			"source":"自营平台2"
		},{
			"order_id":"001-固定底价店铺",
			"products":[{
				"name":"固定商品1",
				"count":1
			}],
			"order_money":10.00,
			"postage":1.00,
			"order_status":"待支付",
			"shop_name":"固定底价店铺",
			"source":"自营平台1"
		}]
		"""

Scenario:2 运营端订单列表按'客户名称'查询
	Given yunying登录商品管理系统
	#模糊查询
	When yunying设置订单列表查询条件
		"""
		{
			"shop_name":"固定底价"
		}
		"""
	Then yunying获得订单列表
		"""
		[{
			"order_id":"005-固定底价店铺",
			"shop_name":"固定底价店铺"
		},{
			"order_id":"004-固定底价店铺",
			"shop_name":"固定底价店铺"
		},{
			"order_id":"003-固定底价店铺",
			"shop_name":"固定底价店铺"
		},{
			"order_id":"002-固定底价店铺",
			"shop_name":"固定底价店铺"
		},{
			"order_id":"001-固定底价店铺",
			"shop_name":"固定底价店铺"
		}]
		"""
	#精确查询
	When yunying设置订单列表查询条件
		"""
		{
			"shop_name":"零售价返点店铺"
		}
		"""
	Then yunying获得订单列表
		"""
		[{
			"order_id":"005-零售价返点店铺",
			"shop_name":"零售价返点店铺"
		},{
			"order_id":"003-零售价返点店铺",
			"shop_name":"零售价返点店铺"
		}]
		"""
	#查询结果为空
	When yunying设置订单列表查询条件
		"""
		{
			"shop_name":"其他"
		}
		"""
	Then yunying获得订单列表
		"""
		[]
		"""

Scenario:3 运营端订单列表按'商品名称'查询
	Given yunying登录商品管理系统
	#模糊查询
	When yunying设置订单列表查询条件
		"""
		{
			"product_name":"零售商品"
		}
		"""
	Then yunying获得订单列表
		"""
		[{
			"order_id":"005-零售价返点店铺",
			"products":[{
				"name":"零售商品1"
			},{
				"name":"零售商品2"
			}]
		},{
			"order_id":"003-零售价返点店铺",
			"products":[{
				"name":"零售商品1"
			}]
		}]
		"""
	#精确查询
	When yunying设置订单列表查询条件
		"""
		{
			"product_name":"零售商品2"
		}
		"""
	Then yunying获得订单列表
		"""
		[{
			"order_id":"005-零售价返点店铺",
			"products":[{
				"name":"零售商品1"
			},{
				"name":"零售商品2",
				"model":"黑色"
			}]
		}]
		"""
	#查询结果为空
	When yunying设置订单列表查询条件
		"""
		{
			"product_name":"零售 商品"
		}
		"""
	Then yunying获得订单列表
		"""
		[]
		"""

Scenario:4 运营端订单列表按'订单号'查询
	Given yunying登录商品管理系统
	#精确查询
	When yunying设置订单列表查询条件
		"""
		{
			"order_id":"005-固定底价店铺"
		}
		"""
	Then yunying获得订单列表
		"""
		[{
			"order_id":"005-固定底价店铺"
		}]
		"""
	#查询结果为空
	When yunying设置订单列表查询条件
		"""
		{
			"order_id":"1212"
		}
		"""
	Then yunying获得订单列表
		"""
		[]
		"""

Scenario:5 运营端订单列表按'下单时间'查询
	Given yunying登录商品管理系统
	#开始时间等于结束时间
	When yunying设置订单列表查询条件
		"""
		{
			"order_time_start":"2016-01-01 00:00",
			"order_time_end":"2016-01-01 00:00"
		}
		"""
	Then yunying获得订单列表
		"""
		[]
		"""
	#开始时间小于结束时间
	When yunying设置订单列表查询条件
		"""
		{
			"order_time_start":"2016-10-14 00:00",
			"order_time_end":"2016-10-16 00:00"
		}
		"""
	Then yunying获得订单列表
		"""
		[{
			"order_id":"005-固定底价店铺"
		},{
			"order_id":"005-零售价返点店铺"
		},{
			"order_id":"004-固定底价店铺"
		}]
		"""
	#开始时间大于结束时间（系统没有做控制）
	When yunying设置订单列表查询条件
		"""
		{
			"order_time_start":"2016-10-16 00:00",
			"order_time_end":"2016-10-14 00:00"
		}
		"""
	Then yunying获得订单列表
		"""
		[]
		"""

Scenario:6 运营端订单列表按'来源商城'查询
	Given yunying登录商品管理系统
	#'自营平台1'查询
	When yunying设置订单列表查询条件
		"""
		{
			"source":"自营平台1"
		}
		"""
	Then yunying获得订单列表
		"""
		[{
			"order_id":"005-固定底价店铺",
			"source":"自营平台1"
		},{
			"order_id":"005-零售价返点店铺",
			"source":"自营平台1"
		},{
			"order_id":"003-固定底价店铺",
			"source":"自营平台1"
		},{
			"order_id":"003-零售价返点店铺",
			"source":"自营平台1"
		},{
			"order_id":"001-固定底价店铺",
			"source":"自营平台1"
		}]
		"""

Scenario:7 运营端订单列表按'订单状态'查询
	Given yunying登录商品管理系统
	#'待发货'状态查询
	When yunying设置订单列表查询条件
		"""
		{
			"order_status":"待发货"
		}
		"""
	Then yunying获得订单列表
		"""
		[{
			"order_id":"005-固定底价店铺",
			"order_status":"待发货"
		},{
			"order_id":"005-零售价返点店铺",
			"order_status":"待发货"
		},{
			"order_id":"004-固定底价店铺",
			"order_status":"待发货"
		}]
		"""

Scenario:8 运营端订单列表组合查询
	Given yunying登录商品管理系统
	#查询结果非空
	When yunying设置订单列表查询条件
		"""
		{
			"shop_name":"固定底价",
			"product_name":"固定商品1",
			"order_id":"005-固定底价店铺",
			"order_time_start":"2016-10-01 00:00",
			"order_time_end":"2016-10-16 00:00",
			"source":"自营平台1",
			"order_status":"待发货"
		}
		"""
	Then yunying获得订单列表
		"""
		[{
			"order_id":"005-固定底价店铺",
			"products":[{
				"name":"固定商品1",
				"count":1
			}],
			"order_money":10.00,
			"postage":1.00,
			"order_status":"待发货",
			"shop_name":"固定底价店铺",
			"source":"自营平台1"
		}]
		"""
	#查询结果为空
	When yunying设置订单列表查询条件
		"""
		{
			"shop_name":"零售价",
			"product_name":"固定商品1",
			"order_id":"005-固定底价店铺",
			"order_time_start":"2016-10-01 00:00",
			"order_time_end":"2016-10-16 00:00",
			"source":"自营平台2",
			"order_status":"待发货"
		}
		"""
	Then yunying获得订单列表
		"""
		[]
		"""