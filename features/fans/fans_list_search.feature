#author:徐梓豪 2016-07-05
Feature:用户根据条件过滤订单
"""
1.用户根据日期过滤粉丝列表
2.用户根据状态过滤粉丝列表
"""

Background
	Given manager登录管理系统
	When manager添加账号
		"""
		{
		"account_type":"体验客户",
		"account_name":"土小宝",
		"login_account":"tuxiaobao",
		"password":123456,
		"ramarks":"土小宝客户体验账号"
		}
		"""

		"""
	When tuxiaobao使用密码123456登录管理系统
	When tuxiaobao添加商品
		"""
		[{
		"name":"武汉鸭脖",
		"title"："周黑鸭 鲜卤鸭脖 230g/袋 办公室休闲零食 肉干小食",
		"price":10.00,
		"setlement_price":10.00,
		"weight":0.23,
		"repertory":{
					"is_limit":"on",
					"limit_num":500.00
		},
		"picture":"",
		"description":"周黑鸭 鲜卤鸭脖 230g/袋 办公室休闲零食 肉干小食"
		},{
		"name":"NIKE耐克男鞋便减震舒适休闲跑步鞋",
		"title"："旗舰店—618粉丝狂欢， 赢200元粉丝券!",
		"price":322.00,
		"setlement_price":298.00,
		"weight":0.50,
		"repertory":{
					"is_limit":"off"
		},
		"description":"旗舰店—618粉丝狂欢，关注微信公众号"jdxyyz" 赢200元粉丝券!"
		}]
		"""

	When 微信用户下订单
		|	order_id	  | date       | consumer |    type   |businessman|   product | payment  | payment_method | freight |   price  | product_integral |  	 coupon  		| paid_amount | 		weizoom_card 		| alipay | wechat | cash |      action       |  order_status   |
		|       001       | 2016-07-07 | bill     |    购买   | 微众商城   | 武汉鸭脖  | 支付    | 支付宝         | 10      | 10.00    | 		          |                		|           10.00       |              				  | 10.00  | 0      | 0    |    jobs,支付      |  待发货         |
		|       002       | 2016-07-07 | tom      |    购买   | 微众家     | 耐克男鞋  | 支付    | 支付宝         | 15      | 20.00    | 200              |        				|           10.00       |              				  | 10.00  | 0      | 0    |    jobs,支付      |  待发货         |
		|       003       | 2016-07-05 | tom      |    购买   | 微众家     | 耐克男鞋  | 支付    | 支付宝         | 15      | 20.00    | 200              |        				|           10.00       |              				  | 10.00  | 0      | 0    |    jobs,支付      |  待发货         |		
		|       004       | 2016-07-04 | try      |    购买   | 微众家     | 武汉鸭脖  | 支付    | 支付宝         | 15      | 20.00    | 200              |        				|           10.00       |              				  | 10.00  | 0      | 0    |    jobs,支付      |  待发货         |

	Then 系统根据算法自动向客户投放粉丝
	Then tuxiaobao查看粉丝列表
		|     time    |     fans     | sex |local_place|buy_point|recommend_point|    statute    |
		| 2016-07-06  | ID:2016070501|  男 | 山东 济南 |   7.80  |     5.50      | 已妥投,未阅读 |
		| 2016-07-06  | ID:2016070502|  男 | 江苏 南京 |   8.40  |     4.50      | 已阅读,已分享 |
		| 2016-07-06  | ID:2016070503|  男 | 湖北 武汉 |   8.30  |     4.60      |     已下单    |
		| 2016-07-06  | ID:2016070504|  女 | 上海 浦东 |   6.80  |     8.60      | 已阅读,未分享 |
		| 2016-07-06  | ID:2016070505|  男 | 广西 厦门 |   6.30  |     8.70      |     已下单    |
		| 2016-07-06  | ID:2016070506|  男 | 广东 广州 |   5.70  |     6.90      | 已阅读,未分享 |
		| 2016-07-07  | ID:2016070507|  女 | 广东 宝鸡 |   5.30  |     2.10      | 已阅读,未分享 |
		| 2016-07-07  | ID:2016070508|  男 | 江苏 苏州 |   5.10  |     4.10      | 已阅读,已分享 |
		| 2016-07-07  | ID:2016070509|  男 | 浙江 杭州 |   6.90  |     3.40      | 已妥投,未阅读 |
		| 2016-07-07  | ID:2016070510|  男 | 江苏 无锡 |   7.80  |     5.50      |     已下单    |
		| 2016-07-04  | ID:2016070511|  女 | 浙江 绍兴 |   5.90  |     9.90      | 已阅读,未分享 |
		| 2016-07-04  | ID:2016070512|  男 | 浙江 温州 |   6.40  |     1.90      | 已阅读,已分享 |
		| 2016-07-04  | ID:2016070513|  男 | 广西 南昌 |   3.20  |     7.70      | 已妥投,未阅读 |
		| 2016-07-04  | ID:2016070514|  女 | 四川 成都 |   8.90  |     7.50      | 已阅读,已分享 |
		| 2016-07-04  | ID:2016070515|  男 | 四川 自贡 |   9.80  |     4.30      | 已阅读,已分享 |
		| 2016-07-03  | ID:2016070516|  男 | 四川 乐山 |   9.80  |     5.80      | 已妥投,未阅读 |
		| 2016-07-03  | ID:2016070517|  女 | 山东 济南 |   7.90  |     8.70      |     已下单    |
		| 2016-07-03  | ID:2016070518|  女 | 甘肃 兰州 |   6.70  |     3.20      | 已阅读,已分享 |
		| 2016-07-03  | ID:2016070519|  女 | 广西 桂林 |   1.60  |     2.40      | 已阅读,未分享 |
		| 2016-07-03  | ID:2016070520|  男 | 甘肃 天水 |   6.90  |     4.50      | 已阅读,已分享 |

@penda @fans
Scenario:1 用户使用时间来过滤粉丝列表
	When tuxiaobao登录系统:penda
	Then tuxiaobao查看在'2016-07-04 00:00'至'2016-07-06 00:00'之间投放的粉丝
	And tuxiaobao查看粉丝列表
		|     time    |     fans     | sex |local_place|buy_point|recommend_point|    statute    |
		| 2016-07-04  | ID:2016070511|  女 | 浙江 绍兴 |   5.90  |     9.90      | 已阅读,未分享 |
		| 2016-07-04  | ID:2016070512|  男 | 浙江 温州 |   6.40  |     1.90      | 已阅读,已分享 |
		| 2016-07-04  | ID:2016070513|  男 | 广西 南昌 |   3.20  |     7.70      | 已妥投,未阅读 |
		| 2016-07-04  | ID:2016070514|  女 | 四川 成都 |   8.90  |     7.50      | 已阅读,已分享 |
		| 2016-07-04  | ID:2016070515|  男 | 四川 自贡 |   9.80  |     4.30      | 已阅读,已分享 |

	Then tuxiaobao查看在'2016-07-05 00:00'至'2016-07-06 00:00'之间投放的粉丝
	And tuxiaobao查看订单列表
		|     time    |     fans     | sex |local_place|buy_point|recommend_point|    statute    |

@penda @fans
Scenario:2 用户使用状态来过滤粉丝列表
	When tuxiaobao登录系统:penda
	Then tuxiaobao查看状态为'已下单'的粉丝
		|     time    |     fans     | sex |local_place|buy_point|recommend_point|    statute    |
		| 2016-07-06  | ID:2016070503|  男 | 湖北 武汉 |   8.30  |     4.60      |     已下单    |
		| 2016-07-06  | ID:2016070505|  男 | 广西 厦门 |   6.30  |     8.70      |     已下单    |
		| 2016-07-07  | ID:2016070510|  男 | 江苏 无锡 |   7.80  |     5.50      |     已下单    |
		| 2016-07-03  | ID:2016070517|  女 | 山东 济南 |   7.90  |     8.70      |     已下单    |
	Then tuxiaobao查看状态为'已阅读,已分享'的粉丝
		|     time    |     fans     | sex |local_place|buy_point|recommend_point|    statute    |
		| 2016-07-06  | ID:2016070502|  男 | 江苏 南京 |   8.40  |     4.50      | 已阅读,已分享 |
		| 2016-07-06  | ID:2016070506|  男 | 广东 广州 |   5.70  |     6.90      | 已阅读,未分享 |
		| 2016-07-07  | ID:2016070507|  女 | 广东 宝鸡 |   5.30  |     2.10      | 已阅读,未分享 |
		| 2016-07-07  | ID:2016070508|  男 | 江苏 苏州 |   5.10  |     4.10      | 已阅读,已分享 |
		| 2016-07-04  | ID:2016070512|  男 | 浙江 温州 |   6.40  |     1.90      | 已阅读,已分享 |
		| 2016-07-04  | ID:2016070514|  女 | 四川 成都 |   8.90  |     7.50      | 已阅读,已分享 |
		| 2016-07-04  | ID:2016070515|  男 | 四川 自贡 |   9.80  |     4.30      | 已阅读,已分享 |
		| 2016-07-03  | ID:2016070518|  女 | 甘肃 兰州 |   6.70  |     3.20      | 已阅读,已分享 |
		| 2016-07-03  | ID:2016070520|  男 | 甘肃 天水 |   6.90  |     4.50      | 已阅读,已分享 |
		
