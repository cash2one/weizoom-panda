# -*- coding: utf-8 -*-
import json
import time
import requests
from django.http import HttpResponseRedirect, HttpResponse
from django.template import RequestContext
from django.shortcuts import render_to_response
from django.db.models import F
from django.contrib.auth.decorators import login_required
from django.contrib import auth

from core import resource
from core.jsonresponse import create_response
from core import paginator
from core.exceptionutil import unicode_full_stack

from util import db_util
from resource import models as resource_models
from account.models import *
from util import string_util
import nav
import models

class OrderShipInformations(resource.Resource):
	app = 'order'
	resource = 'order_ship_informations'

	@login_required
	def api_get(request):
		order_id = request.GET.get('order_id',0)
		#组装数据
		rows = {}
		rows['ship_company'] = 'shentong'
		rows['ship_number'] = '2016002157544125'
		rows['shiper_name'] = '小张'

		data = {
			'rows': rows
		}
		#构造response
		response = create_response(200)
		response.data = data
		return response.get_response()

	@login_required
	def api_put(request):
		#给接口传递发货的参数
		leader_name = request.POST.get('leader_name','')
		__method = request.POST.get('__method','')
		params = {
			'order_id' : request.POST.get('order_id',''),
			'express_company_name' : request.POST.get('express_company_name',''),
			'express_number' : request.POST.get('express_number',''),
			'leader_name' : leader_name,
			'operator_name' : request.user.username
		}
		print('params!!!!!!!!!!!')
		print(params)
		# params = json.dumps(params)
		if __method == 'put':
			#发货
			r = requests.post('http://api.zeus.com/mall/delivery/?_method=put',data=params)
		else:
			#修改物流
			r = requests.post('http://api.zeus.com/mall/delivery/?_method=post',data=params)
		res = json.loads(r.text)
		print('res!!!!!!!')
		print(res)
		if res['data']['result'] == u'SUCCESS':
			response = create_response(200)
			return response.get_response()
		else:
			response = create_response(500)
			response.errMsg = res['data']['msg']
			return response.get_response()

class OrderCompleteShip(resource.Resource):
	app = 'order'
	resource = 'order_complete_ship'

	@login_required
	def api_post(request):
		#修改订单状态（目前仅支持完成）
		params = {
			'order_id' : request.POST.get('order_id',''),
			'action' : 'finish',
			'operator_name' : request.user.username
		}
		r = requests.post('http://api.zeus.com/mall/order/?_method=post',data=params)
		res = json.loads(r.text)
		print('res!!!!!!!')
		print(res)
		if res['data']['result'] == u'SUCCESS':
			response = create_response(200)
			return response.get_response()
		else:
			response = create_response(500)
			response.errMsg = res['data']['msg']
			return response.get_response()