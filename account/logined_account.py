# -*- coding: utf-8 -*-

import json
from datetime import datetime

from django.http import HttpResponseRedirect, HttpResponse
from django.template import RequestContext
from django.shortcuts import render_to_response
from django.contrib.auth.decorators import login_required
from django.contrib import auth
from account.models import *

from core import resource
from core.jsonresponse import create_response

class LoginedAccount(resource.Resource):
	"""
	登录页面
	"""
	app = 'account'
	resource = 'logined_account'
	
	def put(request):
		username = request.POST.get('username', 'empty_username')
		password = request.POST.get('password', 'empty_password')
		user = auth.authenticate(username=username, password=password)
		if user:
			auth.login(request, user)
			user_profile = UserProfile.objects.filter(user_id=user.id)
			if user_profile:
				role = user_profile[0].role
				if role == MANAGER:
					return HttpResponseRedirect('/manager/account/')
				elif role == CUSTOMER:
					return HttpResponseRedirect('/order/customer_orders_list/')
				elif role == AGENCY:
					return HttpResponseRedirect('/order/yunying_orders_list/')
				elif role == YUN_YING:
					return HttpResponseRedirect('/order/yunying_orders_list/')
				else:
					return HttpResponseRedirect('/order/yunying_orders_list/')
			else:
				return HttpResponseRedirect('/order/yunying_orders_list/')
		else:
			c = RequestContext(request, {
				'errorMsg': u'用户名或密码错误'
			})
			return render_to_response('account/login.html', c)
