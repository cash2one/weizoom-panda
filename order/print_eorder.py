# -*- coding: utf-8 -*-
import json

from django.template import RequestContext
from django.shortcuts import render_to_response
from django.contrib.auth.decorators import login_required

from core import resource
from core.jsonresponse import create_response

from product import models as product_models
from account import models as account_models
from postage_config import models as postage_models
from util import sync_util
import nav
import models
from order.customer_order_detail import getOrderDetail
from order.kdniao_express_eorder import KdniaoExpressEorder

class PrintEorder(resource.Resource):
	app = 'order'
	resource = 'print_eorder'

	@login_required
	def api_get(request):

		express_id = request.GET.get('express_id','')
		order_ids = request.GET.get('order_ids','')
		shipper_messages = postage_models.ShipperMessages.objects.filter(owner=request.user, is_active=True, is_deleted=False)
		express_bill_accounts = postage_models.ExpressBillAccounts.objects.filter(id=express_id, is_deleted=False)
		
		sender = {
			"Name" : shipper_messages[0].shipper_name,
			"Mobile" : shipper_messages[0].tel_number,
			"ProvinceName" : shipper_messages[0].province,
			"CityName" : shipper_messages[0].city,
			"ExpAreaName" : shipper_messages[0].district,
			"Address" : shipper_messages[0].address,
		}

		CustomerName = express_bill_accounts[0].customer_name
		CustomerPwd = express_bill_accounts[0].customer_pwd
		MonthCode = express_bill_accounts[0].logistics_number
		SendSite = express_bill_accounts[0].sendsite
		express_company_name_value = express_bill_accounts[0].express_name

		templates = []
		order_ids = order_ids.split(',')
		for order_id in order_ids:
			commodity = [] #需传递的商品信息
			orders = getOrderDetail(order_id, request)
			products = json.loads(orders[0]['products'])
			for product in products:
				goods = {"GoodsName":product['product_name'], "Goodsquantity":product['count'], "GoodsCode":product['user_code']}
				commodity.append(goods)
			ship_area = orders[0]['ship_area']
			if ship_area:
				ship_area = ship_area.split(' ')
				ProvinceName = ship_area[0]
				CityName = ship_area[1]
				ExpAreaName = ship_area[2]
			receiver = {
				"Name":orders[0]['ship_name'], 
				"Mobile": orders[0]['ship_tel'], 
				"ProvinceName" : ProvinceName, 
				"CityName" : CityName, 
				"ExpAreaName" : ExpAreaName,
				"Address" : orders[0]['ship_address']
			}
			orderCode = orders[0]['order_id']
			order_id = orders[0]['id']
			LogisticCode = orders[0]['express_number']

			#订单状态 待发货
			status = orders[0]['status']
			if status==3:
				eorder=KdniaoExpressEorder(orderCode, express_company_name_value, sender, receiver, commodity, order_id, CustomerName, CustomerPwd, MonthCode, SendSite, LogisticCode)
				is_success, template, express_order, reason = eorder.get_express_eorder()
				templates.append({'template': template})

		data = {
			'templates': json.dumps(templates),
			'is_success': is_success,
			'reason': reason
		}
		response = create_response(200)
		response.data = data
		return response.get_response()